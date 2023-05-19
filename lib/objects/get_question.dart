class Question {
  String questionTitle;
  String? questionText;
  int answerCount;
  int views;
  int voteCount;
  List<String>? tags;
  var date;
  Question(
      {required this.questionTitle,
      this.questionText,
      this.tags,
      required this.answerCount,
      required this.views,
      required this.voteCount,
      required this.date});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        questionTitle: json['questionTitle'],
        questionText: json['questionText'],
        answerCount: json['answerCount'],
        tags: List<String>.from(json['tags']),
        views: json['views'],
        voteCount: json['voteCount'],
        date: json['timestamp']);
  }

  Map<String, dynamic> toJson() => {
        'questionTitle': questionTitle,
        'questionText': questionText,
        'answerCount': answerCount,
        'views': views,
        'voteCount': voteCount,
        'tags': tags,
        'timestamp': date
      };
}
