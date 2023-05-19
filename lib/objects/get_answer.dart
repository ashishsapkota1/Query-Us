class Answer {
  String answer;
  int id;
  List<int> date;
  bool upVoted;
  int userId;
  int voteCount;
  Answer(
      {required this.answer,
      required this.id,
      required this.date,
      required this.upVoted,
      required this.userId,
      required this.voteCount});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
        answer: json['answer'],
        id: json['id'],
        date: List<int>.from(json['timestamp']),
        upVoted: json['upVoted'],
        userId: json['userId'],
        voteCount: json['voteCount']);
  }
  Map<String,dynamic> toJson()=>{
    'answer': answer,
    'id': id,
    'timestamp': date,
    'upVoted':upVoted,
    'userId': userId,
    'voteCount': voteCount
  };
}
