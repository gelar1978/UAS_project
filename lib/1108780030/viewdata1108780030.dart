import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'user1108780030.dart' as data1108780030;

class View1108780030 extends StatefulWidget {
  const View1108780030({super.key});
  @override
  State<View1108780030> createState() => _View1108780030State();
}

class _View1108780030State extends State<View1108780030> {
// data[]
  String _message = '';

// Map<int, String> Nama=Data.
  // TextEditingController _textEditingController0 = TextEditingController();
  List<int> NIM = data1108780030.index.values.toList();
  List<String> Nama = data1108780030.nama.values.toList();
  // @overrides
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('List View with CircleAvatar'),
        ),
        body: ListView.builder(
          itemCount: NIM.length,
          itemBuilder: (context, index) {
            return ListTile(
              // onTap: () async {
              //   final result = await Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => hal1108780030new(),
              //     ),
              //   );
              //   setState(() {
              //     _message = result ?? '';
              //   });
              // },
              trailing: CircleAvatar(
                child: Text(Nama[index]),
                // backgroundColor: Colors,
                // backgroundImage: NetworkImage(Nama[index]),
              ),
              leading: CircleAvatar(
                child: Text(NIM[index].toString()),
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
