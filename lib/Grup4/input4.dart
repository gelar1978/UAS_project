import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:UAS_project/Grup4/audioupload4.dart';
import 'package:UAS_project/Grup4/imageupload4.dart';
import 'package:UAS_project/controller/image_upload.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class input4 extends StatefulWidget {
  @override
  _input4State createState() => _input4State();
}

class _input4State extends State<input4> {
  final databaseReference = FirebaseDatabase.instance.ref('Grup4');
  List<Data> dataList = [];
  // List<Map<String, dynamic>> dataList = [];

  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final jenisController = TextEditingController();
  final teksController = TextEditingController();
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
        ReadWriteValue<DatabaseEvent> values = snapshot.val('Grup4');
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

  void writeData(String nama, String email, String jenis, String teks) {
    Random random = Random();
    String num = random.nextInt(50000000).toString();
    databaseReference.child(num).set({
      'nama': nama,
      'email': email,
      'jenis': jenis,
      'teks': teks,
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
    jenisController.clear();
    emailController.clear();
    teksController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 124, 17, 110),
        title: Text('Input data P'),
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
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: jenisController,
                  decoration: InputDecoration(labelText: 'Jenis'),
                ),
                TextField(
                  controller: teksController,
                  decoration: InputDecoration(labelText: 'Teks'),
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
                        writeData(
                          namaController.text,
                          emailController.text,
                          jenisController.text,
                          teksController.text,
                        );
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return AlertDialog(
                                title: Text('DONE BANG'),
                                content: Text('Input DONE'),
                              );
                            }));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange),
                      child: Text('Tambah Data'),
                    ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     deleteData('0002');
                    //   },
                    //   child: Text('Bersihkan Kolom'),
                    // ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            onPressed: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImageUploadScreen(),
                                ),
                              );
                            }),
                            child: Text(
                              "Unggah Citra W",
                              style: TextStyle(color: Colors.black),
                            )),
                        TextButton(
                            onPressed: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => audioupload4(),
                                ),
                              );
                            }),
                            child: Text("Unggah Audio H",
                                style: TextStyle(color: Colors.black))),
                      ],
                    )
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
  final String email;
  final String jenis;
  final String teks;

  Data(this.key, this.nama, this.email, this.jenis, this.teks);
}
