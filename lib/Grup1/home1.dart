import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:UAS_project/services/auth_service.dart';

class home1 extends StatefulWidget {
  // final String message;
  home1({super.key});

  @override
  State<home1> createState() => _home1State();
}

class _home1State extends State<home1> {
  final TextEditingController _textEditingController = TextEditingController();
  String _message = '';
  List<String> Nama = [
    'RIFALDI WAHYU RAMADHAN',
    'M RAIHAN AL GHIFARI',
    'ILMAN FAHMAN'
  ];
  List<String> NIM = ['1101190144', '1101194477', '1101190142'];
  List<String> Foto = [
    'lib/images/rifaldiwr.jpg',
    'lib/images/mraihanag.jpg',
    'lib/images/ilman.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1D267D),
        title: const Text('HOME'),
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
      body: ListView.builder(
          itemCount: Nama.length,
          itemBuilder: (context, int index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(Foto[index]),
              ),
              title: Text(Nama[index]),
              subtitle: Text(NIM[index]),
            );
          }),
    );
  }
}
