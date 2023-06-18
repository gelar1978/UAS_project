import 'package:UAS_project/Grup1/navbarview1.dart';
import 'package:UAS_project/Grup1/reset1.dart';
import 'package:UAS_project/Grup1/signupscreen1.dart';
import 'package:UAS_project/services/auth_service.dart';
import 'package:UAS_project/services/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';

class login1 extends StatelessWidget {
  const login1({Key? key}) : super(key: key);

  static const String _title = 'Login';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 41, 153, 116),
          title: const Text(_title),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                // _showAlertDialog(context);
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
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String _message = '';
  User? user1;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: <Widget>[
            CircleAvatar(
              radius: 60,
              child: Container(
                height: 170,
                width: 170,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("lib/images/logogrup1.jpg"),
                    fit: BoxFit.fitWidth,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(1),
                child: const Text(
                  'Welcome to Group 1',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 25),
                )),
            SizedBox(
              height: 5,
              width: 5,
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(1),
                child: const Text(
                  'Please type your login',
                  style: TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                )),
            SizedBox(
              height: 5,
              width: 5,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(2),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => reset1(),
                    ),
                  );
                  //forgot password screen
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.indigo),
                ),
              ),
            ),
            SizedBox(
              height: 5,
              width: 5,
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                child: ElevatedButton(
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () async {
                    // print("test");
                    if (passwordController.text.isNotEmpty) {
                      // final userLoggedIn =
                      //     await SharedPrefService.getLoggedInUserData();

                      debugPrint(hashPass(passwordController.text));
                      // debugPrint(userLoggedIn.password);
                      try {
                        final FirebaseAuth _auth = FirebaseAuth.instance;
                        UserCredential userCredential =
                            await _auth.signInWithEmailAndPassword(
                                email: nameController.text,
                                password: passwordController.text);

                        User? user1 = userCredential.user;

                        // user1 = await AuthService.signIn(
                        //     nameController.text, passwordController.text);
                        // user1 = hasil;
                        _showSnackbarReview(
                            false, user1!.email.toString() + ' Berhasil Masuk');
                        // debugPrint(user1.toString() + " success123");
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NavBarView1(),
                          ),
                        );
                        setState(() {
                          _message = result ?? '';
                        });
                      } catch (e) {
                        _showSnackbarReview(true, 'Password Salah');

                        debugPrint("gagal karena : " + e.toString());
                      }

                      // if (hashPass(passwordController.text) ==
                      //     userLoggedIn.password) {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => CreateNewPasswordView(
                      //         currentPassword: passwordController.text,
                      //         email: nameController.text,
                      //       ),
                      //     ),
                      //   );
                      // } else {
                      //   _showSnackbarReview(true, 'Password tidak sesuai');
                      // }
                    } else {
                      _showSnackbarReview(
                          true, 'Kolom password tidak boleh kosong');
                    }

                    // AuthService.signIn(
                    //     nameController.text, passwordController.text);
                    // final result = await Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => hal1101194080old(),
                    //   ),
                    // );
                    // setState(() {
                    //   _message = result ?? '';
                    // });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    primary: Colors.indigo[900],
                  ),
                  // onPressed: () {
                  //   print(nameController.text);
                  //   print(passwordController.text);
                  // },
                )),
            Container(
                padding: EdgeInsets.fromLTRB(0, 3, 0, 2),
                alignment: Alignment.center,
                child: Text(
                  'or',
                  style: TextStyle(color: Colors.grey),
                )),
            // SignInButton(
            //   btnText: 'Login',
            //   buttonSize: ButtonSize.small,
            //   onPressed: () {},
            //   buttonType: ButtonType.microsoft,
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: SignInButton(
                buttonSize: ButtonSize.medium,
                onPressed: () async {
                  await AuthService.googleSignIn(context);
                  // Navigator.pop(context);
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NavBarView1(),
                    ),
                  );
                  setState(() {
                    _message = result ?? '';
                  });
                },
                buttonType: ButtonType.google,
              ),
            ),
            Row(
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 17, color: Color.fromARGB(255, 66, 206, 124)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen1(),
                      ),
                    );
                    //signup screen
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }

  void _showSnackbarReview(bool isError, String message) {
    final snackbar = SnackBar(
      content: Text(message),
      backgroundColor:
          !isError ? Colors.green : Color.fromARGB(255, 168, 151, 150),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
