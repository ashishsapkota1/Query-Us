class PostQuestion {
  String title;
  String description;
  String tags;
  PostQuestion({required this.title, this.description = '', this.tags = ''});

  factory PostQuestion.fromJson(Map<String, dynamic> json) {
    return PostQuestion(
        title: json['title'],
        description: json['description'],
        tags: json['tags']);
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'tags': tags,
      };
}
