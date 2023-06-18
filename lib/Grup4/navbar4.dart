import 'package:UAS_project/Grup4/home4.dart';
import 'package:UAS_project/Grup4/input4.dart';
import 'package:UAS_project/Grup4/update4.dart';
import 'package:UAS_project/Grup4/view4.dart';
import 'package:UAS_project/Grup4/viewfile4.dart';
import 'package:UAS_project/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:UAS_project/controller/navbar_controller.dart';

class NavBarView extends StatelessWidget {
  NavBarView({Key? key}) : super(key: key);

  final _controller = Get.put(NavBarController());

  final List<Widget> _listPage = [
    home4(),
    view4(),
    input4(),
    update4(),
    foldercheck4(),
  ];

  final List<String> _listTitleAppBar = const [
    'Home',
    'View Data',
    'Input Data',
    'Update Data',
    'View Data W & H',
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
                icon: Icon(Icons.view_agenda), label: "View Data"),
            BottomNavigationBarItem(
                icon: Icon(Icons.input), label: 'Input Data'),
            BottomNavigationBarItem(
                icon: Icon(Icons.update), label: 'Update Data'),
            BottomNavigationBarItem(
                icon: Icon(Icons.view_compact), label: 'View FILE'),
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
