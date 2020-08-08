import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import 'create_note.dart';

class Home extends StatefulWidget {
  @override
  _StateHome createState() => _StateHome();
}

class _StateHome extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
      body: Container(),
    );
  }
}
