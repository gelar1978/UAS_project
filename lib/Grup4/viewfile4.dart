//import 'package:UAS_project/Grup4/audioView4.dart';
import 'package:UAS_project/Grup4/imageview4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:UAS_project/services/auth_service.dart';

class foldercheck4 extends StatefulWidget {
  // final String message;
  foldercheck4({super.key});

  @override
  State<foldercheck4> createState() => _foldercheck4State();
}

class _foldercheck4State extends State<foldercheck4> {
  final TextEditingController _textEditingController = TextEditingController();
  String _message = '';
  List<String> folder = ['Citra W', 'Audio H'];
  List<String> huruf = ['W', 'H'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 91, 18, 133),
        title: const Text('View File'),
      ),
      body: ListView.builder(
          itemCount: folder.length,
          itemBuilder: (context, int index) {
            return ListTile(
              onTap: () async {
                if (huruf[index] == 'W') {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => imageview(),
                    ),
                  );
                  setState(() {
                    _message = result ?? '';
                  });
                } else if (huruf[index] == 'H') {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => imageview() //audioview(),
                        ),
                  );
                  setState(() {
                    _message = result ?? '';
                  });
                }
              },
              leading: Icon(Icons.folder),
              title: Text(folder[index]),
            );
          }),
    );
  }
}
