import 'package:flutter/material.dart';


class UserInfo extends StatelessWidget {
  final String name = "Никита Корчагин";
  final String email = "@uxkorchagin";
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/user.png"),
        Container(width: 10,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name, style: TextStyle(fontSize: 12, color: Color(0xff917DAC),)),
            Text(email , style: TextStyle(fontSize: 16,color: Colors.white),),
          ],
        ),
        IconButton(onPressed: (){}, icon: Icon(Icons.keyboard_arrow_down,color:Color(0xff917DAC) ,),),
      ],

    );
  }
}