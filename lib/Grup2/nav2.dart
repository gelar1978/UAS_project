import 'package:UAS_project/Grup2/Cek.dart';
import 'package:UAS_project/Grup2/crud2_upd.dart';
import 'package:UAS_project/Grup2/folderView.dart';
import 'package:UAS_project/Grup2/imageView2_W.dart';
import 'package:UAS_project/Grup2/write2.dart';
import 'package:UAS_project/Grup2/baca2.dart';
import 'package:UAS_project/Grup2/crud2.dart';
import 'package:UAS_project/Grup2/hal2.dart';
import 'package:UAS_project/Grup2/read_edit2.dart';
import 'package:UAS_project/Grup2/viewdata2.dart';
import 'package:UAS_project/Grup2/home2.dart';
import 'package:UAS_project/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../controller/navbar_controller.dart';

class NavBarView extends StatefulWidget {
  NavBarView({Key? key}) : super(key: key);

  @override
  State<NavBarView> createState() => _NavBarViewState();
}

class _NavBarViewState extends State<NavBarView> {
  final _controller = Get.put(NavBarController());

  final List<Widget> _listPage = [
    home2(),
    baca2(),
    crud2_upd(),
    crud2(),
    folderView2(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _controller.currentTab.value,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.assignment), label: 'View Data'),
            BottomNavigationBarItem(
                icon: Icon(Icons.update), label: 'Update Data'),
            BottomNavigationBarItem(
                icon: Icon(Icons.input_outlined), label: 'Input Data'),
            BottomNavigationBarItem(
                icon: Icon(Icons.view_array), label: 'View File'),
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
