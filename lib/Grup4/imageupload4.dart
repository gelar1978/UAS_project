import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _imageFile;

  // Fungsi untuk memilih gambar dari galeri
  Future<void> _pickImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;

      final pickedImageFile = File(pickedImage.path);
      setState(() {
        _imageFile = pickedImageFile;
      });
    } catch (e) {
      print(e);
    }
  }

  // Fungsi untuk mengunggah gambar
  Future<void> _uploadImage() async {
    if (_imageFile == null) return;
    final fileName = basename(_imageFile!.path);
    final destination = 'Group4/citraW/$fileName';
    print(destination);
    try {
      final ref = firebase_storage.FirebaseStorage.instance.ref(destination);
      // .child('file/');
      await ref.putFile(_imageFile!);
    } catch (e) {
      print('error occured');
    }

    // Proses pengunggahan gambar ke server
    // Gantikan dengan kode pengunggahan gambar sesuai dengan kebutuhan Anda
    // Misalnya menggunakan package http atau package dio

    // Setelah pengunggahan selesai, kosongkan gambar yang dipilih
    setState(() {
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unggah Gambar'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile != null
                ? Image.file(
                    _imageFile!,
                    height: 200,
                  )
                : Icon(
                    Icons.image,
                    size: 100,
                  ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pilih Gambar'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Unggah Gambar'),
            ),
          ],
        ),
      ),
    );
  }
}
