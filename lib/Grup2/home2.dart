import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:UAS_project/services/auth_service.dart';

class home2 extends StatefulWidget {
  // final String message;
  home2({super.key});

  @override
  State<home2> createState() => _home2State();
}

class _home2State extends State<home2> {
  final TextEditingController _textEditingController = TextEditingController();
  String _message = '';
  List<String> Nama = [
    'ATHALIQA ANANDA PUTRI',
    'SABILA HAYYINUN JANNAH',
    'SRI WAHYUNI ASMUR',
    'MUHAMMAD REYHAN FAJAR NASUTION'
  ];
  List<String> NIM = ['1101193387', '1101204132', '1101204173', '1101204197'];
  List<String> Foto = [
    'lib/images/athaliqa.jpg',
    'lib/images/Sabila.jpg',
    'lib/images/Sri.jpg',
    'lib/images/Reyhan_F.jpg'
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
