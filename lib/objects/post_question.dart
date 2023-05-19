class PostQuestion {
  String title;
  String description;
  String tags;
  PostQuestion({required this.title, this.description = '', this.tags = ''});

  factory PostQuestion.fromJson(Map<String, dynamic> json) {
    return PostQuestion(
        title: json['questionTitle'],
        description: json['questionText'],
        tags: json['tags']);
  }

  Map<String, dynamic> toJson() => {
        'questionTitle': title,
        'questionText': description,
        'tags': tags.split(','),
      };
}
