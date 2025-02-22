// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hbb/common.dart';
// import 'package:flutter_hbb/consts.dart';
// import 'package:flutter_hbb/desktop/pages/desktop_home_page.dart';
// import 'package:flutter_hbb/desktop/pages/desktop_setting_page.dart';
// import 'package:flutter_hbb/desktop/widgets/tabbar_widget.dart';
// import 'package:flutter_hbb/desktop2/pages/desktop_page.dart';
// import 'package:flutter_hbb/desktop2/pages/registration_page.dart';
// import 'package:flutter_hbb/desktop2/pages/remote_access.dart';
// import 'package:flutter_hbb/models/state_model.dart';
// import 'package:get/get.dart';
// import 'package:window_manager/window_manager.dart';

// import '../../common/shared_state.dart';

// class DesktopTabPage extends StatefulWidget {
//   const DesktopTabPage({Key? key}) : super(key: key);

//   @override
//   State<DesktopTabPage> createState() => _DesktopTabPageState();

//   static void onAddSetting({int initialPage = 0}) {
//     try {
//       DesktopTabController tabController = Get.find();
//       tabController.add(TabInfo(
//           key: kTabLabelSettingPage,
//           label: kTabLabelSettingPage,
//           selectedIcon: Icons.build_sharp,
//           unselectedIcon: Icons.build_outlined,
//           page: DesktopSettingPage(
//             key: const ValueKey(kTabLabelSettingPage),
//             initialPage: initialPage,
//           )));
//     } catch (e) {
//       debugPrintStack(label: '$e');
//     }
//   }

//   // static void onAddReg({int initialPage = 0}) {
//   //   try {
//   //     DesktopTabController tabController = Get.find();
//   //     tabController.add(TabInfo(
//   //         key: kTabLabelRegistrationPage,
//   //         label: kTabLabelRegistrationPage,
//   //         selectedIcon: CupertinoIcons.add,
//   //         unselectedIcon: CupertinoIcons.add_circled,
//   //         page: RegistrationPage(
//   //           key: const ValueKey(kTabLabelRegistrationPage),
//   //           // initialPage: initialPage,
//   //         )));
//   //   } catch (e) {
//   //     debugPrintStack(label: '$e');
//   //   }
//   // }
// }

// class _DesktopTabPageState extends State<DesktopTabPage> {
//   final tabController = DesktopTabController(tabType: DesktopTabType.main);

//   @override
//   void initState() {
//     super.initState();
//     Get.put<DesktopTabController>(tabController);
//     RemoteCountState.init();
//     tabController.add(
//       TabInfo(
//         key: kTabLabelHomePage,
//         label: kTabLabelHomePage,
//         selectedIcon: Icons.home_sharp,
//         unselectedIcon: Icons.home_outlined,
//         closable: false,
//         page: RemoteAccessPage()
//         // page: DesktopHomePage(
//         //   key: const ValueKey(kTabLabelHomePage),
//         // ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     Get.delete<DesktopTabController>();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final tabWidgetReg = Container(
//     //     child: Scaffold(
//     //         backgroundColor: Theme.of(context).colorScheme.background,
//     //         body: DesktopTab(
//     //           controller: tabController,
//     //           tail: ActionIcon(
//     //             message: 'Sign in',
//     //             icon: CupertinoIcons.add,
//     //             onTap: DesktopTabPage.onAddReg,
//     //             isClose: false,
//     //           ),
//     //         )));
//     // final tabWidget = Container(
//     //   child: Scaffold(
//     //     backgroundColor: Theme.of(context).colorScheme.background,
//     //     // body: Row(
//     //     // children: [
//     //     body: DesktopTab(
//     //       controller: tabController,
//     //       tail: ActionIcon(
//     //         message: 'Settings',
//     //         icon: IconFont.menu,
//     //         onTap: DesktopTabPage.onAddSetting,
//     //         isClose: false,
//     //       ),
//     //     ),
//     //     //  DesktopTab(
//     //     //   controller: tabController,
//     //     //   tail: ActionIcon(
//     //     //     message: 'Settings',
//     //     //     icon: IconFont.menu,
//     //     //     onTap: DesktopTabPage.onAddSetting,
//     //     //     isClose: false,
//     //     //   ),
//     //     // ),
//     //     // ],
//     //     // ),
//     //   ),
//     // );
//     return Platform.isMacOS || kUseCompatibleUiMode
//         // ? Row(children: [ tabWidget, ])
//         ? tabWidgetReg
//         : Obx(
//             () => DragToResizeArea(
//               resizeEdgeSize: stateGlobal.resizeEdgeSize.value,
//               // child: Row(children: [ tabWidget, ]),
//               child: tabWidgetReg,
//             ),
//           );
//   }
// }
