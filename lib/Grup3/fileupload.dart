import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;

class UploadPDFScreen extends StatefulWidget {
  @override
  _UploadPDFScreenState createState() => _UploadPDFScreenState();
}

class _UploadPDFScreenState extends State<UploadPDFScreen> {
  File? selectedPDF;

  Future<void> pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        selectedPDF = File(result.files.single.path!);
      });
    }
  }

  Future<String?> uploadPDFToFirebaseStorage(File file) async {
    if (file == null) return null;

    String fileName = path.basename(file.path);
    firebase_storage.Reference storageReference =
        firebase_storage.FirebaseStorage.instance.ref('grup3/$fileName');
    firebase_storage.UploadTask uploadTask = storageReference.putFile(file);
    firebase_storage.TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() => null);

    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload PDF'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: pickPDF,
              child: Text('Pilih File PDF'),
            ),
            SizedBox(height: 16),
            if (selectedPDF != null)
              ElevatedButton(
                onPressed: () async {
                  String? downloadUrl =
                      await uploadPDFToFirebaseStorage(selectedPDF!);
                  if (downloadUrl != null) {
                    // File PDF berhasil diunggah, lakukan sesuatu di sini
                    print('File PDF berhasil diunggah. URL: $downloadUrl');
                  } else {
                    // Terjadi kesalahan saat mengunggah file PDF
                    print('Gagal mengunggah file PDF');
                  }
                },
                child: Text('Unggah PDF'),
              ),
          ],
        ),
      ),
    );
  }
}
