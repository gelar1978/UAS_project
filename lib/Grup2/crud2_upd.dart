import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:UAS_project/Grup2/imageView2_W.dart';
import 'package:UAS_project/Grup2/image_upload2_H.dart';
import 'package:UAS_project/Grup2/image_upload2_W.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class crud2_upd extends StatefulWidget {
  @override
  _crud2_updState createState() => _crud2_updState();
}

class _crud2_updState extends State<crud2_upd> {
  final databaseReference = FirebaseDatabase.instance.ref('Grup2');
  List<Data> dataList = [];
  // List<Map<String, dynamic>> dataList = [];

  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final jenisController = TextEditingController();
  final textController = TextEditingController();
  final skemaController = TextEditingController();
  final nomorController = TextEditingController();
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
        ReadWriteValue<DatabaseEvent> values = snapshot.val('Grup2');
        values.val.snapshot.children.forEach((element) {
          
          var xx = element.value.val(element.key.toString()).val;
          
        });
       
      });
    });
  }

  late DataSnapshot snapshot;
  

  void readData() async {
    Stream<DatabaseEvent> stream = databaseReference.onValue;

// Subscribe to the stream!
    stream.listen((DatabaseEvent event) {
      print('Event Type: ${event.type}'); // DatabaseEventType.value;
      print('Snapshot: ${event.snapshot.child('0001').value}');
      print(event.snapshot); // DataSnapshot
    });
  }

 
  void updateData(String key, String nama, String email, int jenis, String text,
      int skema) {
    databaseReference.child(key).update({
      'Nama': nama,
      'Email': email,
      'Jenis': jenis,
      'Text': text,
      'Skema': skema,
    }).asStream();
  }

  void clearFields() {
    namaController.clear();
    emailController.clear();
    jenisController.clear();
    textController.clear();
    skemaController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1D267D),
        title: Text('Update Data'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: [
            TextField(
              controller: nomorController,
              decoration: InputDecoration(labelText: 'No'),
            ),
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
              controller: textController,
              decoration: InputDecoration(labelText: 'Text'),
            ),
            TextField(
              controller: skemaController,
              decoration: InputDecoration(labelText: 'Skema'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // print(dataList[0].key);
                    updateData(
                      nomorController.text,
                      namaController.text,
                      emailController.text,
                      int.parse(jenisController.text),
                      textController.text,
                      int.parse(skemaController.text),
                    );
                    showDialog(
                        context: context,
                        builder: ((context) {
                          return AlertDialog(
                            title: Text('!! Success !!'),
                            content: Text('Data Berhasil Di-Update'),
                          );
                        }));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff1D267D)
                  ),
                  child: Text('Update Data'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageUploadsW(),
                        ),
                      );
                    }),
                    child: Text("Unggah Citra W", style: TextStyle(color: Color(0xff5C469C)),)),
                TextButton(
                    onPressed: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageUploadsH(),
                        ),
                      );
                    }),
                    child: Text("Unggah Citra H", style: TextStyle(color: Color(0xff5C469C)),)),
              ],
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
  final int jenis;
  final String text;
  final int skema;

  Data(this.key, this.nama, this.email, this.jenis, this.text, this.skema);
}
