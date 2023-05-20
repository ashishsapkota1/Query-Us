import 'package:query_us/objects/get_answer.dart';

class Question {
  String questionTitle;
  int id;
  List<Answer>? answers;
  String? questionText;
  int answerCount;
  int views;
  int voteCount;
  bool upVoted;
  List<String>? tags;
  var date;
  Question(
      {required this.questionTitle,
      required this.id,
      this.questionText,
      this.answers = const [],
      this.tags,
        required this.upVoted,
      required this.answerCount,
      required this.views,
      required this.voteCount,
      required this.date});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionTitle: json['questionTitle'],
      id: json['id'],
      questionText: json['questionText'],
      answerCount: json['answerCount'],
      tags: List<String>.from(json['tags']),
      answers: json['answers'] != null
          ? List<Answer>.from(
              json['answers'].map((dynamic x) => Answer.fromJson(x)))
          : null,
      views: json['views'],
      upVoted: json['upVoted'],
      voteCount: json['voteCount'],
      date: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() => {
        'questionTitle': questionTitle,
        'questionText': questionText,
        'answerCount': answerCount,
        'views': views,
        'voteCount': voteCount,
        'answers': List<dynamic>.from(answers!.map((x) => x.toJson())),
        'tags': tags,
        'timestamp': date,
        'id': id,
    'upVoted': upVoted
      };
}
