import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';

class RE_1108780030 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final databaseReference = FirebaseDatabase.instance.ref().child('users1');
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  final TextEditingController namaController = TextEditingController();
  final TextEditingController nimController = TextEditingController();
  final TextEditingController nilaiController = TextEditingController();
  final TextEditingController resumeController = TextEditingController();
  String selectedKey = 'users1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read and Edit Data '),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
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
              onPressed: () {
                if (selectedKey != null) {
                  // Update data
                  selectedKey = "users1";
                  print(selectedKey);
                  databaseReference.child(selectedKey).update({
                    'nama': namaController.text,
                    'nim': int.tryParse(nimController.text) ?? 0,
                    'nilai': double.tryParse(nilaiController.text) ?? 0.0,
                    'resume': resumeController.text,
                  }).then((value) {
                    print("Data berhasil diperbarui di database.");
                    setState(() {
                      selectedKey = '';
                    });
                  }).catchError((error) {
                    print("Terjadi kesalahan saat memperbarui data: $error");
                  });
                } else {
                  // Tambah data baru
                  databaseReference.push().set({
                    'nama': namaController.text,
                    'nim': int.tryParse(nimController.text) ?? 0,
                    'nilai': double.tryParse(nilaiController.text) ?? 0.0,
                    'resume': resumeController.text,
                  }).then((value) {
                    print("Data berhasil ditambahkan ke database.");
                  }).catchError((error) {
                    print("Terjadi kesalahan saat menambahkan data: $error");
                  });
                }
              },
              child: Text(
                  selectedKey != null ? 'Perbarui Data' : 'Simpan ke Database'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Data dari Database:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: StreamBuilder(
                stream: databaseReference.onValue,
                builder: (context, snapshot) {
                  dynamic xx = snapshot.data?.snapshot.value;
                  if (snapshot.hasData &&
                      snapshot.data?.snapshot.value != null) {
                    Map<dynamic, dynamic> values = xx;
                    List<dynamic> keys = values.keys.toList();
                    return ListView.builder(
                      itemCount: values.length,
                      itemBuilder: (context, index) {
                        String key = keys[index];
                        Map<dynamic, dynamic> data = values[key];

                        return ListTile(
                          title: Text(data['nama']),
                          subtitle: Text(
                              'NIM: ${data['nim']}, Nilai: ${data['nilai']}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  setState(() {
                                    selectedKey = key;
                                    namaController.text = data['nama'];
                                    nimController.text = data['nim'].toString();
                                    nilaiController.text =
                                        data['nilai'].toString();
                                    resumeController.text = data['resume'];
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  databaseReference
                                      .child(key)
                                      .remove()
                                      .then((value) {
                                    print(
                                        "Data berhasil dihapus dari database.");
                                  }).catchError((error) {
                                    print(
                                        "Terjadi kesalahan saat menghapus data: $error");
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('Tidak ada data'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
