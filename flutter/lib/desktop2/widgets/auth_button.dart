import 'package:flutter/material.dart';
import 'package:flutter_hbb/common.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

TextStyle style3 =
    const TextStyle(fontSize: 16, fontFamily: 'Manrope', color: Colors.white);
const kOpSvgList = [
  'github',
  'gitlab',
  'google',
  'apple',
  'okta',
  'facebook',
  'azure',
  'auth0'
];

class WhiteButton extends StatelessWidget {

final String op;
  final String text;
  final RxString curOP;
  final String? icon;
  final Color? primaryColor;
  final double height;
  final Function() onTap;

  const WhiteButton({
    Key? key,
    required this.text,
    required this.op,
    required this.curOP,
    required this.icon,
    this.primaryColor,
    required this.height,
    required this.onTap,
  }) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
     final opLabel = {
          'github': 'GitHub',
          'gitlab': 'GitLab'
        }[op.toLowerCase()] ??
        toCapitalized(op);


    return Container(
        width: 398,
        height: height,
        child: Obx(
          () => ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(
                          color: Color.fromARGB(157, 200, 192, 209)))),
              backgroundColor:
                  MaterialStatePropertyAll(Color.fromARGB(0, 119, 0, 255)),
              overlayColor:
                  MaterialStatePropertyAll(Color.fromARGB(157, 200, 192, 209)),
            ),
            onPressed: curOP.value.isEmpty || curOP.value == op ? onTap : null,
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                  child: _IconOP(
                    op: op,
                    icon: icon,
                    margin: EdgeInsets.only(right: 5),
                  ),
                ),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Center(
                        child: Text('$text $opLabel')),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}




class _IconOP extends StatelessWidget {
  final String op;
  final String? icon;
  final EdgeInsets margin;
  const _IconOP(
      {Key? key,
      required this.op,
      required this.icon,
      this.margin = const EdgeInsets.symmetric(horizontal: 4.0)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final svgFile =
        kOpSvgList.contains(op.toLowerCase()) ? op.toLowerCase() : 'default';
    return Container(
      margin: margin,
      child: icon == null
          ? SvgPicture.asset(
              'assets/auth-$svgFile.svg',
              width: 20,
            )
          : SvgPicture.string(
              icon!,
              width: 20,
            ),
    );
  }
}