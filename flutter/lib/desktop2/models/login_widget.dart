import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hbb/common.dart';
import 'package:flutter_hbb/desktop2/widgets/auth_button.dart';
import 'package:flutter_hbb/models/platform_model.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ConfigOP {
  final String op;
  final String? icon;
  ConfigOP({required this.op, required this.icon});
}

class LoginWidgetOP extends StatelessWidget {
  final List<ConfigOP> ops;
  final RxString curOP;
  final Function(Map<String, dynamic>) cbLogin;

  LoginWidgetOP({
    Key? key,
    required this.ops,
    required this.curOP,
    required this.cbLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var children = ops
        .map((op) => [
              WidgetOP(
                config: op,
                curOP: curOP,
                cbLogin: cbLogin,
              ),
              const Divider(
                indent: 5,
                endIndent: 5,
              )
            ])
        .expand((i) => i)
        .toList();
    if (children.isNotEmpty) {
      children.removeLast();
    }
    return SingleChildScrollView(
        child: Container(
            width: 398,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: children,
            )));
  }
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
      children: [// TODO убрать ее при нажатии cupOp == op
        WhiteButton(
          text: widget.config.op,
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
