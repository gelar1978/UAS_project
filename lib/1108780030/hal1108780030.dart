// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:UAS_project/1108780030/imageView1108780030.dart';
import 'package:UAS_project/controller/image_upload.dart';
import 'package:UAS_project/services/auth_service.dart';
// import 'package:flutter/widgets.dart';

// import 'dart:math' as math;

// import 'package:flutter/material.dart';

// import 'center_widget.dart';

// import 'components/center_widget/center_widget.dart';
// import 'components/login_content.dart';

class hal1108780030old extends StatefulWidget {
  // final String message;
  hal1108780030old({super.key});

  @override
  State<hal1108780030old> createState() => _hal1108780030oldState();
}

class _hal1108780030oldState extends State<hal1108780030old> {
  final TextEditingController _textEditingController = TextEditingController();
  String _message = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gelar Budiman/Page-1'),
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
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: const BoxDecoration(
                  // color: Colors.red.withOpacity(0.1),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://anaktelkom.com/wp-content/uploads/2021/08/Logo-Telkom-University-900x1024.png'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.key),
                        hintText: 'Ketikkan 7 digit pertama NIM anda',
                      ),
                    ),
                    // Text('$message'),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              child: Text('Main Page'),
                              onPressed: () {
                                Navigator.pop(
                                    context, _textEditingController.text);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              child: Text('Next Page'),
                              onPressed: () async {
                                if (_textEditingController.text ==
                                    1108780.toString()) {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => hal1108780030_2(
                                          pesan1: _textEditingController.text),
                                    ),
                                  );
                                  setState(() {
                                    _message = result ?? '';
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("NIM/No. Telp."),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0), //or 15.0
                child: Container(
                  height: 70.0,
                  width: 370.0,
                  color: Color(0xffFF0E58),
                  child: Center(
                      child: Text(
                    _message,
                    style: TextStyle(fontSize: 28),
                  )),
                ),
              ),
              TextButton(
                  onPressed: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageUploads(),
                      ),
                    );
                  }),
                  child: Text("Upload Image")),
              TextButton(
                  onPressed: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageView(),
                      ),
                    );
                  }),
                  child: Text("View Image"))
            ],
          ),
        ],
      ),
    );
  }
}

class hal1108780030_2 extends StatefulWidget {
  // hal1108780030_2({super.key,required this.pesan1});
  String pesan1 = '';
  hal1108780030_2({super.key, required this.pesan1});
  @override
  _hal1108780030_2State createState() => _hal1108780030_2State();
}

class _hal1108780030_2State extends State<hal1108780030_2> {
  String NIM7 = "";
  TextEditingController _textEditingController0 = TextEditingController();
  TextEditingController _textEditingController1 = TextEditingController();
  TextEditingController _textEditingController2 = TextEditingController();

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gelar Budiman/Page-2'),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.all(10)),
                    TextField(
                      controller: _textEditingController0,
                      decoration: InputDecoration(
                        icon: Icon(Icons.key),
                        hintText: 'Ketikkan Alamat Email Anda',
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    TextField(
                      controller: _textEditingController1,
                      decoration: InputDecoration(
                        icon: Icon(Icons.key),
                        hintText: 'Ketikkan No Handphone Anda',
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    TextField(
                      controller: _textEditingController2,
                      decoration: InputDecoration(
                        icon: Icon(Icons.key),
                        hintText: 'Masukkan digit ke-8 NIM anda',
                      ),
                    ),
                    // Text('$message'),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              child: Text('Previous Page'),
                              onPressed: () {
                                Navigator.pop(context, NIM7);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              child: Text('Next Page'),
                              onPressed: () async {
                                if (_textEditingController2.text ==
                                    0.toString()) {
                                  List<String> datakehal3 = [
                                    widget.pesan1,
                                    _textEditingController0.text,
                                    _textEditingController1.text,
                                    _textEditingController2.text
                                  ];
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => hal1108780030_3(
                                        nim: widget.pesan1 +
                                            _textEditingController2.text,
                                        email: _textEditingController0.text,
                                        nomor: _textEditingController1.text,
                                      ),
                                    ),
                                  );
                                  setState(() {
                                    NIM7 = result ?? '';
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("NIM/No. Telp."),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0), //or 15.0
                child: Container(
                  height: 70.0,
                  width: 370.0,
                  color: Color(0xffFF0E58),
                  child: Center(
                      child: Text(
                    NIM7,
                    style: TextStyle(fontSize: 28),
                  )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class hal1108780030_3 extends StatefulWidget {
  // hal1108780030_2({super.key,required this.pesan1});
  // List<String> pesan1 = Null;
  String email, nomor, nim = "";
  hal1108780030_3(
      {super.key, required this.nim, required this.email, required this.nomor});
  @override
  State<hal1108780030_3> createState() => _hal1108780030_3State();
}

class _hal1108780030_3State extends State<hal1108780030_3> {
  String NIM8 = "";
  // String email = "";
  // String nohp = "";
  TextEditingController _textEditingController0 = TextEditingController();
  TextEditingController _textEditingController1 = TextEditingController();
  TextEditingController _textEditingController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gelar Budiman/Page-3'),
      ),
      body: ListView(
        children: [Text("Halaman 3")],
      ),
    );
  }
}
