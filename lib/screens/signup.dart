import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:query_us/components/component.dart';
import 'package:query_us/screens/screens.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../objects/user_register.dart';

class MySignUpPage extends StatefulWidget {
  const MySignUpPage({Key? key}) : super(key: key);

  @override
  State<MySignUpPage> createState() => _MySignUpPageState();
}

class _MySignUpPageState extends State<MySignUpPage> {
  @override
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  User user = User(
      id: 0,
      firstName: "",
      middleName: "",
      lastName: "",
      email: "",
      password: "",
      confirmPassword: "");

  moveToLogin() async {
    await Future.delayed(const Duration(seconds: 1));
    Navigator.push(
      context,
      PageRouteBuilder(
          transitionDuration: const Duration(seconds: 1),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation,
              Widget child) {
            animation =
                CurvedAnimation(parent: animation, curve: Curves.bounceIn);
            return ScaleTransition(
                alignment: Alignment.topCenter, scale: animation, child: child);
          },
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secAnimation) {
            return MyLoginPage();
          }),
    );
  }

  Future<User> createUser() async {
    final response = await http.post(
        Uri.parse('https://queryus-production.up.railway.app/user/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id': user.id,
          'firstName': user.firstName,
          'lastName': user.lastName,
          'middleName': user.middleName,
          'email': user.email,
          'password': user.password,
          'confirmPassword': user.confirmPassword
        }));

    if (response.statusCode == 200) {
      final display = jsonDecode(response.body);
      _showAlertdialog('Status', display['message']);
      return moveToLogin();
    } else {
      final errorMessage =jsonDecode(response.body);
      return _showAlertdialog('Status', errorMessage['message']);
    }
  }

  _showAlertdialog(String title, String message) {
    AlertDialog alertDialog =
        AlertDialog(title: Text(title), content: Text(message));
    showDialog(context: context, builder: (_) => alertDialog);
  }

  TextEditingController firstNamecontroller = TextEditingController();
  TextEditingController middleNamecontroller = TextEditingController();
  TextEditingController lastNamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();

  @override
  void dispose() {
    firstNamecontroller.dispose();
    middleNamecontroller.dispose();
    lastNamecontroller.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    confirmpasswordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Form(
        key: _formkey,
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A1045),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: 55,
                    child: MyTextField(
                      controller: firstNamecontroller,
                      validator: _validateName,
                      hintText: 'First Name',
                      obsecureText: false,
                      icon: const Icon(null),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 55,
                    child: MyTextField(
                        controller: middleNamecontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return null;
                          } else if (value.length < 3) {
                            return 'Middle name is too short';
                          }
                        },
                        hintText: 'Middle Name',
                        obsecureText: false,
                        icon: const Icon(null)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 55,
                    child: MyTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '*Required Field';
                          } else if (value.length < 3) {
                            return 'last name is too short';
                          }
                          return null;
                        },
                        controller: lastNamecontroller,
                        hintText: 'Last Name',
                        obsecureText: false,
                        icon: const Icon(null)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 55,
                    child: MyTextField(
                        controller: emailcontroller,
                        validator: (value) {
                          const pattern =
                              r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                              r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                              r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                              r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                              r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                              r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                              r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
                          final regex = RegExp(pattern);

                          if (value!.isEmpty) {
                            return '*Required Field';
                          } else if (value.isNotEmpty &&
                              !regex.hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                        },
                        hintText: 'Email',
                        obsecureText: false,
                        icon: const Icon(null)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 55,
                    child: MyTextField(
                        controller: passwordcontroller,
                        validator: _validatePassword,
                        hintText: 'Password',
                        obsecureText: true,
                        icon: const Icon(null)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 55,
                    child: MyTextField(
                        controller: confirmpasswordcontroller,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Empty';
                          } else if (val != passwordcontroller.text) {
                            return 'Not Match';
                          }
                        },
                        hintText: 'Confirm Password',
                        obsecureText: true,
                        icon: const Icon(null)),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 50,
                    width: 160,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFF0890F2)),
                        child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFF223843),
                            ),
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                setState(() {
                                  user.firstName =
                                      firstNamecontroller.text.trim();
                                  user.lastName =
                                      lastNamecontroller.text.trim();
                                  user.middleName =
                                      middleNamecontroller.text.trim();
                                  user.email = emailcontroller.text.trim();
                                  user.password = passwordcontroller.text;
                                  user.confirmPassword =
                                      confirmpasswordcontroller.text;
                                });

                                try {
                                  await createUser();
                                  moveToLogin();
                                } catch (e) {
                                  (e.toString());
                                }
                              }
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.white),
                            ))),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Text.rich(
                    TextSpan(
                      text: 'Already have an account? ',
                      style: const TextStyle(color: Color(0xFFB5B1B1)),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Login',
                            style: const TextStyle(
                                color: Color(0xFF0990F2),
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                moveToLogin();
                              }),
                        // can add more TextSpans here...
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String? _validateName(String? value) {
  {
    if (value == null || value.isEmpty) {
      return '*Required Field';
    } else if (value.length < 3) {
      return 'Name is too short';
    }
  }
  return null;
}

String? _validatePassword(String? value) {
  {
    RegExp regex1 = RegExp(r'^(?=.*?[a-z])');
    RegExp regex4 = RegExp(r'^(?=.*?[A-Z])');
    RegExp regex2 = RegExp(r'^(?=.*?[0-9])');
    RegExp regex3 = RegExp(r'^(?=.*?[!@#&*~])');
    if (value!.isEmpty) {
      return 'Please enter password';
    } else {
      if (value.length < 8) {
        return 'must be more than 7 characters';
      } else {
        if (!regex1.hasMatch(value)) {
          return 'must contain at least one lowercase';
        } else {
          if (!regex4.hasMatch(value)) {
            return 'must contain at least one Uppercase';
          } else {
            if (!regex2.hasMatch(value)) {
              return 'must contain at least one number';
            } else {
              if (!regex3.hasMatch(value)) {
                return 'must contain at least one special character';
              }
            }
          }
        }
      }
    }
  }
  return null;
}
