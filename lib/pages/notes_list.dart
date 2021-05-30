import 'package:flutter/material.dart';
import 'package:notethings/bloc/app_state.dart';
import 'package:notethings/bloc/notes_bloc.dart';
import 'package:notethings/bloc/search_bloc.dart';
import 'package:notethings/model/mock_notes_data.dart';
import 'package:notethings/model/notes.dart';
import 'package:notethings/widgets/notes_item.dart';
import 'dart:math' as math;

import 'add_notes.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NotesBloc notesBloc;
  SearchBloc searchBloc;

  @override
  void didChangeDependencies() {
    notesBloc = AppStateContainer.of(context).blocProvider.notesBloc;
    searchBloc = AppStateContainer.of(context).blocProvider.searchBloc;
    notesBloc.eventSink.add(NotesAction.FETCH);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    notesBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              icon: Icon(Icons.search_rounded),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: NotesSearch(
                        searchBloc: searchBloc, notesBloc: notesBloc));
              })
        ],
      ),
      body: StreamBuilder<List<Notes>>(
          stream: notesBloc.notesStream,
          builder: (BuildContext context, AsyncSnapshot<List<Notes>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    final Notes notes = snapshot.data[index];

                    return NotesItem(notes: notes, notesBloc: notesBloc);
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Notes data = MockNotes.notesTestItems[
          //  math.Random().nextInt(MockNotes.notesTestItems.length)];
          // notesBloc.addNotes(data);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddNotes()));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class NotesSearch extends SearchDelegate<Notes> {
  SearchBloc searchBloc;
  NotesBloc notesBloc;

  NotesSearch({@required this.searchBloc, @required this.notesBloc});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults

    searchBloc.searchChange(query);
    return StreamBuilder<List<Notes>>(
        stream: searchBloc.searchStream,
        builder: (BuildContext context, AsyncSnapshot<List<Notes>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  final Notes notes = snapshot.data[index];

                  return NotesItem(notes: notes, notesBloc: notesBloc);
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) => Container();
  // {
  //   final mainNotesData = MockNotes.notesTestItems;
  //   final resultNotes = query.isEmpty
  //       ? mainNotesData
  //       : mainNotesData
  //           .where((element) => element.title.startsWith(query))
  //           .toList();
  //   return ListView.builder(
  //       itemCount: resultNotes.length,
  //       itemBuilder: (context, index) {
  //         return ListTile(
  //           title: Text(resultNotes[index].title),
  //           onTap: () {
  //             showResults(context);
  //           },
  //         );
  //       });
  // }
}
