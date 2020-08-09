import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../provider/notes.dart';
import '../widget/note_item_view.dart';
import 'create_note.dart';

class Home extends StatefulWidget {
  @override
  _StateHome createState() => _StateHome();
}

class _StateHome extends State<Home> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<NotesProvider>(context, listen: true).notes;

    return Scaffold(
      key: _scaffoldKey,
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                height: 100,
                width: 100,
                child: FlutterLogo(),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Divider(),
            ListTile(
              leading: Text('Dark Mode'),
              trailing: Switch(value: false, onChanged: (value) {
                _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Không có sẵn trong version này'),));
              }),
            ),
            Divider(),
            ListTile(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Scaffold(
                appBar: AppBar(),
                body: WebView(
                  initialUrl: 'https://github.com/vumanhsn97/flutter_note',
                  javascriptMode: JavascriptMode.unrestricted,
                ),
              ))),
              leading: Text('Thông tin'),
              trailing: Icon(Icons.keyboard_arrow_right),
            )
          ],
        ),
      ),
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
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => _scaffoldKey.currentState.openDrawer(),
                  child: Container(
                    child: Icon(Icons.blur_on),
                  ),
                ),
                SizedBox(height: 20),
                if (notes.length == 0) Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Không có ghi chú', style: TextStyle(fontSize: 16),),
                        SizedBox(height: 10,),
                        Text(
                          'Chạm phím Thêm để tạo ghi chú',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                ),
                ...List.generate(
                  notes.length,
                  (index) => Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: NoteItemView(notes[index])))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
