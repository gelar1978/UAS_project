import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class input3 extends StatefulWidget {
  @override
  _input3State createState() => _input3State();
}

class _input3State extends State<input3> {
  final databaseReference = FirebaseDatabase.instance.ref('Grup3');
  List<Data> dataList = [];
  // List<Map<String, dynamic>> dataList = [];

  final namaController = TextEditingController();
  final nimController = TextEditingController();
  final emailController = TextEditingController();
  final statusController = TextEditingController();
  final kodemkController = TextEditingController();
  final jawabantextController = TextEditingController();
  TextEditingController second = TextEditingController();

  TextEditingController third = TextEditingController();
  @override
  void initState() {
    super.initState();
    // database = FirebaseDatabase.instance.ref().child('tabel');
    // Membaca data dari Firebase Realtime Database
    DataSnapshot snapshot;
    databaseReference.once().then((snapshot) {
      setState(() {
        dataList.clear();
        ReadWriteValue<DatabaseEvent> values = snapshot.val('Grup3');
        values.val.snapshot.children.forEach((element) {
          var xx = element.value.val(element.key.toString()).val;
        });
      });
    });
  }

  late DataSnapshot snapshot;
  void readData() async {
    Stream<DatabaseEvent> stream = databaseReference.onValue;
    stream.listen((DatabaseEvent event) {
      print('Event Type: ${event.type}'); // DatabaseEventType.value;
      print('Snapshot: ${event.snapshot.child('0001').value}');
      print(event.snapshot); // DataSnapshot
    });
  }

  void writeData(String nama, int nim, String email, String status,
      String kodemk, String jawabantext) {
    Random random = Random();
    String num = random.nextInt(50000000).toString();
    databaseReference.child(num).set({
      'nama': nama,
      'nim': nim,
      'email': email,
      'status': status,
      'kodemk': kodemk,
      'jawabantext': jawabantext,
    }).asStream();
  }

  // void updateData(
  //     String key, String nama, int nim, double nilai, String resume) {
  //   databaseReference.child(key).update({
  //     'nama': nama,
  //     'nim': nim,
  //   }).asStream();
  // }

  void deleteData(String key) {
    databaseReference.child(key).remove().then((_) {
      // getData();
      clearFields();
    });
  }

  void clearFields() {
    namaController.clear();
    nimController.clear();
    emailController.clear();
    statusController.clear();
    kodemkController.clear();
    jawabantextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Realtime Database'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(4.5),
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
                  controller: statusController,
                  decoration: InputDecoration(labelText: 'Status'),
                ),
                TextField(
                  controller: kodemkController,
                  decoration: InputDecoration(labelText: 'KodeMK'),
                ),
                TextField(
                  controller: jawabantextController,
                  decoration: InputDecoration(labelText: 'Jawaban Text'),
                ),
                // TextField(
                //   controller: resumeController,
                //   decoration: InputDecoration(labelText: 'Unggah???'),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // readData();
                        // print(x);
                        writeData(
                          namaController.text,
                          int.parse(nimController.text),
                          emailController.text,
                          statusController.text,
                          kodemkController.text,
                          jawabantextController.text,
                          // double.parse(nilaiController.text),
                          // resumeController.text,
                        );
                      },
                      child: Text('Tambah Data'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        deleteData('0002');
                      },
                      child: Text('Bersihkan Kolom'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Data {
  final String key;
  final String nama;
  final int nim;
  final double nilai;
  final String resume;

  Data(this.key, this.nama, this.nim, this.nilai, this.resume);
}
