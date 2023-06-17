import 'package:UAS_project/services/auth_service.dart';
import 'package:flutter/material.dart';

class Person {
  final String name;
  final String nim;
  final String imagePath;

  Person({required this.name, required this.nim, required this.imagePath});
}

class home7 extends StatelessWidget {
  final List<Person> persons = [
    Person(
      name: 'Andri Satia Permana',
      nim: '1101202016',
      imagePath: 'lib/images/Andri.png',
    ),
    Person(
      name: 'Feni Nur Septiani',
      nim: '1101190196',
      imagePath: 'lib/images/fotofeni.png',
    ),
    Person(
      name: 'Rima Ananda Kurnia Ismanto',
      nim: '1101193090',
      imagePath: 'lib/images/Rima_Ananda.jpeg',
    ),
    Person(
      name: 'Raiyan Adi Wibowo',
      nim: '1101194298',
      imagePath: 'lib/images/Raiyan_Adi.jpeg',
    ),
    // Tambahkan entri lain jika diperlukan
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Anggota'),
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
      body: ListView.builder(
        itemCount: persons.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(persons[index].imagePath),
            ),
            title: Text(persons[index].name),
            subtitle: Text(persons[index].nim),
          );
        },
      ),
    );
  }
}

