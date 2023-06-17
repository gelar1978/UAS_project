import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

import '../Grup7/nav7.dart';

class pdfupload extends StatefulWidget {
  pdfupload({Key? key}) : super(key: key);

  @override
  _pdfuploadState createState() => _pdfuploadState();
}

class _pdfuploadState extends State<pdfupload> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _file;

  Future fileFromGallery() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    setState(() {
      if (pickedFile != null) {
        _file = File(pickedFile.files.single.path!);
        print(_file);
        uploadFile();
      } else {
        print('No file selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_file == null) return;
    final fileName = basename(_file!.path);
    final destination = 'Group7/$fileName';
    print(destination);
    try {
      final ref = firebase_storage.FirebaseStorage.instance.ref(destination);
      await ref.putFile(_file!);
      ScaffoldMessenger.of(context as BuildContext)
          .showSnackBar(SnackBar(content: Text('Upload successful')));
      Navigator.push(context as BuildContext, MaterialPageRoute(builder: (context) {
        return NavBarView();
      }));
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 32,
          ),
          
          Center(
            child: GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Color(0xffFDCF09),
                child: _file != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'assets/pdf_icon.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.fitHeight,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        width: 100,
                        height: 100,
                        child: Icon(
                          Icons.add_to_drive_outlined,
                          color: Colors.grey[800],
                        ),
                      ),
              ),
            ),
          )
          
        ],
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Gallery'),
                  onTap: () {
                    fileFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
