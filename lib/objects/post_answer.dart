class PostAns {
  String answer;
  PostAns({required this.answer});
  factory PostAns.fromJson(Map<String, dynamic> json) {
    return PostAns(
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() => {'answer': answer};
}
