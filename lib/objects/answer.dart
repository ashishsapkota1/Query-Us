class Answer{
  List<String> answers;
  int answerId;
  Answer({required this.answers,required this.answerId});


  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
       answers: json[''],
      answerId: json['']
    );
  }

  Map<String, dynamic> toJson()=>{

}