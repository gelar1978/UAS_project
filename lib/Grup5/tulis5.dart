import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:UAS_project/Grup5/navbarview5.dart';
// import 'main.dart';

class addnote5 extends StatefulWidget {
  @override
  _addnote5State createState() => _addnote5State();
}

class _addnote5State extends State<addnote5> {
  TextEditingController second = TextEditingController();

  TextEditingController third = TextEditingController();

  final fb = FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    var rng = Random();
    var k = rng.nextInt(10000);

    final ref = fb.ref().child('Grup5/$k');

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Grup5"),
        backgroundColor: Colors.indigo[900],
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: second,
                decoration: InputDecoration(
                  hintText: 'title',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: third,
                decoration: InputDecoration(
                  hintText: 'sub title',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              color: Colors.indigo[900],
              onPressed: () {
                ref.set({
                  "title": second.text,
                  "subtitle": third.text,
                }).asStream();
                // Navigator.pop(context);
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => NavBarView5()));
              },
              child: Text(
                "save",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
