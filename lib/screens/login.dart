import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:query_us/components/component.dart';
import 'package:query_us/screens/home_page.dart';
import 'package:query_us/screens/screens.dart';
import '../objects/user_login.dart';
import 'package:http/http.dart' as http;

class MyLoginPage extends StatefulWidget {
  MyLoginPage({Key? key}) : super(key: key);

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  Login login = Login( password: "", email: "");

  Future<Login> loginUser() async {

     final res = await http.post(
         Uri.parse('https://queryus-production.up.railway.app/user/login'),
         headers: {'Content-Type': 'application/json'},
         body: jsonEncode({'password': login.password, 'username': login.email}));

     if (res.statusCode == 200) {
       final display = jsonDecode(res.body);
       final token = display['message'];
       await storage.write(key: 'token', value: token);
       _showAlertdialog('Status', display['message']);
      return movetoHome();
     } else {
       final error = jsonDecode(res.body);
       return _showAlertdialog('Status', error['message']);

     }
  }


  _showAlertdialog(String title, String message) {
    AlertDialog alertDialog =
    AlertDialog(title: Text(title), content: Text(message));
    showDialog(context: context, builder: (context) => alertDialog);
  }


  movetoHome() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final storage = const FlutterSecureStorage();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A1045),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Icon(
                    Icons.account_circle_outlined,
                    color: Color(0xFF0A1045),
                    size: 100,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  MyTextField(
                    validator: _validateEmail,
                    controller: emailController,
                    hintText: 'Email or Username',
                    obsecureText: false,
                    icon: const Icon(Icons.mail_outline),
                  ),
                  const SizedBox(height: 15),
                  MyTextField(
                    validator: _validatePassword,
                    controller: passwordController,
                    hintText: 'Password',
                    obsecureText: true,
                    icon: const Icon(Icons.lock_outline),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.black))),
                            child: const Padding(
                              padding: EdgeInsets.only(bottom: 1.0),
                              child: Text('Forgot Password?',
                                  style: TextStyle(color: Color(0xFF223843))),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: 50,
                    width: 160,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFF0890F2)),
                        child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFF223843)),
                            onPressed: () async  {
                              if(_formkey.currentState!.validate()){
                                setState(() {
                                  login.password = passwordController.text;
                                  login.email = emailController.text;
                                });

                                try {
                                  await loginUser();
                                  const HomePage();
                                } catch (e) {
                                  (e.toString());
                                }
                              }
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ))),
                  ),
                  const SizedBox(
                    height: 110,
                  ),
                  Text.rich(
                    TextSpan(
                      text: 'Don\'t have an account yet? ',
                      style: const TextStyle(color: Color(0xFFB5B1B1)),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign Up',
                          style: const TextStyle(
                              color: Color(0xFF0990F2),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(seconds: 1),
                                    transitionsBuilder: (BuildContext context,
                                        Animation<double> animation,
                                        Animation<double> secAnimation,
                                        Widget child) {
                                      animation = CurvedAnimation(
                                          parent: animation,
                                          curve: Curves.decelerate);
                                      return ScaleTransition(
                                          alignment: Alignment.center,
                                          scale: animation,
                                          child: child);
                                    },
                                    pageBuilder: (BuildContext context,
                                        Animation<double> animation,
                                        Animation<double> secAnimation) {
                                      return const MySignUpPage();
                                    }),
                              );
                            },
                        ),
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

String? _validateEmail(String? value) {
  if (value==null) {
    return 'Please enter email';
  }
  return null;
}

String? _validatePassword(String? value) {
  if (value==null) {
    return 'Please enter password';
  }
  return null;
}
