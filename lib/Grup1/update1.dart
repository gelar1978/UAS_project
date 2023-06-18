import 'package:UAS_project/Grup1/image_upload1.dart';
import 'package:UAS_project/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:UAS_project/Grup5/tulis5.dart';
import 'package:intl/intl.dart';

// import 'addnote.dart';

class update1 extends StatefulWidget {
  @override
  _update1State createState() => _update1State();
}

class _update1State extends State<update1> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Updatedata1",
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
  TextEditingController nim = TextEditingController();
  TextEditingController email = TextEditingController();
  final tipeStatus = ['A', 'B'];
  String? _selectedStatus = 'A';
  TextEditingController matakuliah = TextEditingController();

  var l;
  var g;
  var k;
  @override
  Widget build(BuildContext context) {
    final ref = fb.ref().child('Grup1');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo[900],
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ImageUploads1(),
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
              RegExp("{|}|email: |status: |nama: |nilai: |matakuliah: "),
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
                          decoration:
                              InputDecoration(labelText: 'Pilih Status'),
                        ),
                        TextField(
                          controller: nim,
                          decoration: InputDecoration(
                            hintText: 'nim',
                          ),
                        ),
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
    DatabaseReference ref1 = FirebaseDatabase.instance.ref("Grup1/$k");

// Only update the name, leave the age and address!
    await ref1.update({
      'nama': nama.text,
      'nim': nim.text,
      'status': _selectedStatus,
      'email': email.text,
      'matakuliah': matakuliah.text,
    });
    nama.clear();
    nim.clear();
    _selectedStatus = '';
    email.clear();
    matakuliah.clear();
  }
}
