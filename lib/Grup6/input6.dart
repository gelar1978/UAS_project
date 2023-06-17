import 'dart:async';
import 'dart:math';
import 'package:UAS_project/Grup6/nav6.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Input6 extends StatefulWidget {
  @override
  _Input6State createState() => _Input6State();
}

class _Input6State extends State<Input6> {
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
        title: Text('Input Database'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextField(
                    controller: namaController,
                    decoration: InputDecoration(labelText: 'Nama'),
                  ),
                  TextField(
                    controller: nimController,
                    decoration: InputDecoration(labelText: 'NIM'),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    controller: kelasController,
                    decoration: InputDecoration(labelText: 'KodeKelas'),
                  ),
                  TextField(
                    controller: dosenController,
                    decoration: InputDecoration(labelText: 'KodeDosen'),
                  ),
                  TextField(
                    controller: nilaiController,
                    decoration: InputDecoration(labelText: 'Nilai'),
                  ),
                  TextField(
                    controller: jawabanController,
                    decoration: InputDecoration(labelText: 'JawabanText'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          ref.set({
                            'nama': namaController.text,
                            'nim': nimController.text,
                            'email': emailController.text,
                            'kelas': kelasController.text,
                            'dosen': dosenController.text,
                            'nilai': double.parse(nilaiController.text),
                            'jawaban': jawabanController.text,
                          }).asStream();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => NavBarView(),
                            ),
                          );
                        },
                        child: Text('Tambah Data'),
                      ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => pdfuploads(),
                      //         ));
                      //   },
                      //   child: Text('Upload PDF'),
                      // ),
                    ],
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
