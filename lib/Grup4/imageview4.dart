import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_download_example/api/firebase_api.dart';
// import 'package:firebase_download_example/model/firebase_file.dart';
// import 'package:firebase_download_example/page/image_page.dart';
import 'package:flutter/material.dart';
import 'package:UAS_project/Grup4/navbar4.dart';
import 'package:UAS_project/api/firebase_api.dart';
import 'package:UAS_project/controller/image_view.dart';
import 'package:UAS_project/model/firebase_file.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp();

//   runApp(MyApp());
// }

class ImageView extends StatelessWidget {
  static final String title = 'View and Download';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: imageview(),
      );
}

class imageview extends StatefulWidget {
  @override
  _imageviewState createState() => _imageviewState();
}

class _imageviewState extends State<imageview> {
  // late Future<List<FirebaseFile>> futureFiles;
  late Future<ListResult> futureFiles;
  Map<int, double> downloadProgress = {};
  @override
  void initState() {
    super.initState();
    // futureFiles = FirebaseStorage.instance.ref('/files').listAll();
    futureFiles = FirebaseStorage.instance.ref('/Group4/citraW/').listAll();
// gs://mobapp-2223-2.appspot.com/files/kolaborasi 1.png/file
    // futureFiles = FirebaseApi.listAll('files/');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(ImageView.title),
          centerTitle: true,
          actions: <Widget>[
            // IconButton(
            //   icon: const Icon(
            //     Icons.arrow_back,
            //     color: Colors.white,
            //   ),
            //   onPressed: () {
            //     // Navigator.of(context).pop();
            //     // Navigator.of(context).canPop();
            //     // Navigator.of(context, rootNavigator: true).pop(context);
            //     Navigator.push(context, MaterialPageRoute(builder: (context) {
            //       return NavBarView();
            //     }));
            //     // Navigator.pop(context);
            //   },
            // ),
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
                  // if (snapshot.connectionState == ConnectionState.done) {
                  //   // here you should do your worj
                  //   final files = snapshot.data!.items;
                  //   // print(snapshot.data!.items);
                  //   // print('done');
                  //   // print(snapshot.connectionState);

                  //   // FirebaseAppCheck firebaseAppCheck =
                  //   //     FirebaseAppCheck.instance;
                  //   // firebaseAppCheck.getToken();
                  // }
                  // if (snapshot.connectionState == ConnectionState.active) {
                  //   // or here if you take data in pages

                  //   final files = snapshot.data!.items;
                  //   print(snapshot.data!.items);
                  //   print('done2');
                  // }
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
      );

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
    // final dir = await getApplicationDocumentsDirectory();
    // final file = File('${dir.path}/${ref.name}');
    // await ref.writeToFile(file);
// await Dio().
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
}
