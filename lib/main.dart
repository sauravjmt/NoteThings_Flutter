import 'dart:io';
import 'package:flutter/material.dart';
import 'package:notethings/bloc/add_notes_bloc.dart';
import 'package:notethings/bloc/app_state.dart';
import 'package:notethings/bloc/edit_notes_bloc.dart';
import 'package:notethings/bloc/notes_bloc.dart';
import 'package:notethings/db/database.dart';
import 'package:notethings/model/notes.dart';
import 'package:notethings/pages/add_notes.dart';
import 'package:notethings/pages/notes_list.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math' as math;

import 'bloc/search_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var blocProvider = BlocProvider(
      notesBloc: NotesBloc(),
      addNotesBloc: AddNotesBloc(),
      searchBloc: SearchBloc(),
      editNotesBloc: EditNotesBloc());
  //await DBProvider.db.database;
  runApp(AppStateContainer(blocProvider: blocProvider, child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: "Source Sans Pro",
          textTheme: const TextTheme(
              headline6:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              bodyText1:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              bodyText2:
                  const TextStyle(fontSize: 13, fontWeight: FontWeight.w400))),
      home: MyHomePage(
        title: "All Notes",
      ),
    );
  }
}

// Center(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: <Widget>[
// Text(
// 'No Notes !',
// ),
// ],
// ),
// ),
