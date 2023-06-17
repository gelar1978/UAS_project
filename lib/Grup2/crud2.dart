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

class crud2 extends StatefulWidget {
  @override
  _crud2State createState() => _crud2State();
}

class _crud2State extends State<crud2> {
  final databaseReference = FirebaseDatabase.instance.ref('Grup2');
  List<Data> dataList = [];
  // List<Map<String, dynamic>> dataList = [];

  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final jenisController = TextEditingController();
  final textController = TextEditingController();
  final skemaController = TextEditingController();
  TextEditingController second = TextEditingController();

  TextEditingController third = TextEditingController();


  @override
  void initState() {
    super.initState();

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

  void writeData(String nama, String email, int jenis, String text, int skema) {
    Random random = Random();
    String num = random.nextInt(9999).toString();
    databaseReference.child(num).set({
      'Nama': nama,
      'Email': email,
      'Jenis': jenis,
      'Text': text,
      'Skema': skema,
    }).asStream();
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

  void deleteData(String key) {
    databaseReference.child(key).remove().then((_) {
      // getData();
      clearFields();
    });
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
        title: Text('Input Data'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
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
                    // readData();
                    // print(x);
                    writeData(
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
                            content: Text('Data Berhasil Ditambahkan'),
                          );
                        }));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff1D267D)),
                  child: Text('Tambah Data'),
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
                    child: Text(
                      "Unggah Citra W",
                      style: TextStyle(color: Color(0xff5C469C)),
                    )),
                TextButton(
                    onPressed: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageUploadsH(),
                        ),
                      );
                    }),
                    child: Text(
                      "Unggah Citra H",
                      style: TextStyle(color: Color(0xff5C469C)),
                    )),
              ],
            ),
          ],
        ),
      ),
      // FirebaseAnimatedList(
      //     query: databaseReference,
      //     shrinkWrap: true,
      //     itemBuilder: (context, snapshot, animation, index) {
      //       var v = snapshot.value
      //           .toString(); // {subtitle: webfun, title: subscribe}

      //       var g = v.replaceAll(
      //           RegExp("{|}|subtitle: |title: "), ""); // webfun, subscribe
      //       g.trim();

      //       var l = g.split(','); // [webfun,  subscribe}]
      //       print(l);
      //       return GestureDetector(onTap: () {
      //         setState(() {
      //           var k = snapshot.key;
      //         });

      //         showDialog(
      //           context: context,
      //           builder: (ctx) => AlertDialog(
      //             title: Container(
      //               decoration: BoxDecoration(border: Border.all()),
      //               child: TextField(
      //                 controller: second,
      //                 textAlign: TextAlign.center,
      //                 decoration: InputDecoration(
      //                   hintText: 'title',
      //                 ),
      //               ),
      //             ),
      //             content: Container(
      //               decoration: BoxDecoration(border: Border.all()),
      //               child: TextField(
      //                 controller: third,
      //                 textAlign: TextAlign.center,
      //                 decoration: InputDecoration(
      //                   hintText: 'sub title',
      //                 ),
      //               ),
      //             ),
      //             actions: <Widget>[
      //               MaterialButton(
      //                 onPressed: () {
      //                   Navigator.of(ctx).pop();
      //                 },
      //                 color: Color.fromARGB(255, 0, 22, 145),
      //                 child: Text(
      //                   "Cancel",
      //                   style: TextStyle(
      //                     color: Colors.white,
      //                   ),
      //                 ),
      //               ),
      //               MaterialButton(
      //                 onPressed: () async {
      //                   // await upd();
      //                   // Navigator.of(ctx).pop();
      //                 },
      //                 color: Color.fromARGB(255, 0, 22, 145),
      //                 child: Text(
      //                   "Update",
      //                   style: TextStyle(
      //                     color: Colors.white,
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         );
      //       });
      //     }),
      // Expanded(
      //   child: dataList.length == 0
      //       ? Center(child: Text('Tidak ada data'))
      //       : ListView.builder(
      //           itemCount: dataList.length,
      //           itemBuilder: (context, index) {
      //             return ListTile(
      //               title: Text(dataList[index].nama),
      //               subtitle: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text('NIM: ${dataList[index].nim}'),
      //                   Text('Nilai: ${dataList[index].nilai}'),
      //                   Text('Resume: ${dataList[index].resume}'),
      //                 ],
      //               ),
      //             );
      //           },
      //         ),
      // ),
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
