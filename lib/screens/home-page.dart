// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:query_us/components/drawer.dart';
// import 'package:query_us/objects/get_question.dart';
// import 'package:http/http.dart' as http;
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   int pageNo = 0;
//   int perPage = 10;
//   List currentQuestions = [];
//   final ScrollController _scrollController = ScrollController();
//
//   List<Question> question = [
//     Question(
//         questionTitle: '', answerCount: 0, views: 0, voteCount: 0, date: '')
//   ];
//
//   void loadMoreQuestion(){
//     setState(() {
//       pageNo ++;
//       int startingIndex= pageNo * perPage;
//       int endingIndex = startingIndex + perPage;
//       if(endingIndex > question.length){
//         endingIndex = question.length;
//       }
//       currentQuestions.addAll(question.getRange(startingIndex, endingIndex));
//     });
//   }
//
//   @override
//   void initState() {
//     loadQuestion();
//     _scrollController.addListener(_scrollListener);
//     super.initState();
//   }
//
//   Future<void> loadQuestion() async {
//     try {
//       final questions = await getQuestion();
//       setState(() {
//         question = questions;
//       });
//     } catch (error) {
//       print('Failed to load question: $error');
//     }
//   }
//
//   final storage = const FlutterSecureStorage();
//
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       drawer: const DrawerComponent(),
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Color(0xFF0A1045)),
//         centerTitle: true,
//         title: const Text(
//           'Query-Us',
//           style: TextStyle(color: Color(0xFF0A1045)),
//         ),
//         backgroundColor: const Color(0xFFE5EDF1),
//       ),
//       body: FutureBuilder<List<Question>>(
//           future: getQuestion(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return NotificationListener(
//                 onNotification: (ScrollNotification scrollInfo){
//                   if(scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent){
//                     loadMoreQuestion();
//                   }
//                   return true;
//                 },
//                 child: ListView.builder(
//                     itemCount: question.length,
//                     itemBuilder: (context, index) {
//                       Question questionData = snapshot.data![index];
//                       return Card(
//                         elevation: 12,
//                         margin: const EdgeInsets.all(3),
//                         shadowColor: Colors.blue[100],
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Container(
//                           height: height * 0.22,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     top: 8.0, left: 80, right: 16),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       'Computer Engineering',
//                                       style: TextStyle(color: Colors.blue[200]),
//                                     ),
//                                     SizedBox(
//                                       width: width * 0.1,
//                                     ),
//                                     Text("date"),
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 16.0),
//                                 child: Row(
//                                   children: [
//                                     const Padding(
//                                       padding: EdgeInsets.only(left: 8.0),
//                                       child: CircleAvatar(
//                                         backgroundImage:
//                                         AssetImage('assets/person.png'),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: width * 0.09,
//                                     ),
//                                     Expanded(
//                                       child: Text(
//                                         questionData.questionTitle,
//                                         style: const TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.bold),
//                                         overflow: TextOverflow.visible,
//                                         maxLines: 3,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: height * 0.02,
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       const Icon(
//                                         Icons.keyboard_arrow_up,
//                                         size: 35,
//                                       ),
//                                       Text(questionData.voteCount.toString())
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       const Icon(Icons.remove_red_eye_outlined),
//                                       const SizedBox(
//                                         width: 6,
//                                       ),
//                                       Text(questionData.views.toString())
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       const Icon(Icons.message),
//                                       const SizedBox(
//                                         width: 6,
//                                       ),
//                                       Text(questionData.answerCount.toString())
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }),
//               );
//             } else {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//           }),
//     );
//   }
//
//   Future<List<Question>> getQuestion() async {
//     print(pageNo);
//     final questionToken = await storage.read(key: 'token');
//     final response = await http.get(
//         Uri.parse(
//             'https://queryus-production.up.railway.app/question/all?pageNo=${pageNo.toString()}'),
//         headers: {HttpHeaders.authorizationHeader: 'Bearer $questionToken'});
//     var data = jsonDecode(response.body);
//     if (response.statusCode == 200) {
//       List<Question> questions = [];
//       for (Map<String, dynamic> index in data) {
//         questions.add(Question.fromJson(index));
//       }
//       return question..addAll(questions);
//     } else {
//       return [];
//     }
//   }
//
//   Future<void> _scrollListener() async {
//     if (_scrollController.position.pixels ==
//         _scrollController.position.maxScrollExtent) {
//       print(pageNo);
//       pageNo = pageNo + 1;
//       await getQuestion();
//       print(pageNo);
//     }
//   }
// }
