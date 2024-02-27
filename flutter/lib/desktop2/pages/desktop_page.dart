import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hbb/common.dart';
import 'package:flutter_hbb/desktop2/widgets/user_info.dart';
import 'package:flutter_hbb/models/state_model.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';
import '../models/bar_model.dart';

class RemoteAccessPage extends StatefulWidget {
  const RemoteAccessPage({super.key});

  @override
  State<RemoteAccessPage> createState() => _RemoteAccessPageState();
}

class _RemoteAccessPageState extends State<RemoteAccessPage> {
  int selected = 0;
  List<menuItem> backMenuIcons = [
    menuItem(Image.asset("assets/images/category.png"), "Главная"),
    menuItem(Image.asset("assets/images/hashtag.png"), "Автоматизации"),
    menuItem(Image.asset("assets/images/wifi.png"), "Удаленный доступ"),
  ];
  List<menuItem> botMenuIcons = [
    menuItem(Image.asset("assets/images/messages-2.png"), "Обратная связь"),
    menuItem(Image.asset("assets/images/flash.png"), "О Manuspect"),
    menuItem(Image.asset("assets/images/2user.png"), "Друзья"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildLeftPane(context));
  }

  Widget buildLeftPane(BuildContext context) {
    return Container(
      color: const Color(0xff000000),
      child: Row(
        children: [
          leftMenu(context),
          Expanded(
            child: Column(
              children: [
                topMenu(context),
                Expanded(
                  child: Container(
                    color: const Color(0xff000000),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget topMenu(BuildContext context) { 
        return Container(
            height: 60,
            decoration: const BoxDecoration(
              color: Color(0xff0B0C10),
            ),
          );
        // : Obx(
        //     () => DragToResizeArea(
        //       resizeEdgeSize: stateGlobal.resizeEdgeSize.value,
        //       child: Container(
        //         height: 60,
        //         decoration: const BoxDecoration(
        //           color: Color(0xff0B0C10),
        //         ),
        //       ),
        //     ),
        //   );
  }

  Widget leftMenu(BuildContext context) {
    return Container(
      width: 250,
      padding: EdgeInsets.only(top: 20, bottom: 10),
      decoration: const BoxDecoration(
        color: Color(0xff0B0C10),
        borderRadius: BorderRadius.only(
          // topRight: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 11,
            child: Container(
              child: ListView.builder(
                  itemCount: backMenuIcons.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      decoration: BoxDecoration(
                        color: selected == index
                            ? Color(0xff13141C)
                            : Color(0x00000000),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ListTile(
                        hoverColor: Colors.white,
                        onTap: () {},
                        leading: backMenuIcons[index].icon,
                        title: Text(
                          backMenuIcons[index].text,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff917DAC),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: ListView.builder(
                  itemCount: botMenuIcons.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      decoration: BoxDecoration(
                        color: selected == index + 3
                            ? Color(0xff13141C)
                            : Color(0x00000000),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ListTile(
                        hoverColor: Colors.white,
                        onTap: () {},
                        leading: botMenuIcons[index].icon,
                        title: Text(
                          botMenuIcons[index].text,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff917DAC),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Expanded(
              child: Container(
            child: UserInfo(),
            padding: EdgeInsets.only(right: 8),
          )),
        ],
      ),
    );
  }
}
