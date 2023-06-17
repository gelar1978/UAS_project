import 'package:UAS_project/Grup6/color6.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class update6 extends StatefulWidget {
  const update6({Key? key, required this.nilaiMhsKey}) : super(key: key);

  final String nilaiMhsKey;

  @override
  State<update6> createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<update6> {
  final userNameController = TextEditingController();
  final userNimController = TextEditingController();
  final userEmailController = TextEditingController();
  final userClassController = TextEditingController();
  final userDosenController = TextEditingController();
  final userAnsController = TextEditingController();
  final userGradeController = TextEditingController();

  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Grup6');
    getStudentData();
  }

  void getStudentData() async {
    DataSnapshot snapshot = await dbRef.child(widget.nilaiMhsKey).get();

    Map nilaiMhs = snapshot.value as Map;

    userNameController.text = nilaiMhs['name'];
    userNimController.text = nilaiMhs['nim'];
    userEmailController.text = nilaiMhs['email'];
    userClassController.text = nilaiMhs['kelas'];
    userDosenController.text = nilaiMhs['dosen'];
    userAnsController.text = nilaiMhs['jawaban'];
    userGradeController.text = nilaiMhs['nilai'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color6.lightPrimaryColor,
        title: Text('UPDATING DATA'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Please Fill the Following Data',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: userNameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    hintText: 'Enter New Name',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: userNimController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'NIM',
                    hintText: 'Enter New NIM',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: userEmailController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter New Email',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: userClassController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Class',
                    hintText: 'Enter New Class',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: userDosenController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Teacher',
                    hintText: 'Enter New Teacher',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: userGradeController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Grade',
                    hintText: 'Enter New Grade',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: userAnsController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Answer',
                    hintText: 'Enter New Answer',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                MaterialButton(
                  onPressed: () {
                    Map<String, dynamic> nilaiMhs = {
                      'nama': userNameController.text,
                      'nim': userNimController.text,
                      'email': userEmailController.text,
                      'kelas': userClassController.text,
                      'dosen': userDosenController.text,
                      'nilai': double.parse(userGradeController.text),
                      'jawaban': userAnsController.text,
                    };
                    dbRef
                        .child(widget.nilaiMhsKey)
                        .update(nilaiMhs)
                        .then((value) => {Navigator.pop(context)});
                  },
                  child: const Text('Update Data'),
                  color: Color6.lightPrimaryColor,
                  textColor: Colors.white,
                  minWidth: 300,
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
