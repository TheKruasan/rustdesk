import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hbb/common/hbbs/hbbs.dart';
import 'package:flutter_hbb/common/widgets/login.dart';
import 'package:flutter_hbb/models/platform_model.dart';
import 'package:get/get.dart';

import '../../common.dart';
import 'password_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextStyle style1 = const TextStyle(
      fontSize: 32,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700,
      color: Colors.white);
  TextStyle style2 = const TextStyle(fontSize: 16, fontFamily: 'Manrope');
  TextStyle style3 =
      const TextStyle(fontSize: 16, fontFamily: 'Manrope', color: Colors.white);
  final TextStyle style4 =
       TextStyle(fontSize: 18, fontFamily: 'Manrope', color: Colors.grey,height:1.5);
  final RxString curOP = ''.obs;
  final loginOptions = [
    {"name": "google"},
    {"name": "github"},
    {"name": "telegram"}
  ].obs;

  var isInProgress = false;
  String? passwordMsg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Back")),
            Text("Вход или регистрация", style: style1),
            Container(
              height: 20,
            ),
            Container(
              width: 398,
              height: 62,
              child: TextField(
                style: style4,
                decoration:  InputDecoration(
                  prefix: Text("   "),
                  hintStyle: style4,
                  hintText: "E-mail",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              ),
            ),
            Container(
              height: 20,
            ),
            Container(
              width: 398,
              height: 52,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(color: Color(0xFF7700FF)))),
                  backgroundColor: MaterialStatePropertyAll(Color(0xFF7700FF)),
                  overlayColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 153, 74, 243)),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PasswordPage()));
                },
                child: Container(
                  margin: EdgeInsets.only(right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_forward_sharp,
                        color: Colors.white,
                      ),
                      Container(
                        width: 15,
                      ),
                      Text(
                        "Продолжить",
                        style: style3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(height: 25),
            Container(
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
                            .map((e) =>
                                ConfigOP(op: e['name']!, icon: e['icon']))
                            .toList(),
                        curOP: curOP,
                        cbLogin: (Map<String, dynamic> authBody) async {
                          LoginResponse? resp;
                          try {
                            // access_token is already stored in the rust side.
                            resp = gFFI.userModel
                                .getLoginResponseFromAuthBody(authBody);
                          } catch (e) {
                            debugPrint(
                                'Failed to parse oidc login body: "$authBody"');
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
            )
            // Container(
            //   decoration: BoxDecoration(
            //     border: Border.all(color: Colors.white),
            //     borderRadius: BorderRadius.circular(30),
            //   ),
            //   width: 398,
            //   height: 52,
            //   child: ElevatedButton(
            //     style: ButtonStyle(
            //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //           RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(30.0),
            //               side: BorderSide(
            //                   color: Color.fromARGB(157, 200, 192, 209)))),
            //       backgroundColor:
            //           MaterialStatePropertyAll(Color.fromARGB(0, 119, 0, 255)),
            //       overlayColor: MaterialStatePropertyAll(
            //           Color.fromARGB(157, 200, 192, 209)),
            //     ),
            //     onPressed: () {},
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Icon(
            //           Icons.apple,
            //           color: Colors.white,
            //         ),
            //         Container(
            //           width: 15,
            //         ),
            //         Text(
            //           "Продолжить c Apple ID",
            //           style: style3,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // Container(
            //   height: 10,
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //     border: Border.all(color: Colors.white),
            //     borderRadius: BorderRadius.circular(30),
            //   ),
            //   width: 398,
            //   height: 52,
            //   child: ElevatedButton(
            //     style: ButtonStyle(
            //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //           RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(30.0),
            //               side: BorderSide(
            //                   color: Color.fromARGB(157, 200, 192, 209)))),
            //       backgroundColor:
            //           MaterialStatePropertyAll(Color.fromARGB(0, 119, 0, 255)),
            //       overlayColor: MaterialStatePropertyAll(
            //           Color.fromARGB(157, 200, 192, 209)),
            //     ),
            //     onPressed: () {},
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         SvgPicture.asset("assets/auth-google.svg"),
            //         Container(
            //           width: 15,
            //         ),
            //         Text(
            //           "Продолжить c Google",
            //           style: style3,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
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
}
