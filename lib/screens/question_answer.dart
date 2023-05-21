import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:query_us/objects/get_answer.dart';
import 'package:query_us/objects/get_question.dart';
import 'package:http/http.dart' as http;
import 'package:query_us/screens/floating_button.dart';

class AnswerPage extends StatefulWidget {
  const AnswerPage({Key? key, required this.answerData}) : super(key: key);

  final Question answerData;

  @override
  State<AnswerPage> createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  final storage = const FlutterSecureStorage();
  List<Answer> answers = [];
  List<Question> questions=[];

  @override
  void initState() {
    super.initState();
    loadAnswers();
  }

  Future<void> loadAnswers() async {
    try {
      final newAnswers = await getAnswer(widget.answerData.id);
      if (mounted) {
        setState(() {
          answers = newAnswers;
        });
      }
    } catch (error) {
      throw Exception('Failed to load answer');
    }
  }

  Future<List<Answer>> getAnswer(int questionId) async {
    final answerToken = await storage.read(key: 'token');

    final response = await http.get(
      Uri.parse(
          'https://queryus-production.up.railway.app/question/$questionId'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $answerToken'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> answerList = data['answers'];

      final List<Answer> answers =
          answerList.map((json) => Answer.fromJson(json)).toList();

      return answers;
    } else {
      throw Exception('Failed to fetch answers');
    }
  }

  Future<void> updateVoteCount(int id) async {
    final token = await storage.read(key: 'token');

    final response = await http.post(
      Uri.parse('https://queryus-production.up.railway.app/vote/question/$id'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      setState(() {
        final updatedQuestion = questions.firstWhere((question) => question.id == id);
        updatedQuestion.upVoted
            ? updatedQuestion.voteCount++
            : updatedQuestion.voteCount--;
      });
    } else {
      throw Exception('Failed to update vote count');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFF0A1045)),
        centerTitle: true,
        scrolledUnderElevation: 10,
        title: const Text(
          'Query-Us',
          style: TextStyle(color: Color(0xFF0A1045)),
        ),
        backgroundColor: const Color(0xFFE5EDF1),
      ),
      body: Column(
        children: [
          Card(
            elevation: 12,
            margin: const EdgeInsets.all(3),
            shadowColor: Colors.blue[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
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
                            decoration: BoxDecoration(color: Colors.grey[50]),
                            child: Text(
                              widget.answerData.tags?[0] ?? '',
                              style: TextStyle(color: Colors.blue[300]),
                            ))
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
                      Row(
                        children: [
                          IconButton(
                              onPressed: () async {
                                setState(() {
                                  widget.answerData.upVoted = !widget.answerData.upVoted;
                                });
                                await updateVoteCount(widget.answerData.id);
                              },
                              icon: widget.answerData.upVoted
                                  ? const Icon(
                                      Icons.thumb_up,
                                      color: Colors.green,
                                    )
                                  : const Icon(
                                      Icons.thumb_up_off_alt_outlined)),
                          Text(' :${widget.answerData.voteCount}',
                              style: const TextStyle(fontSize: 18))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: answers.length,
              itemBuilder: (context, index) {
                final answer = answers[index];
                return Card(
                  elevation: 12,
                  margin: const EdgeInsets.all(6),
                  shadowColor: Colors.blue[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    minLeadingWidth: 10,
                    title: Text.rich(
                      TextSpan(
                        text: 'Answer-${index + 1}:- ',
                        style:
                            const TextStyle(fontSize: 22, color: Colors.grey),
                        children: <TextSpan>[
                          TextSpan(
                            text: answer.answer,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    trailing: Column(
                      children: [
                        IconButton(
                            onPressed: () async {
                              setState(() {
                                answer.upVoted = !answer.upVoted;
                              });
                              await _updateAnsVoteCount(answer.id);
                            },
                            icon: answer.upVoted
                                ? const Icon(
                                    Icons.thumb_up,
                                    color: Colors.green,
                                  )
                                : const Icon(Icons.thumb_up_off_alt_outlined)),
                        Expanded(
                            child: Text(
                          '${answer.voteCount}',
                          overflow: TextOverflow.visible,
                          maxLines: 1,
                        ))
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingAction(questionId: widget.answerData.id),
    );
  }

  Future<void> _updateAnsVoteCount(int id) async {
    final answerToken = await storage.read(key: 'token');

    final response = await http.post(
      Uri.parse('https://queryus-production.up.railway.app/vote/answer/$id'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $answerToken'},
    );

    if (response.statusCode == 200) {
      setState(() {
        final updatedAnswer = answers.firstWhere((answer) => answer.id == id);
        updatedAnswer.upVoted
            ? updatedAnswer.voteCount++
            : updatedAnswer.voteCount--;
      });
    } else {
      throw Exception('Failed to update vote count');
    }
  }
}
