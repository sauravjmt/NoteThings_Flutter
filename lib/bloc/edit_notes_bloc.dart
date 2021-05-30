import 'dart:async';
import 'package:intl/intl.dart';
import 'package:notethings/bloc/notes_bloc.dart';
import 'package:notethings/model/notes.dart';
import 'package:rxdart/rxdart.dart';

class EditNotesBloc {
  final BehaviorSubject<String> _titleStreamController =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _notesDescStreamController =
      BehaviorSubject<String>();

  final BehaviorSubject<int> _colorStreamController = BehaviorSubject<int>();

  Function(int) get colorChange => _colorStreamController.sink.add;

  Stream<int> get colorStream => _colorStreamController.stream;

  //Input for Notes title
  Function(String) get titleChange => _titleStreamController.sink.add;
  //OUTPut for Notes title
  Stream<String> get titleStream => _titleStreamController.stream
          .transform(StreamTransformer.fromHandlers(handleData: (title, sink) {
        if (title.isNotEmpty) {
          sink.add(title);
        } else {
          sink.addError("Empty");
        }
      }));

  //Input for Notes Description

  Function(String) get notesDescChange => _notesDescStreamController.sink.add;

  //Output for Notes Description

  Stream<String> get notesDescStream =>
      _notesDescStreamController.stream.transform(
          StreamTransformer.fromHandlers(handleData: (notesDesc, sink) {
        if (notesDesc.isNotEmpty) {
          sink.add(notesDesc);
        } else {
          sink.addError("Empty field");
        }
      }));

  Stream<bool> get submitStream =>
      Rx.combineLatest2(titleStream, notesDescStream, (a, b) => true);

  Future<void> saveNotes(NotesBloc notesBloc, Notes notes) async {
    var title = _titleStreamController.value;
    var notesDesc = _notesDescStreamController.value;
    var color = _colorStreamController.value;
    var date = DateFormat.yMMMd().format(DateTime.now());
    await notesBloc.editNotes(Notes(notes.id, title, notesDesc, date, color));
  }

  void dispose() {
    _titleStreamController.close();
    _notesDescStreamController.close();
    _colorStreamController.close();
  }
}
