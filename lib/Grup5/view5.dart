import 'package:UAS_project/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:UAS_project/Grup5/tulis5.dart';

// import 'addnote.dart';

class baca5 extends StatefulWidget {
  @override
  _baca5State createState() => _baca5State();
}

class _baca5State extends State<baca5> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Viewdata",
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
  TextEditingController second = TextEditingController();

  TextEditingController third = TextEditingController();
  var l;
  var g;
  var k;
  @override
  Widget build(BuildContext context) {
    final ref = fb.ref().child('Grup5');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ViewData',
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
              RegExp("{|}|email: |jenis: |nama: |nilai: |skema: |tanggal: "),
              ""); // webfun, subscribe
          g.trim();

          l = g.split(','); // [webfun,  subscribe}]
          print(l);
          return Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                        color: Color.fromARGB(255, 32, 32, 32),
                        offset: new Offset(-2, 2),
                        blurRadius: 5)
                  ],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.indigo[100]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l[0],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Nilai: ' + l[1],
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
                  Text('Skema: ' + l[2],
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
                  Text('Jenis Kelamin: ' + l[3],
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
                  Text('Tanggal Lahir: ' + l[4],
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
                  Text('Email: ' + l[5],
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
                ],
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
      "title": second.text,
      "subtitle": third.text,
    });
    second.clear();
    third.clear();
  }
}
