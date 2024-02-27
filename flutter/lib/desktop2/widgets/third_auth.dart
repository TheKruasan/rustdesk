import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hbb/models/platform_model.dart';
import 'package:flutter_hbb/common.dart';
import 'package:flutter_hbb/common/hbbs/hbbs.dart';
import 'package:flutter_hbb/common/widgets/login.dart';
import 'package:flutter_hbb/desktop2/models/login_widget.dart';
import 'package:flutter_hbb/desktop2/widgets/auth_button.dart';
import 'package:flutter_hbb/models/user_model.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


class thirdAuth extends StatefulWidget {
  thirdAuth({super.key});

  @override
  State<thirdAuth> createState() => _thirdAuthState();
}

class _thirdAuthState extends State<thirdAuth> {
   var username =
      TextEditingController(text: UserModel.getLocalUserInfo()?['name'] ?? '');
  var password = TextEditingController();
  final userFocusNode = FocusNode()..requestFocus();

  String? usernameMsg;
  String? passwordMsg;
  var isInProgress = false;
  final RxString curOP = ''.obs;

  final loginOptions = [
    {"name": "google"},
    {"name": "github"},
    {"name": "telegram"}
  ].obs;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(() {
        return Offstage(
          offstage: loginOptions.isEmpty,
          child: Column(
            children: [
              const SizedBox(
                height: 8.0,
              ),
              Center(
                  child: Text(
                translate('or'),
                style: TextStyle(fontSize: 16),
              )),
              const SizedBox(
                height: 8.0,
              ),
              LoginWidgetOP(
                ops: loginOptions
                    .map((e) => ConfigOP(op: e['name']!, icon: e['icon']))
                    .toList(),
                curOP: curOP,
                cbLogin: (Map<String, dynamic> authBody) async {
                  LoginResponse? resp;
                  try {
                    // access_token is already stored in the rust side.
                    resp =
                        gFFI.userModel.getLoginResponseFromAuthBody(authBody);
                  } catch (e) {
                    debugPrint('Failed to parse oidc login body: "$authBody"');
                  }
                  // close(true); закрытие окна

                  if (resp != null) {
                    handleLoginResponse(resp, false, null);
                  }
                },
              ),
            ],
          ),
        );
      }),
    );
  }

   handleLoginResponse(LoginResponse resp, bool storeIfAccessToken,
      void Function([dynamic])? close) async {
    switch (resp.type) {
      case HttpType.kAuthResTypeToken:
        if (resp.access_token != null) {
          if (storeIfAccessToken) {
            await bind.mainSetLocalOption(
                key: 'access_token', value: resp.access_token!);
            await bind.mainSetLocalOption(
                key: 'user_info', value: jsonEncode(resp.user ?? {}));
          }
          if (close != null) {
            close(true);
          }
          return;
        }
        break;
      case HttpType.kAuthResTypeEmailCheck:
        bool? isEmailVerification;
        if (resp.tfa_type == null ||
            resp.tfa_type == HttpType.kAuthResTypeEmailCheck) {
          isEmailVerification = true;
        } else if (resp.tfa_type == HttpType.kAuthResTypeTfaCheck) {
          isEmailVerification = false;
        } else {
          passwordMsg = "Failed, bad tfa type from server";
        }
        if (isEmailVerification != null) {
          if (isMobile) {
            if (close != null) close(false);
            verificationCodeDialog(resp.user, isEmailVerification);
          } else {
            setState(() => isInProgress = false);
            final res =
                await verificationCodeDialog(resp.user, isEmailVerification);
            if (res == true) {
              if (close != null) close(false);
              return;
            }
          }
        }
        break;
      default:
        passwordMsg = "Failed, bad response from server";
        break;
    }
  }

  // thirdAuthWidget() => Obx(() {
  //       return Offstage(
  //         offstage: loginOptions.isEmpty,
  //         child: Column(
  //           children: [
  //             const SizedBox(
  //               height: 8.0,
  //             ),
  //             Center(
  //                 child: Text(
  //               translate('or'),
  //               style: TextStyle(fontSize: 16),
  //             )),
  //             const SizedBox(
  //               height: 8.0,
  //             ),
  //             LoginWidgetOP(
  //               ops: loginOptions
  //                   .map((e) => ConfigOP(op: e['name']!, icon: e['icon']))
  //                   .toList(),
  //               curOP: curOP,
  //               cbLogin: (Map<String, dynamic> authBody) async {
  //                 LoginResponse? resp;
  //                 try {
  //                   // access_token is already stored in the rust side.
  //                   resp =
  //                       gFFI.userModel.getLoginResponseFromAuthBody(authBody);
  //                 } catch (e) {
  //                   debugPrint('Failed to parse oidc login body: "$authBody"');
  //                 }
  //                 // close(true);

  //                 if (resp != null) {
  //                   handleLoginResponse(resp, false, null);
  //                 }
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     });

}

class WidgetOP extends StatefulWidget {
  final ConfigOP config;
  final RxString curOP;
  final Function(Map<String, dynamic>) cbLogin;
  const WidgetOP({
    Key? key,
    required this.config,
    required this.curOP,
    required this.cbLogin,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WidgetOPState();
  }
}

class _WidgetOPState extends State<WidgetOP> {

 

  Timer? _updateTimer;
  String _stateMsg = '';
  String _failedMsg = '';
  String _url = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _updateTimer?.cancel();
  }

  _beginQueryState() {
    _updateTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateState();
    });
  }

  _updateState() {
    bind.mainAccountAuthResult().then((result) {
      if (result.isEmpty) {
        return;
      }
      final resultMap = jsonDecode(result);
      if (resultMap == null) {
        return;
      }
      final String stateMsg = resultMap['state_msg'];
      String failedMsg = resultMap['failed_msg'];
      final String? url = resultMap['url'];
      final authBody = resultMap['auth_body'];
      if (_stateMsg != stateMsg || _failedMsg != failedMsg) {
        if (_url.isEmpty && url != null && url.isNotEmpty) {
          launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
          _url = url;
        }
        if (authBody != null) {
          _updateTimer?.cancel();
          widget.curOP.value = '';
          widget.cbLogin(authBody as Map<String, dynamic>);
        }

        setState(() {
          _stateMsg = stateMsg;
          _failedMsg = failedMsg;
          if (failedMsg.isNotEmpty) {
            widget.curOP.value = '';
            _updateTimer?.cancel();
          }
        });
      }
    });
  }

  _resetState() {
    _stateMsg = '';
    _failedMsg = '';
    _url = '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TODO убрать ее при нажатии cupOp == op
        WhiteButton(
          text: "Continue with",
          op: widget.config.op,
          curOP: widget.curOP,
          icon: widget.config.icon,
          height: 52,
          onTap: () async {
            _resetState();
            widget.curOP.value = widget.config.op;
            await bind.mainAccountAuth(op: widget.config.op, rememberMe: true);
            _beginQueryState();
          },
        ),

        // ButtonOP(
        //   op: widget.config.op,
        //   curOP: widget.curOP,
        //   icon: widget.config.icon,
        //   primaryColor: str2color(widget.config.op, 0x7f),
        //   height: 36,
        //   onTap: () async {
        //     _resetState();
        //     widget.curOP.value = widget.config.op;
        //     await bind.mainAccountAuth(op: widget.config.op, rememberMe: true);
        //     _beginQueryState();
        //   },
        // ),
        Obx(() {
          if (widget.curOP.isNotEmpty &&
              widget.curOP.value != widget.config.op) {
            _failedMsg = '';
          }
          return Offstage(
            offstage:
                _failedMsg.isEmpty && widget.curOP.value != widget.config.op,
            child: RichText(
              text: TextSpan(
                text: '$_stateMsg  ',
                style:
                    DefaultTextStyle.of(context).style.copyWith(fontSize: 12),
                children: <TextSpan>[
                  TextSpan(
                    text: _failedMsg,
                    style: DefaultTextStyle.of(context).style.copyWith(
                          fontSize: 14,
                          color: Colors.red,
                        ),
                  ),
                ],
              ),
            ),
          );
        }),
        Obx(
          () => Offstage(
            offstage: widget.curOP.value != widget.config.op,
            child: const SizedBox(
              height: 5.0,
            ),
          ),
        ),
        Obx(
          () => Offstage(
            offstage: widget.curOP.value != widget.config.op,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 20),
              child: ElevatedButton(
                onPressed: () {
                  widget.curOP.value = '';
                  _updateTimer?.cancel();
                  _resetState();
                  bind.mainAccountAuthCancel();
                },
                child: Text(
                  translate('Cancel'),
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

 
}
