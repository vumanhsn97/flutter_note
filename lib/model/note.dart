import '../common/tools.dart';

class NoteModel {
  String id;
  String title;
  String description;

  NoteModel(this.title, this.description) {
    this.id = Tools.randomString();
  }

  NoteModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description
    };
  }
}