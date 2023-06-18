import 'package:UAS_project/Grup1/viewfile1.dart';
import 'package:UAS_project/Grup1/home1.dart';
import 'package:UAS_project/Grup1/input1.dart';
import 'package:UAS_project/Grup1/view1.dart';
import 'package:UAS_project/Grup1/update1.dart';
import 'package:UAS_project/services/auth_service.dart';
import 'package:get/get.dart';
// import 'package:haruka1_0/app/data/providers/auth_service.dart';
// import 'package:haruka1_0/app/modules/awg/views/awg_view.dart';
import 'package:flutter/material.dart';

import '../controller/navbar_controller.dart';
// import 'package:haruka1_0/app/modules/home/views/home_view.dart';
// import 'package:haruka1_0/app/modules/account/views/account_view.dart';
// import 'package:haruka1_0/app/modules/apg/views/apg_view.dart';
// import 'package:haruka1_0/app/modules/dh_har/views/dbhar_view.dart';
// import 'package:haruka1_0/app/modules/navbar/controller/navbar_controller.dart';

class NavBarView1 extends StatelessWidget {
  NavBarView1({Key? key}) : super(key: key);

  final _controller = Get.put(NavBarController());

  final List<Widget> _listPage = [
    home1(),
    baca1(),
    update1(),
    crud1(),
    ImageView()
    // RE_1108780030(),
    // Tulis1108780030()
  ];

  // final List<String> _listTitleAppBar = const [
  //   'Home',
  //   'Page-1',
  //   'Page-2',
  //   'CRUD',
  //   'New CRUD'
  //   // 'Page-4'
  // ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   title: Text("Test"),
        //   actions: <Widget>[
        //     IconButton(
        //       icon: const Icon(
        //         Icons.exit_to_app,
        //         color: Colors.white,
        //       ),
        //       onPressed: () {
        //         _showAlertDialog(context);
        //         // AuthService.signOut();
        //         // Navigator.pop(context);
        //       },
        //     ),
        //   ],
        // ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.indigo[900],
          currentIndex: _controller.currentTab.value,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.view_list_rounded), label: 'View Data'),
            BottomNavigationBarItem(
                icon: Icon(Icons.system_update), label: 'Update Data'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline_rounded),
                label: 'Input Data'),
            BottomNavigationBarItem(
                icon: Icon(Icons.photo), label: 'View Photo'),
          ],
          onTap: (value) => _controller.pageChange(value),
        ),
        body: _listPage.elementAt(_controller.currentTab.value),
      ),
    );
  }

  _showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Batal"),
      onPressed: () => Get.back(),
    );
    Widget continueButton = TextButton(
      child: const Text("Ya"),
      onPressed: () async {
        Get.back();
        AuthService.signOut();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Konfirmasi"),
      content: const Text("Apakah Anda yakin ingin log out?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
