import 'dart:io';
import 'package:downloads_path_provider/downloads_path_provider.dart';  
import 'package:dio/dio.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:UAS_project/Grup7/nav7.dart';
import 'package:UAS_project/api/firebase_api.dart';
import 'package:UAS_project/controller/image_view.dart';
import 'package:UAS_project/model/firebase_file.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class ImageView extends StatelessWidget {
  static final String title = 'Firebase Download';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MainPage(),
      );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<ListResult> futureFiles;
  Map<int, double> downloadProgress = {};

  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseStorage.instance.ref('/Group7').listAll();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(ImageView.title),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NavBarView();
                }));
              },
            ),
          ],
        ),
        body: FutureBuilder<ListResult>(
          future: futureFiles,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Some error occurred!'));
                } else {
                  final files = snapshot.data!.items;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildHeader(files.length),
                      const SizedBox(height: 12),
                      Expanded(
                        child: ListView.builder(
                          itemCount: files.length,
                          itemBuilder: (context, index) {
                            final file = files[index];
                            double? progress = downloadProgress[index];
                            return ListTile(
                              title: Text(file.name),
                              subtitle: progress != null
                                  ? LinearProgressIndicator(
                                      value: progress,
                                      backgroundColor: Colors.black)
                                  : null,
                              trailing: IconButton(
                                onPressed: () => downloadFile(index, file),
                                icon: Icon(Icons.download),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
            }
          },
        ),
      );

  Widget buildHeader(int length) => ListTile(
        tileColor: Colors.blue,
        leading: Container(
          width: 52,
          height: 52,
          child: Icon(
            Icons.file_copy,
            color: Colors.white,
          ),
        ),
        title: Text(
          '$length Files',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      );

  Future downloadFile(int index, Reference ref) async {
  // Mendapatkan URL unduhan
  
  final url = await ref.getDownloadURL();

  // Mendapatkan direktori download pada perangkat
  final downloadsDir = await DownloadsPathProvider.downloadsDirectory;

  // Mendapatkan path file yang akan disimpan
  final filePath = '${downloadsDir.path}/${ref.name}';

  // Mendownload file dan menyimpannya ke path yang ditentukan
  await Dio().download(url, filePath, onReceiveProgress: (received, total) {
    double progress = received / total;
    setState(() {
      downloadProgress[index] = progress;
    });
  });

  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text('Downloaded ${ref.name}')));
}
}
