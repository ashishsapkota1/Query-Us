import 'package:flutter/material.dart';
import 'package:query_us/objects/get_question.dart';

class AnswerPage extends StatefulWidget {
  const AnswerPage({Key? key, required this.answerData}) : super(key: key);

  final Question answerData;

  @override
  State<AnswerPage> createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFF0A1045)),
        centerTitle: true,
        title: const Text(
          'Query-Us',
          style: TextStyle(color: Color(0xFF0A1045)),
        ),
        backgroundColor: const Color(0xFFE5EDF1),
      ),
      body: Card(
        elevation: 12,
        margin: const EdgeInsets.all(3),
        shadowColor: Colors.blue[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text.rich(
                TextSpan(
                  text: 'Title: ',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.grey),
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.answerData.questionTitle,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    widget.answerData.questionText ?? '',
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[50]
                    ),

                      child: Text(widget.answerData.tags?[0] ?? '',style: TextStyle(color: Colors.blue[300]),))
                ],
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'views: ${widget.answerData.views}',
                  style: const TextStyle(fontSize: 18),
                ),
                Text('Answers: ${widget.answerData.answerCount}',
                    style: const TextStyle(fontSize: 18)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                    icon: isLiked
                        ? const Icon(
                            Icons.thumb_up,
                            color: Colors.green,
                          )
                        : const Icon(Icons.thumb_up_off_alt_outlined))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
