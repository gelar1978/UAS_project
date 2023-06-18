import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:UAS_project/services/auth_service.dart';

class home5 extends StatefulWidget {
  // final String message;
  home5({super.key});

  @override
  State<home5> createState() => _home5State();
}

class _home5State extends State<home5> {
  final TextEditingController _textEditingController = TextEditingController();
  String _message = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.indigo[900],
        title: const Text('Home'),
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
        padding: const EdgeInsets.all(5),
        child: Center(
          child: ListView(
            children: <Widget>[
              listMember(
                  'Aldra Kasyfil Aziz', '1101201509', 'lib/images/aldra.jpg'),
              listMember('Muhammad Dafa Maulana', '1101204403',
                  'lib/images/m_dafa_m.jpg'),
              listMember('Rabby Fitriana Adawiyah', '1101202505',
                  'lib/images/rabby.jpg'),
              listMember('Rifqi Fadhilah Firdaus', '1101204257',
                  'lib/images/rifqi.jpg'),
            ],
          ),
        ),
      ),
    );
  }
}

Widget listMember(String nama, String nim, photo) {
  return Container(
    padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
    child: ListTile(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      tileColor: Colors.grey[100],
      leading: CircleAvatar(
        backgroundImage: AssetImage(photo),
      ),
      title: Text(
        nama,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(nim),
    ),
  );
}
