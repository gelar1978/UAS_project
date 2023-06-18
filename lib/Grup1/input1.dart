import 'dart:async';
import 'dart:math';
import 'package:UAS_project/Grup1/navbarview1.dart';
import 'package:UAS_project/Grup1/image_upload1.dart';
import 'package:UAS_project/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class crud1 extends StatefulWidget {
  @override
  _crud1State createState() => _crud1State();
}

class _crud1State extends State<crud1> {
  final databaseReference = FirebaseDatabase.instance.ref('Grup1');
  final fb = FirebaseDatabase.instance;
  List<Data> dataList = [];
  _myJenisState() {
    _selectedStatus = tipeStatus[0];
  }

  final namaController = TextEditingController();
  final nimController = TextEditingController();
  final emailController = TextEditingController();
  final tipeStatus = ['A', 'B'];
  String? _selectedStatus = '1';
  final nilaiController = TextEditingController();
  final matakuliahControler = TextEditingController();
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

  void writeData(
      String nama, String nim, String email, String status, String matakuliah) {
    Random random = Random();
    String num = random.nextInt(50000000).toString();
    databaseReference.child(num).set({
      'nama': nama,
      'nim': nim,
      'email': email,
      'status': status,
      'matakuliah': matakuliah,
    }).asStream();
  }

  @override
  Widget build(BuildContext context) {
    var rng = Random();
    var k = rng.nextInt(10000);

    final ref = fb.ref().child('Grup1/$k');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.indigo[900],
        title: Text(
          'Input Database',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              // _showAlertDialog(context);
              AuthService.signOut();
              Navigator.pop(context);
            },
          ),
        ],
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
                  DropdownButtonFormField(
                    value: _selectedStatus,
                    items: tipeStatus
                        .map((e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedStatus = val as String;
                      });
                    },
                    icon: const Icon(Icons.arrow_drop_down),
                    decoration: InputDecoration(labelText: 'Pilih Status'),
                  ),
                  TextField(
                    controller: matakuliahControler,
                    decoration: InputDecoration(labelText: 'Mata Kuliah'),
                  ),

                  //Upload Foto
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.indigo[900]),
                        onPressed: () {
                          ref.set({
                            'nama': namaController.text,
                            'nim': emailController.text,
                            'email': emailController,
                            'status': _selectedStatus,
                            'matakuliah': matakuliahControler,
                          }).asStream();
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => NavBarView1()));
                        },
                        child: Text('Tambah Data'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.indigo[900]),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageUploads1(),
                              ));
                        },
                        child: Text('Upload Photo'),
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
  final String nim;
  final String email;
  final String status;
  final String matakuliah;

  Data(this.key, this.nama, this.nim, this.email, this.status, this.matakuliah);
}
