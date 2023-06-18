import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class viewdata3 extends StatelessWidget {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('Grup3');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "View Data",
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'View Data Grup3',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          backgroundColor: Colors.blue,
        ),
        body: FirebaseAnimatedList(
          query: _databaseReference,
          shrinkWrap: false,
          itemBuilder: (context, snapshot, animation, index) {
            var data = snapshot.value as Map<dynamic, dynamic>?;

            if (data == null) {
              return SizedBox.shrink();
            }

            String title = data['title'] ?? '';
            String subtitle = data['subtitle'] ?? '';

            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Hi'),
                    content: TextField(
                      controller: TextEditingController(text: subtitle),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Subtitle',
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
                        _databaseReference.child(snapshot.key!).remove();
                      },
                    ),
                    title: Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      subtitle,
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
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
