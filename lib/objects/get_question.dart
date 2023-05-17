class Question {
  String questionTitle;
  int userId;
  int answerCount;
  int views;
  int voteCount;
  var date;
  List<String?>? tags=[];
  String description;
  Question(
      {required this.questionTitle,
        required this.userId,
      required this.answerCount,
      required this.views,
      required this.voteCount,
      required this.date,
         this.tags,
        required this.description
      });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        questionTitle: json['questionTitle'],
        answerCount: json['answerCount'],
        userId: json['userId'],
        views: json['views'],
        voteCount: json['voteCount'],
        date: json['timestamp'], tags: [...json['tags']], description: json['questionText']
    );
  }

  Map<String, dynamic> toJson()=>{
    'questionTitle': questionTitle,
    'answerCount': answerCount,
    'views': views,
    'voteCount': voteCount,
    'timestamp': date,
    'userId' : userId,
    'tags': tags,
    'questionText': description,

  };
}
