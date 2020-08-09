import 'package:flutter/material.dart';
import '../model/note.dart';

class NoteItemView extends StatelessWidget {
  final NoteModel note;
  NoteItemView(this.note);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Text(note.title),
    );
  }
}