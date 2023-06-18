import 'package:UAS_project/Grup6/color6.dart';
import 'package:flutter/material.dart';
import 'package:UAS_project/services/auth_service.dart';

class Home6 extends StatefulWidget {
  // final String message;
  Home6({super.key});

  @override
  State<Home6> createState() => _Home6State();
}

class _Home6State extends State<Home6> {
  final TextEditingController _textEditingController = TextEditingController();
  String _message = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
        backgroundColor: Color6.lightPrimaryColor,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              // _showAlertDialog(context);
              AuthService.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15),
                  ),
                  Container(
                    padding: const EdgeInsets.all(3),
                    child: Column(
                      children: [
                        Text(
                          "MEMBERS",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                        ),
                        Text(
                          "Group 6",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("lib/images/aldira.png"),
                              fit: BoxFit.fitWidth,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(1),
                            child: const Text(
                              'Aldira Fadillah Lazuardi',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(1),
                            child: const Text(
                              '1101200372',
                              style: TextStyle(
                                  color: Color6.lightSecondaryColor,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(3),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("lib/images/balqis.jpeg"),
                              fit: BoxFit.fitWidth,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(1),
                            child: const Text(
                              'Lulu Balqis Zianka Faza',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(1),
                            child: const Text(
                              '1101200196',
                              style: TextStyle(
                                  color: Color6.lightSecondaryColor,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(3),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("lib/images/nau1.jpeg"),
                              fit: BoxFit.fitWidth,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(1),
                            child: const Text(
                              'M. Naufal Nur Irawan',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(1),
                            child: const Text(
                              '1101204104',
                              style: TextStyle(
                                  color: Color6.lightSecondaryColor,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(3),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("lib/images/afifah.jpg"),
                              fit: BoxFit.fitWidth,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(1),
                            child: const Text(
                              'Nurafifah Annida',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(1),
                            child: const Text(
                              '1101202549',
                              style: TextStyle(
                                  color: Color6.lightSecondaryColor,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
