import 'package:UAS_project/Grup6/home6.dart';
import 'package:UAS_project/Grup6/read6.dart';
import 'package:UAS_project/Grup6/input6.dart';
import 'package:UAS_project/Grup6/viewer6.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../controller/navbar_controller.dart';

class NavBarView extends StatelessWidget {
  NavBarView({Key? key}) : super(key: key);

  final _controller = Get.put(NavBarController());

  final List<Widget> _listPage = [
    Home6(),
    read6(),
    Input6(),
    ViewPDF(),
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
                icon: Icon(Icons.data_array), label: 'View Data'),
            BottomNavigationBarItem(
                icon: Icon(Icons.input), label: 'Input Data'),
            BottomNavigationBarItem(
                icon: Icon(Icons.file_copy), label: 'View File'),
          ],
          onTap: (value) => _controller.pageChange(value),
        ),
        body: _listPage.elementAt(_controller.currentTab.value),
      ),
    );
  }
}
