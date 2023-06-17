import 'package:UAS_project/Grup6/color6.dart';
import 'package:UAS_project/Grup6/update6.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class read6 extends StatefulWidget {
  const read6({Key? key}) : super(key: key);

  @override
  State<read6> createState() => _FetchDataState();
}

class _FetchDataState extends State<read6> {
  Query dbRef = FirebaseDatabase.instance.ref().child('Grup6');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Grup6');

  Widget listItem({required Map nilaiMhs}) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 250,
      color: Color.fromARGB(82, 236, 103, 94),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Name:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
              ),
              Text(
                nilaiMhs['nama'] ?? '',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "NIM:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
              ),
              Text(
                nilaiMhs['nim'] ?? '',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "E-Mail:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
              ),
              Text(
                nilaiMhs['email'] ?? '',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Class:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
              ),
              Text(
                nilaiMhs['kelas'] ?? '',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Teacher:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
              ),
              Text(
                nilaiMhs['dosen'] ?? '',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Grade:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
              ),
              Text(
                nilaiMhs['nilai'].toString() ?? '',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Answer:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
              ),
              Text(
                nilaiMhs['jawaban'] ?? '',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => update6(nilaiMhsKey: nilaiMhs['key']),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: Color6.lightSecondaryColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              GestureDetector(
                onTap: () {
                  reference.child(nilaiMhs['key']).remove();
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Color6.lightSecondaryColor,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    theme:
    ThemeData(
      primaryColor: Color6.lightPrimaryColor,
      fontFamily: 'Montserrat',
    );
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color6.lightPrimaryColor,
          title: const Text('LIST DATA'),
        ),
        body: Container(
          height: double.infinity,
          child: FirebaseAnimatedList(
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map nilaiMhs = snapshot.value as Map;
              nilaiMhs['key'] = snapshot.key;

              return listItem(nilaiMhs: nilaiMhs);
            },
          ),
        ));
  }
}
