import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Tulis1108780030 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Write to RT Firebase DB',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final databaseReference = FirebaseDatabase.instance.ref().child(
  //     'https://mobapp-2223-2-default-rtdb.asia-southeast1.firebasedatabase.app/');
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController nimController = TextEditingController();
  final TextEditingController nilaiController = TextEditingController();
  final TextEditingController resumeController = TextEditingController();

  void _tulisData() {
    String nama = namaController.text;
    int nim = int.tryParse(nimController.text) ?? 0;
    double nilai = double.tryParse(nilaiController.text) ?? 0.0;
    String resume = resumeController.text;

    Map<String, dynamic> data = {
      'nama': nama,
      'nim': nim,
      'nilai': nilai,
      'resume': resume,
    };

    databaseReference.child("Students").push().set(data).then((value) {
      print("Data berhasil ditulis ke database.");
    }).catchError((error) {
      print("Terjadi kesalahan: $error");
    });
    // databaseReference.push().set(data).then((value) {
    //   print("Data berhasil ditulis ke database.");
    // }).catchError((error) {
    //   print("Terjadi kesalahan: $error");
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              children: [
                TextField(
                  controller: namaController,
                  decoration: InputDecoration(
                    labelText: 'Nama',
                  ),
                ),
                TextField(
                  controller: nimController,
                  decoration: InputDecoration(
                    labelText: 'NIM',
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: nilaiController,
                  decoration: InputDecoration(
                    labelText: 'Nilai',
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                TextField(
                  controller: resumeController,
                  decoration: InputDecoration(
                    labelText: 'Resume',
                  ),
                  maxLines: null,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _tulisData,
                  child: Text('Simpan ke Database'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
