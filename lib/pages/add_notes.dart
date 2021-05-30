import 'package:flutter/material.dart';
import 'package:notethings/bloc/add_notes_bloc.dart';
import 'package:notethings/bloc/app_state.dart';
import 'package:notethings/bloc/notes_bloc.dart';
import 'package:notethings/model/notes.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:notethings/widgets/add_notes_widgets.dart';

class AddNotes extends StatefulWidget {
  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  NotesBloc notesBloc;
  AddNotesBloc addNotesBloc;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    notesBloc = AppStateContainer.of(context).blocProvider.notesBloc;
    addNotesBloc = AppStateContainer.of(context).blocProvider.addNotesBloc;
    addNotesBloc.colorChange(0);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AddNotesWidgets(
      addNotesBloc: addNotesBloc,
      notesBloc: notesBloc,
      headerTitle: "Add Notes",
      buttonText: "Add Notes",
    );
  }
}
