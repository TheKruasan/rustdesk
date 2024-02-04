import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hbb/desktop2/pages/create_password.dart';

class AddPhotoPage extends StatefulWidget {
  Image img;
  AddPhotoPage({required this.img, super.key});

  @override
  State<AddPhotoPage> createState() => _AddPhotoPageState();
}

class _AddPhotoPageState extends State<AddPhotoPage> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    const double? sizeOfBackButton = 15;
    TextStyle style1 = const TextStyle(
        fontSize: 32,
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w700,
        color: Colors.white);
    TextStyle style2 = const TextStyle(fontSize: 16, fontFamily: 'Manrope');
    TextStyle style3 = const TextStyle(
        fontSize: sizeOfBackButton, fontFamily: 'Manrope', color: Colors.white);
    TextStyle style4 = const TextStyle(
        fontSize: 16, fontFamily: 'Manrope', color: Colors.white);
    TextStyle style5 = const TextStyle(
        fontSize: 18, fontFamily: 'Manrope', color: Colors.grey, height: 2);
    return Scaffold(
      body: Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 420,
              height: 52,
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: sizeOfBackButton,
                        ),
                        Text(
                          "Назад",
                          style: style3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 30,
            ),
            Text("Загрузите аватарку", style: style1),
            Container(
              height: 10,
            ),
            Container(
              height: 150,
              child: widget.img,
            ),
            Container(height: 15),
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
                  Navigator.push(context, MaterialPageRoute(builder:(context) => CreatePasswordPage()));
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
                        "Готово",
                        style: style4,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(height: 15),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(30),
              ),
              width: 398,
              height: 52,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(
                              color: Color.fromARGB(157, 200, 192, 209)))),
                  backgroundColor:
                      MaterialStatePropertyAll(Color.fromARGB(0, 119, 0, 255)),
                  overlayColor: MaterialStatePropertyAll(
                      Color.fromARGB(157, 200, 192, 209)),
                ),
                onPressed: () {},
                child: Text(
                  "Пропустить",
                  style: style4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
