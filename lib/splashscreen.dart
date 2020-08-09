import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

import 'home/home.dart';
import 'provider/notes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _StateSplashScreen createState() => _StateSplashScreen();
}

class _StateSplashScreen extends State<SplashScreen>
    with SingleTickerProviderStateMixin, AfterLayoutMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void afterFirstLayout(BuildContext context) async{
    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Provider.of<NotesProvider>(context, listen: false).loadFromLocal();
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, _, __) => Home(),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween<double>(begin: 0, end: 200.0).animate(controller);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: animation,
          child: FlutterLogo(),
          builder: (context, child) {
            return Container(
              height: animation.value,
              width: animation.value,
              child: child,
            );
          },
        ),
      ),
    );
  }
}
