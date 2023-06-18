import 'package:UAS_project/Grup5/image_upload5.dart';
import 'package:UAS_project/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:UAS_project/Grup5/tulis5.dart';
import 'package:intl/intl.dart';

// import 'addnote.dart';

class update5 extends StatefulWidget {
  @override
  _update5State createState() => _update5State();
}

class _update5State extends State<update5> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Updatedata5",
      theme: ThemeData(
        primaryColor: Colors.greenAccent[700],
      ),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final fb = FirebaseDatabase.instance;
  TextEditingController nama = TextEditingController();
  TextEditingController email = TextEditingController();
  final jenisKelamin = ['Pria', 'Wanita'];
  String? _selectedJenis = 'Pria';
  TextEditingController nilai = TextEditingController();
  final tipeSkema = ['1', '2', '3'];
  String? _selectedSkema = '1';
  TextEditingController tanggal = TextEditingController();

  var l;
  var g;
  var k;
  @override
  Widget build(BuildContext context) {
    final ref = fb.ref().child('Grup5');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo[900],
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ImageUploads5(),
              ));
        },
        child: Icon(Icons.add_a_photo),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'UpdateData',
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
        backgroundColor: Colors.indigo[900],
      ),
      body: FirebaseAnimatedList(
        query: ref,
        shrinkWrap: true,
        itemBuilder: (context, snapshot, animation, index) {
          var v =
              snapshot.value.toString(); // {subtitle: webfun, title: subscribe}
          ref.onValue.listen((event) {
            var ss = event.snapshot;
          });
          g = v.replaceAll(
              RegExp("{|}|email: |jenis: |nama: |nilai: |tanggal: "),
              ""); // webfun, subscribe
          g.trim();

          l = g.split(','); // [webfun,  subscribe}]
          print(l);
          return GestureDetector(
            onTap: () {
              setState(() {
                k = snapshot.key;
              });

              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  scrollable: true,
                  title: Container(
                    padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                    child: Column(
                      children: [
                        TextField(
                          controller: nama,
                          decoration: InputDecoration(
                            hintText: 'nama',
                          ),
                        ),
                        TextField(
                          controller: email,
                          decoration: InputDecoration(
                            hintText: 'email',
                          ),
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
                          decoration:
                              InputDecoration(labelText: 'Jenis Kelamin'),
                        ),
                        TextField(
                          controller: nilai,
                          decoration: InputDecoration(
                            hintText: 'nilai',
                          ),
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
                        TextField(
                            keyboardType: TextInputType.none,
                            controller: tanggal,
                            decoration:
                                InputDecoration(labelText: 'Pilih Tanggal'),
                            onTap: () async {
                              DateTime? pickeddate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100));

                              if (pickeddate != null) {
                                setState(() {
                                  tanggal.text = DateFormat('dd-MM-yyyy')
                                      .format(pickeddate);
                                });
                              }
                            }),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      color: Color.fromARGB(255, 0, 22, 145),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        await upd();
                        Navigator.of(ctx).pop();
                      },
                      color: Color.fromARGB(255, 0, 22, 145),
                      child: Text(
                        "Update",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: Colors.indigo[100],
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Color.fromARGB(255, 255, 0, 0),
                    ),
                    onPressed: () {
                      ref.child(snapshot.key!).remove();
                    },
                  ),
                  title: Text(
                    l[0],
                    // 'dd',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    l[3],
                    // 'dd',

                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  upd() async {
    DatabaseReference ref1 = FirebaseDatabase.instance.ref("Grup5/$k");

// Only update the name, leave the age and address!
    await ref1.update({
      'nama': nama.text,
      'email': email.text,
      'jenis': _selectedJenis,
      'nilai': double.parse(nilai.text),
      'skema': _selectedSkema,
      'tanggal': tanggal.text,
    });
    nama.clear();
    email.clear();
    _selectedJenis = '';
    nilai.clear();
    _selectedSkema = '';
    tanggal.clear();
  }
}
