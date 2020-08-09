import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/notes.dart';
import '../model/note.dart';

class CreateNote extends StatefulWidget {
  final NoteModel note;
  CreateNote({this.note});

  @override
  _StateCreateNote createState() => _StateCreateNote();
}

class _StateCreateNote extends State<CreateNote> {
  TextEditingController title;
  TextEditingController description;
  bool canSave = true;

  @override
  void initState() {
    title = TextEditingController(
        text: widget.note != null ? widget.note.title : '');
    description = TextEditingController(
        text: widget.note != null ? widget.note.description : '');
    if (widget.note != null) {
      canSave = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Icon(Icons.clear)),
                canSave
                    ? FlatButton(
                        onPressed: () {
                          Provider.of<NotesProvider>(context, listen: false)
                              .saveNote(
                                  NoteModel(title.text, description.text));
                          Navigator.pop(context);
                        },
                        child: Text('SAVE'),
                      )
                    : Container()
              ],
            ),
            Divider(),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  TextField(
                    controller: title,
                    decoration: InputDecoration(hintText: 'Fill title'),
                    onChanged: (text) {
                      if (widget.note != null &&
                          widget.note.title == title.text &&
                          widget.note.description == description.text) {
                        setState(() {
                          canSave = false;
                        });
                      } else {
                        setState(() {
                          canSave = true;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Description',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  TextField(
                    controller: description,
                    onChanged: (text) {
                      if (widget.note != null &&
                          widget.note.title == title.text &&
                          widget.note.description == description.text) {
                        setState(() {
                          canSave = false;
                        });
                      } else {
                        setState(() {
                          canSave = true;
                        });
                      }
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Fill your description'),
                    maxLines: 15,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
