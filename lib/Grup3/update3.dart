import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class update3 extends StatefulWidget {
  const update3({Key? key, required this.nilaiMhsKey}) : super(key: key);

  final String nilaiMhsKey;

  @override
  State<update3> createState() => _update3State();
}

class _update3State extends State<update3> {
  final namaController = TextEditingController();
  final nimController = TextEditingController();
  final emailController = TextEditingController();
  final statusController = TextEditingController();
  final kodemkController = TextEditingController();
  final jawabanController = TextEditingController();

  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance
        .ref()
        .child('Grup3')
        .child(widget.nilaiMhsKey);
    getStudentData();
  }

  void getStudentData() async {
    DataSnapshot snapshot = await dbRef.get();

    if (snapshot.value != null) {
      Map<dynamic, dynamic>? nilaiMhs =
          snapshot.value as Map<dynamic, dynamic>?;
      if (nilaiMhs != null) {
        namaController.text = nilaiMhs['nama'];
        nimController.text = nilaiMhs['nim'];
        emailController.text = nilaiMhs['email'];
        statusController.text = nilaiMhs['status'];
        kodemkController.text = nilaiMhs['kodemk'];
        jawabanController.text = nilaiMhs['jawaban'];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('UPDATING DATA'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Please Fill the Following Data',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: namaController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nama',
                    hintText: 'Masukkan Nama',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: nimController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'NIM',
                    hintText: 'Masukkan Nim',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Masukkan Email',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: statusController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Status',
                    hintText: 'Status',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: kodemkController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'kode mk',
                    hintText: 'kode mk',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: jawabanController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'jawaban',
                    hintText: 'jawaban anda',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                MaterialButton(
                  onPressed: () {
                    Map<String, dynamic> nilaiMhs = {
                      'nama': namaController.text,
                      'nim': nimController.text,
                      'email': emailController.text,
                      'kelas': statusController.text,
                      'dosen': kodemkController.text,
                      'jawaban': jawabanController.text,
                    };
                    dbRef
                        .update(nilaiMhs)
                        .then((value) => Navigator.pop(context));
                  },
                  child: const Text('Update Data'),
                  color: Colors.blue,
                  textColor: Color.fromARGB(255, 31, 18, 18),
                  minWidth: 300,
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
