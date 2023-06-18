// ignore_for_file: use_build_context_synchronously, camel_case_types

import 'package:UAS_project/Grup6/color6.dart';
import 'package:UAS_project/Grup6/forgot6.dart';
import 'package:UAS_project/Grup6/nav6.dart';
import 'package:UAS_project/Grup6/signup6.dart';
import 'package:UAS_project/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';

class login6 extends StatelessWidget {
  const login6({Key? key}) : super(key: key);

  static const String _title = 'LOGIN PAGE';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(
        primaryColor: Color6.lightPrimaryColor,
        fontFamily: 'Montserrat',
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color6.lightPrimaryColor,
          title: const Text(_title),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                // Get.back();
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool visibility = false;
  TextEditingController emailUser = TextEditingController();
  TextEditingController passUser = TextEditingController();
  User? userLog;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 70),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 50,
                        bottom: 100,
                      ),
                    ),
                    Text(
                      "WELCOME",
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 60),
                    ),
                  ],
                ),
                Center(
                  child: Column(
                    children: [
                      TextField(
                        controller: emailUser,
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.mail,
                            color: Colors.redAccent,
                          ),
                          hintText: "E-Mail",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(5),
                ),
                Center(
                  child: Column(
                    children: [
                      TextField(
                        controller: passUser,
                        obscureText: !visibility,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(
                                () {
                                  visibility = !visibility;
                                },
                              );
                            },
                            icon: Icon(
                              visibility
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color6.lightSecondaryColor,
                            ),
                          ),
                          icon: const Icon(
                            Icons.key,
                            color: Colors.redAccent,
                          ),
                          hintText: "Password",
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
                Center(
                  child: SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color6.lightSecondaryColor),
                      onPressed: () async {
                        try {
                          final FirebaseAuth auth = FirebaseAuth.instance;
                          UserCredential userCred =
                              await auth.signInWithEmailAndPassword(
                                  email: emailUser.text,
                                  password: passUser.text);

                          User? userLog = userCred.user;

                          _showSnackbarReview(
                              false, '${userLog!.email}Login Successful');
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NavBarView(),
                            ),
                          );
                          setState(() {});
                        } catch (e) {
                          _showSnackbarReview(true, "Invalid Password");
                        }
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(3),
                ),
                SignInButton(
                  buttonSize: ButtonSize.medium,
                  buttonType: ButtonType.google,
                  onPressed: () async {
                    await AuthService.googleSignIn(context);
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavBarView(),
                      ),
                    );
                    setState(
                      () {},
                    );
                  },
                ),
                Center(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Forgot6(),
                            ),
                          );
                        },
                        child: const Text(
                          "Forgot Password",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUp6(),
                            ),
                          );
                        },
                        child: const Text(
                          "Create an Account",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }

  void _showSnackbarReview(bool isError, String message) {
    final snackbar = SnackBar(
      content: Text(message),
      backgroundColor: !isError ? Colors.green : Colors.red,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
