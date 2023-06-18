import 'package:UAS_project/api/firebase_api.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../model/firebase_file.dart';

class viewpdf3 extends StatefulWidget {
  final FirebaseFile file;

  const viewpdf3({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  _viewpdf3State createState() => _viewpdf3State();
}

class _viewpdf3State extends State<viewpdf3> {
  late Future<ListResult> futureFiles;
  Map<int, double> downloadProgress = {};

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseStorage.instance.ref('Grup3').listAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('VIEW FILES'),
      ),
      body: FutureBuilder<ListResult>(
        future: futureFiles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final files = snapshot.data!.items;

            return ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                final file = files[index];
                double? progress = downloadProgress[index];

                return ListTile(
                  title: Text(file.name),
                  subtitle: progress != null
                      ? LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.blue,
                        )
                      : null,
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.download,
                      color: Colors.blue,
                    ),
                    onPressed: () => downloadFile(index, file),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          } else {
            return const Center();
          }
        },
      ),
    );
  }

  Future downloadFile(int index, Reference ref) async {
    final url = await ref.getDownloadURL();
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/${ref.name}';
    print(url);
    print(dir);
    print(path);
    await Dio().download(
      url,
      path,
      onReceiveProgress: (received, total) {
        double progress = received / total;
        setState(() {
          downloadProgress[index] = progress;
        });
      },
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Downloaded ${ref.name}'),
      ),
    );

    // Navigate to ViewFile3
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => viewpdf3(
          file: FirebaseFile(ref: ref, name: ref.name, url: path),
        ),
      ),
    );
  }
}
