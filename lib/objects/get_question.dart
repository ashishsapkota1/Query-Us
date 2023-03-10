class Question {
  String questionTitle;
  int answerCount;
  int views;
  int voteCount;
  var date;
  Question(
      {required this.questionTitle,
      required this.answerCount,
      required this.views,
      required this.voteCount,
      required this.date});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        questionTitle: json['questionTitle'],
        answerCount: json['answerCount'],
        views: json['views'],
        voteCount: json['voteCount'],
        date: json['timestamp']);
  }

  Map<String, dynamic> toJson()=>{
    'questionTitle': questionTitle,
    'answerCount': answerCount,
    'views': views,
    'voteCount': voteCount,
    'timestamp': date

  };
}
