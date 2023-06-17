import 'dart:io';

import 'package:UAS_project/Grup2/folderView.dart';
import 'package:dio/dio.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:UAS_project/Grup2/nav2.dart';
import 'package:UAS_project/api/firebase_api.dart';
import 'package:UAS_project/controller/image_view.dart';
import 'package:UAS_project/model/firebase_file.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class ImageView_W extends StatefulWidget {
  static final String title = 'Firebase Download';

  @override
  State<ImageView_W> createState() => _ImageView_WState();
}

class _ImageView_WState extends State<ImageView_W> {
  late Future<ListResult> futureFiles;
  Map<int, double> downloadProgress = {};
  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseStorage.instance.ref('/Grup2/CitraW').listAll();
  }

  Widget buildFile(BuildContext context, FirebaseFile file) => ListTile(
        leading: ClipOval(
          child: Image.network(
            file.url,
            width: 52,
            height: 52,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          file.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            color: Colors.blue,
          ),
        ),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ImagePage(file: file),
        )),
      );

  Future downloadFile(int index, Reference ref) async {
    final url = await ref.getDownloadURL();
    final tempdir = await getTemporaryDirectory();
    final path = '${tempdir.path}/${ref.name}';
    await Dio().download(url, path, onReceiveProgress: (received, total) {
      double progress = received / total;
      setState(() {
        downloadProgress[index] = progress;
      });
    });
    if (url.contains('.mp4')) {
      await GallerySaver.saveVideo(path, toDcim: true);
    } else if (url.contains('.jpg')) {
      await GallerySaver.saveImage(path, toDcim: true);
    } else if (url.contains('.png')) {
      await GallerySaver.saveImage(path, toDcim: true);
    } else if (url.contains('.bmp')) {
      Directory dcimDir = Directory('/storage/emulated/0/DCIM');
      String localPath = '${dcimDir.path}/${ref.name}';
      File localFile = File(localPath);
      await ref.writeToFile(localFile);
      print('File berhasil diunduh ke $localPath');
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Downloaded ${ref.name}')));
  }

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
  @override
  Widget build(BuildContext context) => MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ImageView_W.title,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text(ImageView_W.title),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                // Navigator.of(context).pop();
                // Navigator.of(context).canPop();
                // Navigator.of(context, rootNavigator: true).pop(context);
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return NavBarView();
                //   // return folderView2();
                // }));
                Navigator.pop(context);
                // Navigator.canPop(context);
                // Navigator.maybePop(context);
              },
            ),
          ],
        ),
        // body: FutureBuilder<List<FirebaseFile>>(
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
                  // print(snapshot.data!.items);

                  // print(files);
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
                            // return buildFile(context, file);
                            return ListTile(
                              title: Text(file.name),
                              subtitle: progress != null
                                  ? LinearProgressIndicator(
                                      value: progress,
                                      backgroundColor: Colors.black)
                                  : null,
                              trailing: IconButton(
                                  onPressed: () => downloadFile(index, file),
                                  icon: const Icon(Icons.download)),
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
      ));
}
