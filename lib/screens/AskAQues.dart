import 'package:flutter/material.dart';
import 'package:query_us/objects/post_question.dart';

class AskAQuestion extends StatefulWidget {
 AskAQuestion({Key? key}) : super(key: key);

  @override
  State<AskAQuestion> createState() => _AskAQuestionState();
  PostQuestion post = PostQuestion(title: '');

}

class _AskAQuestionState extends State<AskAQuestion> {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descController = TextEditingController();
    TextEditingController tagsController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ask question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(8),
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
                    contentPadding: const EdgeInsets.only(top: 10,bottom: 200,left: 10),
                      label:const  Text('Description'),
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
                const SizedBox(height: 20,),
                Container(
                    width: 150,
                    child: ElevatedButton(
                        onPressed: () {postQuestion();},
                        child: const Text(
                          'Post',
                          style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}


postQuestion()async {

}

