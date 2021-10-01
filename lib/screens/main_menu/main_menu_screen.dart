// import 'package:fiksii/components/firebase_state.dart';
// import 'package:fiksii/screens/main_menu/components/data_pesenan.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import 'components/body.dart';
//
// class MainMenu extends StatefulWidget {
//   MainMenu({Key? key}) : super(key: key);
//   static String routeName = "/main_screen";
//
//   @override
//   _MainMenuState createState() => _MainMenuState();
// }
//
// class _MainMenuState extends State<MainMenu> with TickerProviderStateMixin {
//
//   late AnimationController _ColorAnimationController;
//
//   late AnimationController _TextAnimationController;
//   late Animation _colorTween,
//       _homeTween,
//       _workOutTween,
//       _iconTween,
//       _drawerTween;
//
//   @override
//   void initState() {
//     _ColorAnimationController =
//         AnimationController(vsync: this, duration: Duration(seconds: 0));
//     _colorTween =
//         ColorTween(begin: Colors.transparent, end: Colors.white).animate(
//             _ColorAnimationController);
//     _iconTween =
//         ColorTween(begin: Colors.white, end: Colors.lightBlue.withOpacity(0.5))
//             .animate(_ColorAnimationController);
//     _drawerTween = ColorTween(begin: Colors.white, end: Colors.black).animate(
//         _ColorAnimationController);
//     _homeTween =
//         ColorTween(begin: Colors.white, end: Colors.blueAccent).animate(
//             _ColorAnimationController);
//     _workOutTween = ColorTween(begin: Colors.white, end: Colors.black).animate(
//         _ColorAnimationController);
//     _TextAnimationController =
//         AnimationController(vsync: this, duration: Duration(seconds: 0));
//
//     // TODO: implement initState
//     super.initState();
//   }
//
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
//
//   bool scrollListener(ScrollNotification scrollInfo) {
//     bool scroll = false;
//     if (scrollInfo.metrics.axis == Axis.vertical) {
//       _ColorAnimationController.animateTo(scrollInfo.metrics.pixels / 80);
//
//       _TextAnimationController.animateTo(scrollInfo.metrics.pixels);
//       return scroll = true;
//     }
//     return scroll;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       drawer: Drawer(),
//       backgroundColor: Color(0xFFEEEEEE),
//       body: NotificationListener<ScrollNotification>(
//         onNotification: scrollListener,
//         child: Stack(
//           children: [
//             Container(
//               height: double.infinity,
//               child: Stack(
//                 children: [
//                   SingleChildScrollView(
//                     child: Stack(
//                       children: [
//                         Column(
//                           children: [
//                             //more widget
//                             Container(height: 500, color: Colors.lightBlueAccent,),
//                             Consumer<FirebaseState>(builder:(context, value, child) {
//                               value.init();
//                               return Column(
//                                 children: [
//                                   Text((value.email != null) ? value.email! : ''),
//                                   TextButton(onPressed: () {
//                                     value.signOut();
//                                   }, child: Text('Log Out')),
//                                 ],
//                               );
//                             },),
//                             Consumer<DataPesenan>(
//                               builder: (context, value, child) {
//                                 return ReorderableListView(
//                                   children: value.listPesenan.map(
//                                       (pesenan) => Container(
//                                         key: Key('${value.listPesenan.indexOf(pesenan)}'),
//                                         padding: EdgeInsets.all(10),
//                                         margin: EdgeInsets.symmetric(vertical: 10),
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(20),
//                                           border: Border.all(color: Colors.yellow, width: 1)
//                                         ),
//                                         child: ListTile(
//                                           title: Text(
//                                             pesenan.jenisBarang,
//                                           ),
//                                         ),
//                                       )
//                                   ).toList(),
//                                   onReorder: (oldIndex, newIndex) {
//                                     if (oldIndex < newIndex) {
//                                       int end = newIndex -1;
//                                       Pesenan pesenan = value.listPesenan[oldIndex];
//                                       int i = 0;
//                                       int local = oldIndex;
//                                       do {
//                                         value.listPesenan[local] = value.listPesenan[++local];
//                                         i++;
//                                       } while (i < end - oldIndex);
//                                       value.listPesenan[end] = pesenan;
//                                     }
//
//                                     if (oldIndex > newIndex) {
//                                       Pesenan pesenan = value.listPesenan[oldIndex];
//                                       for (int i = oldIndex; i > newIndex; i--) {
//                                         value.listPesenan[i] = value.listPesenan[i-1];
//                                       }
//                                       value.listPesenan[newIndex] = pesenan;
//                                     }
//                                     setState(() {});
//                                   },
//                                 );
//                               },
//                             )
//                           ],
//                         )
//                         //more widget
//                       ],
//                     ),
//                   ),
//                   DashboardAppBar(
//                     colorAnimationController: _ColorAnimationController,
//                     colorTween: _colorTween,
//                     drawerTween: _drawerTween,
//                     iconTween: _iconTween,
//                     homeTween: _homeTween,
//                     workOutTween: _workOutTween,
//                     onPressed: () => scaffoldKey.currentState!.openDrawer(),
//                   ),
//                 ],
//               ),
//             ),
//             //more widget
//           ],
//         ),
//       ),
//     );
//   }
// }
