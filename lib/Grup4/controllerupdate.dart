import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:UAS_project/Grup4/imageupload4.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:UAS_project/controller/image_upload.dart';

class updatedata4 extends StatefulWidget {
  @override
  _updatedata4State createState() => _updatedata4State();
}

class _updatedata4State extends State<updatedata4> {
  final databaseReference = FirebaseDatabase.instance.ref('Grup4');
  List<Data> dataList = [];
  final keyController = TextEditingController();
  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final teksController = TextEditingController();
  final jenisController = TextEditingController();
  TextEditingController second = TextEditingController();
  TextEditingController third = TextEditingController();

  @override
  void initState() {
    super.initState();
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
  void updateData(
      String key, String nama, String email, String jenis, String teks) {
    databaseReference.child(key).update({
      'Nama': nama,
      'Email': email,
      'Jenis': jenis,
      'Teks': teks,
    }).asStream();
  }

  void deleteData(String key) {
    databaseReference.child(key).remove().then((_) {
      // getData();
      clearFields();
    });
  }

  void clearFields() {
    // kunciController.clear();
    namaController.clear();
    emailController.clear();
    jenisController.clear();
    teksController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Data bro'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: [
            TextField(
              controller: keyController,
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
              controller: teksController,
              decoration: InputDecoration(labelText: 'Teks'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // print(dataList[0].key);
                    updateData(
                      keyController.text,
                      namaController.text,
                      emailController.text,
                      jenisController.text,
                      teksController.text,
                    );
                    showDialog(
                        context: context,
                        builder: ((context) {
                          return AlertDialog(
                            title: Text('Success !!'),
                            content: Text('Data Updated!'),
                          );
                        }));
                  },
                  child: Text('Update Data'),
                ),
              ],
            ),
            TextButton(
                onPressed: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageUploadScreen(),
                    ),
                  );
                }),
                child: Text("UnggahCitraW")),
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
  final String jenis;
  final String teks;

  Data(this.key, this.nama, this.email, this.jenis, this.teks);
}
