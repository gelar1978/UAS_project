import 'package:UAS_project/Grup2/Cek.dart';
import 'package:UAS_project/Grup2/imageView2_H.dart';
import 'package:UAS_project/Grup2/imageView2_W.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:UAS_project/services/auth_service.dart';

class folderView2 extends StatefulWidget {
  // final String message;
  folderView2({super.key});

  @override
  State<folderView2> createState() => _folderView2State();
}

class _folderView2State extends State<folderView2> {
  final TextEditingController _textEditingController = TextEditingController();
  String _message = '';
  List<String> folder = ['Lihat Citra W','Lihat Citra H'];
  List<String> huruf = ['W','H'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1D267D),
        title: const Text('View File'),
      ),
      body: ListView.builder(
          itemCount: folder.length,
          itemBuilder: (context, int index){
            return ListTile(
              onTap: () async {
                if (huruf[index] == 'W') {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageView_W(),
                    ),
                  );
                  setState(() {
                    _message = result ?? '';
                  });
                }
                else if (huruf[index] == 'H') {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageView_H(),
                    ),
                  );
                  setState(() {
                    _message = result ?? '';
                  });
                }
              },
              leading: Icon(
                Icons.folder
              ),
              title: Text(folder[index]),
              
            );
          }),
      
    );
  }
}
