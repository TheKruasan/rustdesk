import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hbb/common/hbbs/hbbs.dart';
import 'package:flutter_hbb/common/widgets/login.dart';
import 'package:flutter_hbb/desktop/pages/desktop_tab_page.dart';
import 'package:flutter_hbb/desktop2/widgets/third_auth.dart';
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
  late PageController controller;
  late RxInt selectedIndex;

  TextStyle style1 = const TextStyle(
      fontSize: 32,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700,
      color: Colors.white);
  TextStyle style2 = const TextStyle(fontSize: 16, fontFamily: 'Manrope');
  TextStyle style3 =
      const TextStyle(fontSize: 16, fontFamily: 'Manrope', color: Colors.white);
  final TextStyle style4 = TextStyle(
      fontSize: 18, fontFamily: 'Manrope', color: Colors.grey, height: 1.5);
  final RxString curOP = ''.obs;
  final loginOptions = [
    {"name": "google"},
    {"name": "github"},
    {"name": "telegram"}
  ].obs;

  var isInProgress = false;
  String? passwordMsg;

  @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Вход или регистрация", style: style1),
            Container(
              height: 20,
            ),
            Container(
              width: 398,
              height: 62,
              child: TextField(
                style: style4,
                decoration: InputDecoration(
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
            thirdAuth(),
          ],
        ),
      ),
    );
  }

  
}
