import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:provider/provider.dart';

import '../provider/notes.dart';
import '../widget/note_item_view.dart';
import 'create_note.dart';

class Home extends StatefulWidget {
  @override
  _StateHome createState() => _StateHome();
}

class _StateHome extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<NotesProvider>(context, listen: true).notes;

    return Scaffold(
      floatingActionButton: OpenContainer(
        transitionDuration: Duration(milliseconds: 300),
        openBuilder:
            (BuildContext context, void Function({Object returnValue}) action) {
          return CreateNote();
        },
        closedElevation: 6.0,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        closedColor: Theme.of(context).colorScheme.secondary,
        closedBuilder: (BuildContext context, VoidCallback openContainer) {
          return SizedBox(
            height: 60,
            width: 60,
            child: Center(
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          );
        },
      ),
      body: SafeArea(
        child: Column(
          children: List.generate(notes.length, (index) => NoteItemView(notes[index])),
        ),
      ),
    );
  }
}
