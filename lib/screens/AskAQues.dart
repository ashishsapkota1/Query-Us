import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:query_us/objects/post_question.dart';
import 'package:query_us/screens/home_page.dart';
import 'package:http/http.dart' as http;

class AskAQuestion extends StatefulWidget {
  AskAQuestion({Key? key}) : super(key: key);

  @override
  State<AskAQuestion> createState() => _AskAQuestionState();


}

class _AskAQuestionState extends State<AskAQuestion> {

  final storage = const FlutterSecureStorage();
  PostQuestion post = PostQuestion(title: '', tags: '', description: '');

  @override
  Widget build(BuildContext context) {



    TextEditingController titleController = TextEditingController();
    TextEditingController descController = TextEditingController();
    TextEditingController tagsController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFF0A1045)),
        centerTitle: true,
        scrolledUnderElevation: 10,
        title: const Text(
          'Ask a Question',
          style: TextStyle(color: Color(0xFF0A1045)),
        ),
        backgroundColor: const Color(0xFFE5EDF1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                TextFormField(
                  maxLines: 4,
                  minLines: 1,
                  controller: titleController,
                  decoration: InputDecoration(
                      label: const Text('Title'),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(16)),
                      fillColor: Colors.grey[100],
                      filled: true),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: 10,
                  minLines: 1,
                  controller: descController,
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.only(top: 10, bottom: 200, left: 10),
                      label: const Text('Description'),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(16)),
                      fillColor: Colors.grey[100],
                      filled: true),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLines: 4,
                  minLines: 1,
                  controller: tagsController,
                  decoration: InputDecoration(
                      label: const Text('Tags'),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(16)),
                      fillColor: Colors.grey[100],
                      filled: true),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    width: 150,
                    child: ElevatedButton(
                        onPressed: () async {
                          post.title = titleController.text.trim();
                          post.description = descController.text.trim();
                          post.tags = tagsController.text.trim();

                          try{
                             await postQuestion();
                             Get.to(()=> const HomePage());
                          }catch(e){
                             e.toString();
                          }
                        },
                        child: const Text(
                          'Post',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> postQuestion()async{
    String uri = 'https://queryus-production.up.railway.app/question/add';
    final questionToken = await storage.read(key: 'token');
    final response = await http.post(Uri.parse(uri),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $questionToken', 'Content-Type': 'application/json'},
        body :jsonEncode({
          'questionTitle': post.title,
          'questionText': post.description,
          'tags': post.tags.split(','),
        }));
    print(response.statusCode);
    if(response.statusCode==200){
      final posted = jsonDecode(response.body);
      print(posted);

    }


  }

}

