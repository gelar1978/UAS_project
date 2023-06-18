import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:UAS_project/Grup1/image_upload1.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:UAS_project/controller/image_upload.dart';

class crud1 extends StatefulWidget {
  @override
  _crud1State createState() => _crud1State();
}

class _crud1State extends State<crud1> {
  final databaseReference = FirebaseDatabase.instance.ref('Grup1');
  List<Data> dataList = [];
  // List<Map<String, dynamic>> dataList = [];

  final namaController = TextEditingController();
  final nimController = TextEditingController();
  final emailController = TextEditingController();
  final matakuliahController = TextEditingController();
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
        ReadWriteValue<DatabaseEvent> values = snapshot.val('Grup1');
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

  void writeData(String nama, String nim, String email, String matakuliah) {
    Random random = Random();
    String num = random.nextInt(50000000).toString();
    databaseReference.child(num).set({
      'Nama': nama,
      'nim': nim,
      'email': email,
      'matakuliah': matakuliah,
    }).asStream();
  }

  void updateData(String nama, String nim, String email, String matakuliah) {
    databaseReference.child(key).update({
      'Nama': nama,
      'nim': nim,
      'email': email,
      'matakuliah': matakuliah,
    }).asStream();
  }

  get key => key;

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
    matakuliahController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Data - Grop 1'),
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
              controller: nimController,
              decoration: InputDecoration(labelText: 'NIM'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: matakuliahController,
              decoration: InputDecoration(labelText: 'MataKuliah'),
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
                      nimController.text,
                      emailController.text,
                      matakuliahController.text,
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
                      builder: (context) => ImageUploads1(),
                    ),
                  );
                }),
                child: Text("Unggah Jawaban")),
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
  final String nim;
  final double email;
  final String matakuliah;

  Data(this.key, this.nama, this.nim, this.email, this.matakuliah);
}
