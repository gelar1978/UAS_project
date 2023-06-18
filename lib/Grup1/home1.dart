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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 41, 156, 37),
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
              listMember('Rifaldi Wahyu Ramadhan', '1101190144',
                  'lib/images/rifaldiwr.png'),
              listMember('M Raihan Al Ghifari', '1101194477',
                  'lib/images/mraihan.jpg'),
              listMember('Ilman Fahman', '1101190142', 'lib/images/ilman.jpg'),
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
