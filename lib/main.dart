import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Query-Us',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFE5EDF1),
      ),
     home: SplashScreen(),
    );
  }
}
