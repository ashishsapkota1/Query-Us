import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:query_us/components/drawer.dart';
import 'package:query_us/objects/get_question.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageNo = 0;
  final ScrollController _scrollController = ScrollController();

  List<Question> question = [
    Question(
        questionTitle: '', answerCount: 0, views: 0, voteCount: 0, date: '')
  ];
  void loadQuestions() async {
    final questionToken = await storage.read(key: 'token');
    setState(() {
      isLoading = true;
    });
    final response = await http.get(
        Uri.parse(
            'https://queryus-production.up.railway.app/question/all?pageNo=${pageNo.toString()}'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $questionToken'});
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      List<Question> newQuestions = [];
      for (var q in data) {
        newQuestions.add(Question.fromJson(q));
      }
      setState(() {
        question.addAll(newQuestions);
        pageNo++;
      });
    }
  }

  @override
  void initState() {
    loadQuestions();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
      loadQuestions();
      }
    });
  }

  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: const DrawerComponent(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFF0A1045)),
        centerTitle: true,
        title: const Text(
          'Query-Us',
          style: TextStyle(color: Color(0xFF0A1045)),
        ),
        backgroundColor: const Color(0xFFE5EDF1),
      ),
      body:ListView.builder(
          itemCount: question.length,
          controller: _scrollController,
          itemBuilder: (context, index) {
            return Card(
              elevation: 12,
              margin: const EdgeInsets.all(3),
              shadowColor: Colors.blue[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: height * 0.22,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, left: 80, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Computer Engineering',
                            style: TextStyle(color: Colors.blue[200]),
                          ),
                          SizedBox(
                            width: width * 0.1,
                          ),
                          Text('date')
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: CircleAvatar(
                              backgroundImage: AssetImage('assets/person.png'),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.09,
                          ),
                          Text(
                            question[index].questionTitle,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.visible,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.keyboard_arrow_up,
                              size: 35,
                            ),
                            Text(question[index].voteCount.toString())
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.remove_red_eye_outlined),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(question[index].views.toString())
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.message),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(question[index].answerCount.toString())
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
