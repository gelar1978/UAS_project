import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:UAS_project/Grup3/fileupload.dart';
import 'package:UAS_project/Grup3/nav3.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';

class input3 extends StatefulWidget {
  @override
  _input3State createState() => _input3State();
}

class _input3State extends State<input3> {
  static const _chars = '';
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
        .child('Grup3')
        .child('/' + getRandomString(10) + '.pdf');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'file/pdf',
        customMetadata: {'picked-file-path': file.path});
    print("Uploading..!");

    uploadTask = ref.putData(await file.readAsBytes(), metadata);

    print("done..!");
    return Future.value(uploadTask);
  }

  final databaseReference = FirebaseDatabase.instance.ref('grup3');
  final fb = FirebaseDatabase.instance;
  List<Data> dataList = [];

  final namaController = TextEditingController();
  final nimController = TextEditingController();
  final emailController = TextEditingController();
  final statusController = TextEditingController();
  final kodemkController = TextEditingController();
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

  void writeData(String nama, String nim, String email, String status,
      String kodemk, String jawaban) {
    Random random = Random();
    String num = random.nextInt(50000000).toString();
    databaseReference.child(num).set({
      'nama': nama,
      'nim': nim,
      'email': email,
      'status': status,
      'kodemk': kodemk,
      'jawaban': jawaban,
    }).asStream();
  }

  @override
  Widget build(BuildContext context) {
    var rng = Random();
    var k = rng.nextInt(10000);

    final ref = fb.ref().child('grup3/$k');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
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
                    decoration: const InputDecoration(labelText: 'Nama'),
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
                    controller: statusController,
                    decoration: const InputDecoration(labelText: 'Status'),
                  ),
                  TextField(
                    controller: kodemkController,
                    decoration: const InputDecoration(labelText: 'Kode MK'),
                  ),
                  TextField(
                    controller: jawabanController,
                    decoration: const InputDecoration(labelText: 'Jawaban'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () {
                          Map<String, dynamic> nilaiMhs = {
                            'nama': namaController.text,
                            'nim': nimController.text,
                            'email': emailController.text,
                            'status': statusController.text,
                            'kodemk': kodemkController.text,
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
                  TextButton(
                      onPressed: (() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UploadPDFScreen(),
                          ),
                        );
                      }),
                      child: Text("Upload PDF")),
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
  final String status;
  final String kodemk;
  final String jawaban;

  Data(this.key, this.nama, this.nim, this.email, this.status, this.kodemk,
      this.jawaban);
}
