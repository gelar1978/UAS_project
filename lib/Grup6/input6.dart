import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:UAS_project/Grup6/color6.dart';
import 'package:UAS_project/Grup6/nav6.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';

class Input6 extends StatefulWidget {
  @override
  _Input6State createState() => _Input6State();
}

class _Input6State extends State<Input6> {
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  String getRandomString(int len) => String.fromCharCodes(
        Iterable.generate(
          len,
          (_) => _chars.codeUnitAt(
            _rnd.nextInt(_chars.length),
          ),
        ),
      );

  Future<firebase_storage.UploadTask?> uploadFile(File file) async {
    if (file == null) {
      print("No File was Picked");
      return null;
    }

    firebase_storage.UploadTask uploadTask;
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Group6')
        .child('/' + getRandomString(10) + '.pdf');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'file/pdf',
        customMetadata: {'picked-file-path': file.path});
    print("Uploading..!");

    uploadTask = ref.putData(await file.readAsBytes(), metadata);

    print("done..!");
    return Future.value(uploadTask);
  }

  final databaseReference = FirebaseDatabase.instance.ref('Grup6');
  final fb = FirebaseDatabase.instance;
  List<Data> dataList = [];

  final namaController = TextEditingController();
  final nimController = TextEditingController();
  final emailController = TextEditingController();
  final kelasController = TextEditingController();
  final dosenController = TextEditingController();
  final nilaiController = TextEditingController();
  final jawabanController = TextEditingController();
  //Upload Foto

  void readData() async {
    Stream<DatabaseEvent> stream = databaseReference.onValue;
    stream.listen((DatabaseEvent event) {
      print('Event Type: ${event.type}');
      print('Snapshot: ${event.snapshot.child('0001').value}');
      print(event.snapshot);
    });
  }

  void writeData(String nama, String nim, String email, String kelas,
      String dosen, double nilai, String jawaban) {
    Random random = Random();
    String num = random.nextInt(50000000).toString();
    databaseReference.child(num).set({
      'nama': nama,
      'nim': nim,
      'email': email,
      'kelas': kelas,
      'dosen': dosen,
      'nilai': nilai,
      'jawaban': jawaban,
    }).asStream();
  }

  @override
  Widget build(BuildContext context) {
    var rng = Random();
    var k = rng.nextInt(10000);

    final ref = fb.ref().child('Grup6/$k');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color6.lightPrimaryColor,
        title: const Text('INPUT DATA'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextField(
                    controller: namaController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: nimController,
                    decoration: const InputDecoration(labelText: 'NIM'),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'E-Mail'),
                  ),
                  TextField(
                    controller: kelasController,
                    decoration: const InputDecoration(labelText: 'Class Code'),
                  ),
                  TextField(
                    controller: dosenController,
                    decoration:
                        const InputDecoration(labelText: 'Teacher Code'),
                  ),
                  TextField(
                    controller: nilaiController,
                    decoration: const InputDecoration(labelText: 'Grade'),
                  ),
                  TextField(
                    controller: jawabanController,
                    decoration: const InputDecoration(labelText: 'Answer'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color6.lightSecondaryColor,
                        ),
                        onPressed: () {
                          Map<String, dynamic> nilaiMhs = {
                            'nama': namaController.text,
                            'nim': nimController.text,
                            'email': emailController.text,
                            'kelas': kelasController.text,
                            'dosen': dosenController.text,
                            'nilai': double.parse(nilaiController.text),
                            'jawaban': jawabanController.text,
                          };
                          ref.set(nilaiMhs).asStream();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => NavBarView(),
                            ),
                          );
                        },
                        child: const Text('Tambah Data'),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color6.lightSecondaryColor,
                    ),
                    onPressed: () async {
                      final path = await FlutterDocumentPicker.openDocument();
                      print(path);
                      File file = File(path!);
                      firebase_storage.UploadTask? task =
                          await uploadFile(file);
                    },
                    child: Text('Upload PDF'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Data {
  final String key;
  final String nim;
  final String nama;
  final String email;
  final String kelas;
  final String dosen;
  final double nilai;
  final String jawaban;

  Data(this.key, this.nama, this.nim, this.email, this.kelas, this.dosen,
      this.nilai, this.jawaban);
}
