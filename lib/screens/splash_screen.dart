import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:query_us/screens/homepage.dart';
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
    if(token.isEmpty){
      moveToHome();
    }else{
      moveToLogin();
    }
  }

  moveToHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }
  moveToLogin(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyLoginPage()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          'assets/logo3.svg',
          height: 60,
          width: 70,
        ),
      ),
    );
  }
}
