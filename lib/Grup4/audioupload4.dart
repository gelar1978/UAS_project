import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class audioupload4 extends StatefulWidget {
  @override
  _audioupload4State createState() => _audioupload4State();
}

class _audioupload4State extends State<audioupload4> {
  File? _file;

  // Fungsi untuk memilih file dari penyimpanan
  Future<void> _pickFile() async {
    try {
      final pickedImage =
          await ImagePicker().pickVideo(source: ImageSource.gallery);
      if (pickedImage == null) return;

      final pickedImageFile = File(pickedImage.path);
      setState(() {
        _file = pickedImageFile;
      });
    } catch (e) {
      print(e);
    }
  }

  // Fungsi untuk mengunggah file
  Future<void> _uploadFile() async {
    if (_file == null) return;
    final fileName = basename(_file!.path);
    final destination = 'Group4/audioH/$fileName';
    print(destination);
    try {
      final ref = firebase_storage.FirebaseStorage.instance.ref(destination);
      await ref.putFile(_file!);
    } catch (e) {
      print('error occurred');
    }

    // Proses pengunggahan file ke server
    // Gantikan dengan kode pengunggahan file sesuai dengan kebutuhan Anda
    // Misalnya menggunakan package http atau package dio

    // Setelah pengunggahan selesai, kosongkan file yang dipilih
    setState(() {
      _file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unggah File'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _file != null
                ? Text(
                    'File yang dipilih: ${basename(_file!.path)}',
                    style: TextStyle(fontSize: 16),
                  )
                : Icon(
                    Icons.music_note,
                    size: 100,
                  ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickFile,
              child: Text('Pilih File'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadFile,
              child: Text('Unggah File'),
            ),
          ],
        ),
      ),
    );
  }
}
