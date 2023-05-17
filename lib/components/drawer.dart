import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:query_us/screens/login.dart';
import 'package:query_us/screens/AskAQues.dart';

class DrawerComponent extends StatefulWidget {
  const DrawerComponent({Key? key}) : super(key: key);

  @override
  State<DrawerComponent> createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {
  final storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Drawer(
          child: Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Get.to(() => AskAQuestion());
                      },
                      child: const Text('Ask A Question')),
                  const SizedBox(
                    height: 4,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await storage.delete(key: 'token');
                      Get.to(() => MyLoginPage());
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[400]),
                    child: const Text('Logout'),
                  )
                ],
              ))),
    );
  }
}
