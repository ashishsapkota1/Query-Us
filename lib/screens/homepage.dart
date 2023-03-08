import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:query_us/components/drawer.dart';
import 'package:query_us/objects/get_question.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageNo = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    getQuestion();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  final storage = const FlutterSecureStorage();
  List question =[];

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
        actions: [
          // IconButton(onPressed: (){
          //   showSearch(context: context, delegate: CustomSearchDelegte());
          // }, icon: const Icon(Icons.search),)
        ],
      ),
      body: ListView.builder(
          itemCount: question.length,
          controller: _scrollController,
          itemBuilder: (context, index) {
            final questions = question[index];
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
                          Text(
                              "date"),
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
                          Expanded(
                            child: Text(
                              "title",
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.visible,
                              maxLines: 3,
                            ),
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
                            Text(questions.count.toString())
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.remove_red_eye_outlined),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(questions.viewss.toString())
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.message),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(questions.Count.toString())
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

  Future<void> getQuestion() async {
    final questionToken = await storage.read(key: 'token');
    final response = await http.get(
        Uri.parse(
            'https://queryus-production.up.railway.app/question/all?pageNo=${pageNo.toString()}'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $questionToken'});
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final questions = <Question>[];
      for (final questionJson in json) {
        final question = Question(
          questionTitle: questionJson['questionTitle'] ?? '',
          answerCount: questionJson['answerCount'] ?? 0,
          views: questionJson['views'] ?? 0,
          voteCount: questionJson['voteCount'] ?? 0,
          date: questionJson['date'] ?? '',
        );
        questions.add(question);
      }
      setState(() {
        question = questions;
      });
      setState(() {
        question = json;
      });
    } else {}
  }

  Future<void> _scrollListener() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        pageNo++;
      });
      await getQuestion();
    }
  }
}
