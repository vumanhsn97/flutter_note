import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import '../model/note.dart';

class NotesProvider with ChangeNotifier { 
  List<NoteModel> notes = [];

  Future<void> loadFromLocal() async{
    LocalStorage storage  = new LocalStorage('flutter_note');
    var ready = await storage.ready;
    if (ready) {
      var _notes = await storage.getItem('notes');
      if (_notes != null && _notes.isNotEmpty) {
        for (var item in _notes) {
          notes.add(NoteModel.fromJson(item));
        }
      }
    }
    notifyListeners();
  }

  void saveToLocal() async {
    LocalStorage storage  = new LocalStorage('flutter_note');
    var ready = await storage.ready;
    if (ready) {
      var _notes = [];
      for (var item in notes) {
        _notes.add(item.toJson());
      }
      storage.setItem('notes', _notes);
    }
  }

  void saveNote(NoteModel note) {
    var exist = notes.firstWhere((element) => element.id == note.id, orElse: () => null);
    if (exist == null) {
      notes = [note, ...notes];
    } else {
      notes.removeWhere((element) => element.id == note.id);
      notes = [note, ...notes];
    }
    saveToLocal();
    notifyListeners();
  }

  void removeNote(NoteModel note) {
    notes.removeWhere((element) => element.id == note.id);
    saveToLocal();
    notifyListeners();
  }
}