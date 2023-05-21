import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:query_us/objects/get_answer.dart';
import 'package:query_us/objects/post_answer.dart';

class FloatingAction extends StatefulWidget {
  final int questionId;
  const FloatingAction({Key? key, required this.questionId}) : super(key: key);

  @override
  State<FloatingAction> createState() => _FloatingActionState();
}

class _FloatingActionState extends State<FloatingAction> {
  PostAns postAns=PostAns(answer: '');
  final storage = const FlutterSecureStorage();
  List<Answer> answers=[];

  @override
  Widget build(BuildContext context) {
    TextEditingController answerController = TextEditingController();
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet<void>(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
            isScrollControlled: true,
            isDismissible: false,
            enableDrag: true,
            context: context,
            builder: (BuildContext context) {
              return Wrap(
                children: [
                  SizedBox(
                      height: 450,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 18.0, right: 10, left: 10),
                        child: Column(
                          children: [
                            const Text(
                              'Post an answer',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              constraints: const BoxConstraints(maxHeight: 100),
                              child: TextFormField(
                                controller: answerController,
                                textAlignVertical: TextAlignVertical.top,
                                keyboardType: TextInputType.multiline,
                                scrollPhysics:
                                    const AlwaysScrollableScrollPhysics(),
                                maxLines: null,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(
                                        top: 10, left: 10),
                                    label: const Text('Answer'),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    fillColor: Colors.grey[100],
                                    filled: true),
                              ),
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.green, // Background color
                                ),
                                onPressed: () async {
                                  postAns.answer= answerController.text.trim();
                                  Navigator.pop(context);
                                  try {
                                    await postAnswer(widget.questionId);
                                  } catch (e) {
                                    e.toString();
                                  }
                                },
                                child: const Text(
                                  'Post',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                )),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              '*Message: Scroll down to dismiss',
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        ),
                      ))
                ],
              );
            });
      },
      splashColor: Colors.green,
      child: const Icon(Icons.add),
    );
  }

  Future<void> postAnswer(int questionId) async {
    String uri =
        'https://queryus-production.up.railway.app/answer/add/$questionId?answer=${Uri.encodeQueryComponent(postAns.answer)}';
    final questionToken = await storage.read(key: 'token');
    final response = await http.post(Uri.parse(uri),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $questionToken',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode({
          'answer': postAns.answer,
        }));
    print(response.statusCode);
    final display = jsonDecode(response.body);
    print(display);
    if (response.statusCode == 200) {

      print(response.body);
      _showAlertdialog('Status', display['message']);
    } else {
      final errorMessage = jsonDecode(response.body);
      return _showAlertdialog('Status', errorMessage['message']);
    }
  }

  _showAlertdialog(String title, String message) {
    AlertDialog alertDialog =
        AlertDialog(title: Text(title), content: Text(message));
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
