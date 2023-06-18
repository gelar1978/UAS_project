import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

// import 'addnote.dart';

class view4 extends StatefulWidget {
  @override
  _view4State createState() => _view4State();
}

class _view4State extends State<view4> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "view data app",
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 53, 122, 7),
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
  TextEditingController fourth = TextEditingController();
  TextEditingController fifth = TextEditingController();
  var l;
  var g;
  var k;
  @override
  Widget build(BuildContext context) {
    final ref = fb.ref().child('Grup4');

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.indigo[900],
      //   onPressed: () {
      //     Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(
      //         builder: (_) => addnote7(),
      //       ),
      //     );
      //   },
      //   child: Icon(
      //     Icons.add,
      //   ),
      // ),
      appBar: AppBar(
        title: Text(
          'View Data Bro',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
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
              RegExp("{|}|subtitle: |title: "), ""); // webfun, subscribe
          g.trim();

          l = g.split(','); // [webfun,  subscribe}]
          print(l);
          return GestureDetector(
            onTap: () {
              setState(() {
                k = snapshot.key;
              });

              // showDialog(
              //   context: context,
              //   builder: (ctx) => AlertDialog(
              //     title: Container(
              //       decoration: BoxDecoration(border: Border.all()),
              //       child: TextField(
              //         controller: second,
              //         textAlign: TextAlign.center,
              //         decoration: InputDecoration(
              //           hintText: 'title',
              //         ),
              //       ),
              //     ),
              //     content: Container(
              //       decoration: BoxDecoration(border: Border.all()),
              //       child: TextField(
              //         controller: third,
              //         textAlign: TextAlign.center,
              //         decoration: InputDecoration(
              //           hintText: 'sub title',
              //         ),
              //       ),
              //     ),
              //     actions: <Widget>[
              //       MaterialButton(
              //         onPressed: () {
              //           Navigator.of(ctx).pop();
              //         },
              //         color: Color.fromARGB(255, 0, 22, 145),
              //         child: Text(
              //           "Cancel",
              //           style: TextStyle(
              //             color: Colors.white,
              //           ),
              //         ),
              //       ),
              //       MaterialButton(
              //         onPressed: () async {
              //           await upd();
              //           Navigator.of(ctx).pop();
              //         },
              //         color: Color.fromARGB(255, 0, 22, 145),
              //         child: Text(
              //           "Update",
              //           style: TextStyle(
              //             color: Colors.white,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // );
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
                  // trailing: IconButton(
                  //   icon: Icon(
                  //     Icons.delete,
                  //     color: Color.fromARGB(255, 255, 0, 0),
                  //   ),
                  //   onPressed: () {
                  //     ref.child(snapshot.key!).remove();
                  //   },
                  // ),
                  title: Text(
                    'No ' + snapshot.key.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l[0],
                        // Nama
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        l[1],
                        // Email
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        l[2],
                        // Jenis
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        l[3],
                        // teks
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
    DatabaseReference ref1 = FirebaseDatabase.instance.ref("Grup4/$k");

// Only update the name, leave the age and address!
    await ref1.update({
      "title": second.text,
      "subtitle": third.text,
    });
    second.clear();
    third.clear();
  }
}
