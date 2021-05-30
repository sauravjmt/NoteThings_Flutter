import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notethings/db/database.dart';
import 'package:notethings/model/notes.dart';

enum NotesAction { FETCH }

class NotesBloc {
  final _stateStreamController = StreamController<List<Notes>>();
  //INPUT
  StreamSink<List<Notes>> get notesSink => _stateStreamController.sink;
  //OUTPUT
  Stream<List<Notes>> get notesStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<NotesAction>();
  //INPUT
  StreamSink<NotesAction> get eventSink => _eventStreamController.sink;
  //OUTPUT
  Stream<NotesAction> get eventStream => _eventStreamController.stream;

  NotesBloc() {
    eventStream.listen((event) async {
      if (event == NotesAction.FETCH) {
        try {
          getNotes();
        } catch (e) {
          notesSink.addError("Something went wrong !!");
        }
      }
    });
  }

  getNotes() async {
    notesSink.add(await DBProvider.db.allNotes());
  }

  searchNotes(String searchTerm) async {
    List<Notes> list = await DBProvider.db.searchNotes(searchTerm);
    notesSink.add(list);
  }

  Future<void> addNotes(Notes notes) async {
    //await DBProvider.db.addNotesInsert(notes);

    await DBProvider.db.addNewNotes(notes);
    await getNotes();
  }

  Future<void> editNotes(Notes notes) async {
    await DBProvider.db.editNotes(notes);
    await getNotes();
  }

  Future<void> deleteNotes(int id) async {
    await DBProvider.db.deleteNotes(id);
    await getNotes();
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
