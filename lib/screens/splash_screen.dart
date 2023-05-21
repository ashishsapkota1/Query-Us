import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:query_us/screens/home_page.dart';
import 'package:query_us/screens/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final storage = const FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      _checkToken();
    });
  }

  _checkToken() async {
    final token = storage.read(key: 'token').toString();
    if (token.isEmpty) {
      moveToLogin();
    } else {
      moveToHome();
    }
  }

  moveToHome() {
    Get.to(()=> const HomePage());
  }

  moveToLogin() {
    Get.to(() => MyLoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/newLogo.png',
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
