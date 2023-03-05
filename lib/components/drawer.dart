import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:query_us/screens/login.dart';


class DrawerComponent extends StatefulWidget {
  const DrawerComponent({Key? key}) : super(key: key);

  @override
  State<DrawerComponent> createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {

  final storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: ListView(
        scrollDirection: Axis.vertical,
        children:  [
          ListTile(
            title:const Text('LogOut',
            style: TextStyle(color: Colors.black,fontSize: 16),
            ),
            onTap: ()async{
              await storage.delete(key: 'token');
              Get.to(() =>MyLoginPage());
            },
          )
        ],
      )
    );
  }
}
