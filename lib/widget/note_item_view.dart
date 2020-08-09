import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/create_note.dart';
import '../model/note.dart';
import '../provider/notes.dart';

class NoteItemView extends StatelessWidget {
  final NoteModel note;
  NoteItemView(this.note);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNote(note: note))),
      child: Dismissible(
        key: Key(note.id),
        onDismissed: (direction) {
          Provider.of<NotesProvider>(context, listen: false).removeNote(note);
        },
        child: Container(
          height: 80,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 0.5, style: BorderStyle.solid, color: Colors.grey)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Text(
                note.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                overflow: TextOverflow.clip,
                maxLines: 1,
              ),
              SizedBox(height: 5),
              Text(
                note.description,
                style: TextStyle(fontStyle: FontStyle.italic),
                overflow: TextOverflow.clip,
                maxLines: 2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
