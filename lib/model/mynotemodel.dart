class MyNoteModel {
  String? title;
  String? content;
  String? tableName;
  DateTime? createdTime;

  MyNoteModel({
    required this.title,
    required this.content,
    required this.createdTime,
  });

  MyNoteModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    tableName = json['Note'];
    createdTime = json['createdTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['content'] = content;
    data['createdTime'] = createdTime;

    return data;
  }
}
