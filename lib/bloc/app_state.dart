import 'package:flutter/material.dart';
import 'package:notethings/bloc/edit_notes_bloc.dart';
import 'package:notethings/bloc/notes_bloc.dart';
import 'package:notethings/bloc/search_bloc.dart';

import 'add_notes_bloc.dart';

class AppStateContainer extends StatefulWidget {
  final Widget child;
  final BlocProvider blocProvider;

  const AppStateContainer({Key key, this.child, this.blocProvider})
      : super(key: key);

  @override
  AppState createState() => AppState();
  static AppState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_AppStoreContainer>()
        .appData;
  }
}

class AppState extends State<AppStateContainer> {
  BlocProvider get blocProvider => widget.blocProvider;
  @override
  Widget build(BuildContext context) {
    return _AppStoreContainer(
        appData: this, child: widget.child, blocProvider: widget.blocProvider);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

class _AppStoreContainer extends InheritedWidget {
  final AppState appData;
  final BlocProvider blocProvider;

  _AppStoreContainer(
      {Key key,
      @required this.appData,
      @required child,
      @required this.blocProvider})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(_AppStoreContainer oldWidget) {
    // TODO: implement updateShouldNotify
    return oldWidget.appData != this.appData;
  }
}

class BlocProvider {
  NotesBloc notesBloc;
  AddNotesBloc addNotesBloc;
  SearchBloc searchBloc;
  EditNotesBloc editNotesBloc;

  BlocProvider(
      {@required this.notesBloc,
      @required this.addNotesBloc,
      @required this.searchBloc,
      @required this.editNotesBloc});
}
