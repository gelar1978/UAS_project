import 'dart:async';
import 'dart:math';
import 'package:UAS_project/Grup5/navbarview5.dart';
import 'package:UAS_project/Grup5/image_upload5.dart';
import 'package:UAS_project/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class crud5 extends StatefulWidget {
  @override
  _crud5State createState() => _crud5State();
}

class _crud5State extends State<crud5> {
  final databaseReference = FirebaseDatabase.instance.ref('Grup5');
  final fb = FirebaseDatabase.instance;
  List<Data> dataList = [];
  _myJenisState() {
    _selectedJenis = jenisKelamin[0];
  }

  _mySkemaState() {
    _selectedSkema = tipeSkema[0];
  }

  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final jenisKelamin = ['Pria', 'Wanita'];
  String? _selectedJenis = 'Pria';
  final nilaiController = TextEditingController();
  final tipeSkema = ['1', '2', '3'];
  String? _selectedSkema = '1';
  final tanggalController = TextEditingController();
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

  void writeData(String nama, String email, String jenis, double nilai,
      String skema, String tanggal) {
    Random random = Random();
    String num = random.nextInt(50000000).toString();
    databaseReference.child(num).set({
      'nama': nama,
      'email': email,
      'jenis': jenis,
      'nilai': nilai,
      'skema': skema,
      'tanggal': tanggal,
    }).asStream();
  }

  @override
  Widget build(BuildContext context) {
    var rng = Random();
    var k = rng.nextInt(10000);

    final ref = fb.ref().child('Grup5/$k');

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
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  DropdownButtonFormField(
                    value: _selectedJenis,
                    items: jenisKelamin
                        .map((e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedJenis = val as String;
                      });
                    },
                    icon: const Icon(Icons.arrow_drop_down),
                    decoration: InputDecoration(labelText: 'Jenis Kelamin'),
                  ),
                  TextField(
                    controller: nilaiController,
                    decoration: InputDecoration(labelText: 'Nilai'),
                  ),
                  DropdownButtonFormField(
                    value: _selectedSkema,
                    items: tipeSkema
                        .map((e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (skema) {
                      setState(() {
                        _selectedSkema = skema as String;
                      });
                    },
                    icon: const Icon(Icons.arrow_drop_down),
                    decoration: InputDecoration(labelText: 'Pilih Skema'),
                  ),
                  //Tanggal
                  TextField(
                      keyboardType: TextInputType.none,
                      controller: tanggalController,
                      decoration: InputDecoration(labelText: 'Pilih Tanggal'),
                      onTap: () async {
                        DateTime? pickeddate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100));

                        if (pickeddate != null) {
                          setState(() {
                            tanggalController.text =
                                DateFormat('dd-MM-yyyy').format(pickeddate);
                          });
                        }
                      }),
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
                            'email': emailController.text,
                            'jenis': _selectedJenis,
                            'nilai': double.parse(nilaiController.text),
                            'skema': _selectedSkema,
                            'tanggal': tanggalController.text,
                          }).asStream();
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => NavBarView5()));
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
                                builder: (context) => ImageUploads5(),
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
  final String email;
  final String jenis;
  final double nilai;
  final String skema;
  final String tanggal;

  Data(this.key, this.nama, this.email, this.jenis, this.nilai, this.skema,
      this.tanggal);
}
