import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'Grup1/login1.dart';
import 'Grup2/login2.dart';
import 'Grup3/login3.dart';
import 'Grup4/login4.dart';
import 'Grup5/login5.dart';
import 'Grup6/login6.dart';
import 'Grup7/login7.dart';
import 'data.dart' as data;
import '1108780030/login1108780030.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    androidProvider: AndroidProvider.debug,
  );
  runApp(const Hal1());
}

class Hal1 extends StatefulWidget {
  const Hal1({super.key});
  @override
  State<Hal1> createState() => _Hal1State();
}

class _Hal1State extends State<Hal1> {
// data[]
  String _message = '';
  List<int> NIM = data.datamhs.keys.toList();
  List<String> Nama = data.datamhs.values.toList();
  // @overrides
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UAS_project',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('MobApp'),
        ),
        body: ListView.builder(
          itemCount: NIM.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () async {
                if (NIM[index] == 1) {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => login1(),
                    ),
                  );
                  setState(() {
                    _message = result ?? '';
                  });
                } else if (NIM[index] == 2) {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => login2(),
                    ),
                  );
                  setState(() {
                    _message = result ?? '';
                  });
                } else if (NIM[index] == 3) {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => login3(),
                    ),
                  );
                  setState(() {
                    _message = result ?? '';
                  });
                } else if (NIM[index] == 4) {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => login4(),
                    ),
                  );
                  setState(() {
                    _message = result ?? '';
                  });
                } else if (NIM[index] == 5) {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => login5(),
                    ),
                  );
                  setState(() {
                    _message = result ?? '';
                  });
                } else if (NIM[index] == 6) {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => login6(),
                    ),
                  );
                  setState(() {
                    _message = result ?? '';
                  });
                } else if (NIM[index] == 7) {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => login7(),
                    ),
                  );
                  setState(() {
                    _message = result ?? '';
                  });
                }
              },
              leading: CircleAvatar(
                child: Text(Nama[index].substring(0, 1)),
                // backgroundColor: Colors,
                // backgroundImage: NetworkImage(Nama[index]),
              ),
              title: Text(Nama[index]),
              subtitle: Text(NIM[index].toString()),
            );
          },
        ),
      ),
    );
  }
}
