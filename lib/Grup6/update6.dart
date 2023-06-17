import 'dart:async';
import 'dart:math';
import 'package:UAS_project/Grup6/nav6.dart';
import 'package:UAS_project/controller/image_upload.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class update6 extends StatefulWidget {
  @override
  _update6State createState() => _update6State();
}

class _update6State extends State<update6> {
  final databaseReference = FirebaseDatabase.instance.ref('Grup6');
  final fb = FirebaseDatabase.instance;
  List<Data> dataList = [];

  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final kelasController = TextEditingController();
  final dosenController = TextEditingController();
  final nilaiController = TextEditingController();
  final jawabanController = TextEditingController();
  //Upload Foto

  void readData() async {
    Stream<DatabaseEvent> stream = databaseReference.onValue;

    // Subscribe to the stream!
    stream.listen((DatabaseEvent event) {
      print('Event Type: ${event.type}'); // DatabaseEventType.value;
      print('Snapshot: ${event.snapshot.child('0001').value}');
      print(event.snapshot); // DataSnapshot
    });
  }

  void writeData(String nama, String email, String kelas, String dosen,
      double nilai, String jawaban) {
    Random random = Random();
    String num = random.nextInt(50000000).toString();
    databaseReference.child(num).set({
      'nama': nama,
      'email': email,
      'kelas': kelas,
      'dosen': dosen,
      'nilai': nilai,
      'jawaban': jawaban,
    }).asStream();
  }

  void updateData(String key, String nama, String email, String kelas,
      String dosen, double nilai, String jawaban) {
    databaseReference.child(key).update({
      'nama': nama,
      'email': email,
      'kelas': kelas,
      'dosen': dosen,
      'nilai': nilai,
      'jawaban': jawaban,
    }).then((_) {
      print('Data updated successfully.');
    }).catchError((error) {
      print('Failed to update data: $error');
    });
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          ref.set({
                            'nama': namaController.text,
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
                      ElevatedButton(
                        onPressed: () {
                          // Get the key of the data you want to update
                          String key = 'Grup6';

                          updateData(
                            key,
                            namaController.text,
                            emailController.text,
                            kelasController.text,
                            dosenController.text,
                            double.parse(nilaiController.text),
                            jawabanController.text,
                          );
                        },
                        child: Text('Update Data'),
                      ),
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
  final String nama;
  final String email;
  final String kelas;
  final String dosen;
  final double nilai;
  final String jawaban;

  Data(this.key, this.nama, this.email, this.kelas, this.dosen, this.nilai,
      this.jawaban);
}
