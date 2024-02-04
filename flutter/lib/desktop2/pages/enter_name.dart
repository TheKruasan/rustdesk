import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hbb/desktop2/pages/add_photo.dart';

class EnterPage extends StatefulWidget {
  const EnterPage({super.key});

  @override
  State<EnterPage> createState() => _EnterPageState();
}

class _EnterPageState extends State<EnterPage> {
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
        fontSize: 18, fontFamily: 'Manrope', color: Colors.grey,height: 2);
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
            Text("Как вас зовут?", style: style1),
            Container(
              height: 10,
            ),
            Container(
              width: 398,
              height: 52,
              child: TextField(
                obscureText: isObscure,
                style: style5,
                decoration: InputDecoration(
                  prefix: const Text("   "),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 10),
                  ),
                  hintStyle: const TextStyle(color: Colors.grey),
                  hintText: "Введите имя",
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              ),
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
                          side: BorderSide(color:Color(0xFF7700FF)))),
                  backgroundColor: MaterialStatePropertyAll(Color(0xFF7700FF)),
                  overlayColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 153, 74, 243)),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context) => AddPhotoPage(img:Image.asset("assets/images/user.png") ,)));
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
                        style: style4,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
