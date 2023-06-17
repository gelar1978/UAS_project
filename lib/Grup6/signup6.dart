// ignore_for_file: use_build_context_synchronously, camel_case_types, library_private_types_in_public_api

import 'package:UAS_project/Grup6/color6.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:UAS_project/controller/theme_controller.dart';
import 'package:UAS_project/model/user.dart';
import 'package:UAS_project/services/auth_service.dart';
import 'package:UAS_project/services/firestore_service.dart';
import 'package:get/get.dart';

class SignUp6 extends StatefulWidget {
  const SignUp6({Key? key}) : super(key: key);

  @override
  _SignUp6State createState() => _SignUp6State();
}

class _SignUp6State extends State<SignUp6> {
  // final themeController = Get.find<AppTheme>();
  final themeController = Get.put(AppTheme());

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _noController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final _key = GlobalKey<FormState>();

  final FocusNode _emailFieldFocus = FocusNode();
  final FocusNode _passwordFieldFocus = FocusNode();
  final FocusNode _noFieldFocus = FocusNode();
  final FocusNode _namaFieldFocus = FocusNode();

  Color _emailDarkColor = Color6.darkFormFillColor;
  Color _passwordDarkColor = Color6.darkFormFillColor;
  Color _emailLightColor = Color6.lightFormFillColor;
  Color _passwordLightColor = Color6.lightFormFillColor;

  Color _noDarkColor = Color6.darkFormFillColor;
  Color _namadDarkColor = Color6.darkFormFillColor;
  Color _noLightColor = Color6.lightFormFillColor;
  Color _namaLightColor = Color6.lightFormFillColor;

  bool _obscureText = true;

  final OutlineInputBorder _outlineBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide.none);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _namaController.dispose();
    _noController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _emailFieldFocus.addListener(() {
      if (_emailFieldFocus.hasFocus) {
        setState(() {
          _emailLightColor = Color6.lightFormfillFocusColor;
          _emailDarkColor = Color6.darkFormFillFocusColor;
        });
      } else {
        setState(() {
          _emailLightColor = Color6.lightFormFillColor;
          _emailDarkColor = Color6.darkFormFillColor;
        });
      }
    });
    _passwordFieldFocus.addListener(() {
      if (_passwordFieldFocus.hasFocus) {
        setState(() {
          _passwordLightColor = Color6.lightFormfillFocusColor;
          _passwordDarkColor = Color6.darkFormFillFocusColor;
        });
      } else {
        setState(() {
          _passwordLightColor = Color6.lightFormFillColor;
          _passwordDarkColor = Color6.darkFormFillColor;
        });
      }
    });
    _noFieldFocus.addListener(() {
      if (_noFieldFocus.hasFocus) {
        setState(() {
          _noLightColor = Color6.lightFormfillFocusColor;
          _noDarkColor = Color6.darkFormFillFocusColor;
        });
      } else {
        setState(() {
          _noLightColor = Color6.lightFormFillColor;
          _noDarkColor = Color6.lightFormFillColor;
        });
      }
    });
    _namaFieldFocus.addListener(() {
      if (_namaFieldFocus.hasFocus) {
        setState(() {
          _namaLightColor = Color6.lightFormfillFocusColor;
          _namadDarkColor = Color6.darkFormFillFocusColor;
        });
      } else {
        setState(() {
          _namaLightColor = Color6.lightFormFillColor;
          _namadDarkColor = Color6.darkFormFillColor;
        });
      }
    });
    super.initState();
  }

  Widget _formField(TextEditingController controller, String hint,
      FocusNode focusNode, Color color, bool obscure,
      {String? Function(String?)? validate,
      TextInputType? inputType,
      Widget? suffix}) {
    return Container(
      width: 256,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          focusNode: focusNode,
          obscureText: obscure,
          keyboardType: inputType ?? TextInputType.text,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 14),
              hintText: hint,
              hintStyle: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              filled: true,
              fillColor: color,
              focusedBorder: _outlineBorder,
              enabledBorder: _outlineBorder,
              errorBorder: _outlineBorder,
              focusedErrorBorder: _outlineBorder,
              suffixIcon: suffix),
          validator: validate ??
              (value) {
                if (value!.isEmpty) {
                  return 'This field can\'t be empty';
                }
              }),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
        'BUILD SIGN UP ======================================================');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 19, top: 78, bottom: 34),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color6.lightPrimaryColor),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 11,
                ),
                const Text(
                  'Sign Up',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 23,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 53,
                ),
                Form(
                    key: _key,
                    child: Column(
                      children: [
                        Obx(
                          () => _formField(
                              _namaController,
                              'Username',
                              _namaFieldFocus,
                              themeController.isDarkMode.value
                                  ? _namadDarkColor
                                  : _namaLightColor,
                              false),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Obx(() => _formField(
                            _emailController,
                            'Email',
                            _emailFieldFocus,
                            themeController.isDarkMode.value
                                ? _emailDarkColor
                                : _emailLightColor,
                            false)),
                        const SizedBox(
                          height: 25,
                        ),
                        Obx(() => _formField(
                                _noController,
                                'Phone number',
                                _noFieldFocus,
                                themeController.isDarkMode.value
                                    ? _noDarkColor
                                    : _noLightColor,
                                false, validate: (value) {
                              if (value!.isEmpty) {
                                return 'This field can\'t be empty';
                              } else if (value.length < 11) {
                                return 'Phone number minimum 11 number';
                              } else if (value.length > 12) {
                                return 'Phone number maximum 12 number';
                              }
                            }, inputType: TextInputType.number)),
                        const SizedBox(
                          height: 25,
                        ),
                        Obx(
                          () => _formField(
                            _passwordController,
                            'Password',
                            _passwordFieldFocus,
                            themeController.isDarkMode.value
                                ? _passwordDarkColor
                                : _passwordLightColor,
                            _obscureText,
                            suffix: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: _obscureText
                                  ? Icon(
                                      Icons.visibility_off_outlined,
                                      color: themeController.isDarkMode.value
                                          ? Colors.white
                                          : Color6.lightPrimaryColor,
                                      size: 18,
                                    )
                                  : Icon(
                                      Icons.visibility_outlined,
                                      color: themeController.isDarkMode.value
                                          ? Colors.white
                                          : Color6.lightPrimaryColor,
                                      size: 18,
                                    ),
                            ),
                          ),
                        )
                      ],
                    )),
                const SizedBox(
                  height: 41,
                ),
                GestureDetector(
                  onTap: () async {
                    if (_key.currentState!.validate()) {
                      try {
                        debugPrint('sign up');
                        await AuthService.signUp(
                                _emailController.text, _passwordController.text)
                            .then(
                          (value) => FirestoreService.addUserDataToFirestore(
                            value,
                            userData: UserData(
                              uid: value!.uid,
                              name: _namaController.text,
                              email: _emailController.text,
                              no: _noController.text,
                            ),
                          ),
                        );
                        Navigator.pop(context);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("AlertDialog Title"),
                              content: const Text(
                                  "This is the content of the AlertDialog"),
                              actions: [
                                TextButton(
                                  child: const Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        } else if (e.code == 'invalid-email') {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("AlertDialog Title"),
                              content: const Text(
                                  "This is the content of the AlertDialog"),
                              actions: [
                                TextButton(
                                  child: const Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        } else if (e.code == 'email-already-in-use') {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("AlertDialog Title"),
                              content: const Text(
                                  "This is the content of the AlertDialog"),
                              actions: [
                                TextButton(
                                  child: const Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );

                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("AlertDialog Title"),
                              content: const Text("Email already Exist"),
                              actions: [
                                TextButton(
                                  child: const Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                      debugPrint('sukses');
                    }
                  },
                  child: Container(
                    height: 36,
                    width: 256,
                    decoration: BoxDecoration(
                        color: Color6.lightPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12.withOpacity(0.1),
                              blurRadius: 15,
                              spreadRadius: 1,
                              offset: const Offset(2, 5))
                        ]),
                    child: const Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 111,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
