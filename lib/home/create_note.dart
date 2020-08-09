import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/notes.dart';
import '../model/note.dart';

class CreateNote extends StatefulWidget {
  @override
  _StateCreateNote createState() => _StateCreateNote();
}

class _StateCreateNote extends State<CreateNote> {
  TextEditingController title;
  TextEditingController description;

  @override
  void initState() {
    title = TextEditingController();
    description = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                FlatButton(
                  onPressed: () {
                    Provider.of<NotesProvider>(context, listen: false)
                          .saveNote(NoteModel(title.text, description.text));
                    Navigator.pop(context);
                  },
                  child: Text('SAVE'),
                )
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
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Description',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  TextField(
                    controller: description,
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
