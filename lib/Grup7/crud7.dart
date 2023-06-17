import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:UAS_project/Grup7/uploadpdf.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:UAS_project/controller/image_upload.dart';

class crud7 extends StatefulWidget {
  @override
  _crud7State createState() => _crud7State();
}

class _crud7State extends State<crud7> {
  final databaseReference = FirebaseDatabase.instance.ref('Group7');
  List<Data> dataList = [];
  // List<Map<String, dynamic>> dataList = [];

  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final nilaiController = TextEditingController();
  final jenisController = TextEditingController();
  final skemaController = TextEditingController();
  final tanggalController = TextEditingController();
  TextEditingController second = TextEditingController();

  TextEditingController third = TextEditingController();

  // String get valueKey => null;

  // @override
  // void initState() {
  //   super.initState();
  //   // getData();
  //   // }
  //   late DataSnapshot snapshot;
  //   Future<void> getData() async {
  //     await databaseReference.once().then((snapshot) {
  //       if (snapshot.snapshot.value != null) {
  //         dataList.clear();
  //         Map<dynamic, dynamic> values = snapshot.snapshot.value;
  //         values.forEach((key, values) {
  //           dataList.add(Data(
  //             key,
  //             values['nama'],
  //             values['nim'],
  //             values['nilai'].toDouble(),
  //             values['resume'],
  //           ));
  //         });
  //       }
  //     });
  //     setState(() {});
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // database = FirebaseDatabase.instance.ref().child('tabel');
    // Membaca data dari Firebase Realtime Database
    DataSnapshot snapshot;
    databaseReference.once().then((snapshot) {
      setState(() {
        dataList.clear();
        ReadWriteValue<DatabaseEvent> values = snapshot.val('Group7');
        values.val.snapshot.children.forEach((element) {
          // print(element.key);
          // print(element.value.val(element.key.toString()).val);
          var xx = element.value.val(element.key.toString()).val;
          // print(xx?['resume']);

          // Data(this.key, this.nama, this.nim, this.nilai, this.resume);
          // dataList.add(xx.val('resume').val);
        });
        // values.val((key, value) {
        //   dataList.add(Map<String, dynamic>.from(value));
        // });
      });
    });
  }

  late DataSnapshot snapshot;
  // readData() async {
  //   DatabaseEvent event = await databaseReference.once();
  //   var x = event.snapshot.value;
  //   print(x.val('0001'));
  //   return x;
  // }

//   void readData() async {
//     Stream<DatabaseEvent> stream = databaseReference.onValue;

// // Subscribe to the stream!
//     stream.listen((DatabaseEvent event) {
//       print('Event Type: ${event.type}'); // DatabaseEventType.value;
//       print('Snapshot: ${event.snapshot.child('0001').value}');
//       print(event.snapshot); // DataSnapshot
//     });
//   }

  void writeData(String nama, String email, double nilai, String jenis, String skema, String tanggal) {
    Random random = Random();
    String num = random.nextInt(50000000).toString();
    databaseReference.child(num).set({
      'Nama': nama,
      'Email': email,
      'Nilai': nilai,
      'Jenis': jenis,
      'Skema': skema,
      'Tanggal': tanggal,
    }).asStream();
  }

  void updateData(
      String key, String nama, String email, double nilai, String jenis,String skema, String tanggal) {
    databaseReference.child(key).update({
      'Nama': nama,
      'Email': email,
      'Nilai': nilai,
      'Jenis': jenis,
      'Skema': skema,
      'Tanggal': tanggal,
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
    nilaiController.clear();
    jenisController.clear();
    skemaController.clear();
    tanggalController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Data - Group 7'),
      ),
      body: 
          Padding(
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
                  controller: nilaiController,
                  decoration: InputDecoration(labelText: 'Nilai'),
                ),
                TextField(
                  controller: jenisController,
                  decoration: InputDecoration(labelText: 'Jenis'),
                ),
                TextField(
                  controller: skemaController,
                  decoration: InputDecoration(labelText: 'Skema'),
                ),
                TextField(
                  controller: tanggalController,
                  decoration: InputDecoration(labelText: 'Tanggal'),
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
                          double.parse(nilaiController.text),
                          jenisController.text,
                          skemaController.text,
                          tanggalController.text,
                        );
                        showDialog(
                        context: context,
                        builder: ((context) {
                          return AlertDialog(
                            title: Text('Success !!'),
                            content: Text('Data Added!'),
                          );
            }));
                      },
                      child: Text('Input Data'),
                      
                    ),
                  ],
                ),
                TextButton(
                  onPressed: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => pdfupload(),
                      ),
                    );
                  }),
                  child: Text("Input PDF")),
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
  final double nilai;
  final String jenis;
  final String skema;
  final String tanggal;

  Data(this.key, this.nama, this.email, this.nilai, this.jenis,this.skema,this.tanggal);
}
