import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  NoteModel({
    required this.title,
    required this.content,
    required this.createdTime,
    required this.updatedTime,
  });

  String? title;
  String? content;
  Timestamp? createdTime;
  Timestamp? updatedTime;
  DocumentReference? ref;

  NoteModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['description'];
    createdTime = json['created'];
    updatedTime = json['updated'];
    ref = json['ref'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = content;
    data['created'] = createdTime;
    data['updated'] = updatedTime;
    data['ref'] = ref;
    return data;
  }
}
