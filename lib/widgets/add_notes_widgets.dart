import 'package:flutter/material.dart';
import 'package:notethings/bloc/add_notes_bloc.dart';
import 'package:notethings/bloc/notes_bloc.dart';
import 'package:notethings/model/notes.dart';

import 'color_picker.dart';

class AddNotesWidgets extends StatelessWidget {
  const AddNotesWidgets({
    Key key,
    @required this.addNotesBloc,
    @required this.notesBloc,
    @required this.headerTitle,
    @required this.buttonText,
    this.notes,
  }) : super(key: key);

  final AddNotesBloc addNotesBloc;
  final NotesBloc notesBloc;
  final String headerTitle;
  final String buttonText;
  final Notes notes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(headerTitle)),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                height: MediaQuery.of(context).size.height / 4,
                child: StreamBuilder<Object>(
                    stream: addNotesBloc.colorStream,
                    builder: (context, snapshot) {
                      return ColorPicker(
                        selectedIndex: snapshot.data,
                        onTap: addNotesBloc.colorChange,
                      );
                    }),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Column(
                  children: [
                    StreamBuilder<Object>(
                        stream: addNotesBloc.titleStream,
                        builder: (context, snapshot) {
                          return TextField(
                            onChanged: addNotesBloc.titleChange,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: " Notes Title",
                                labelText: "Title"),
                          );
                        }),
                    SizedBox(
                      height: 30,
                    ),
                    StreamBuilder<Object>(
                        stream: addNotesBloc.notesDescStream,
                        builder: (context, snapshot) {
                          return TextField(
                            onChanged: addNotesBloc.notesDescChange,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Notes",
                                hintText: "Notes Descriptions"),
                          );
                        }),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                        child: StreamBuilder<Object>(
                            stream: addNotesBloc.submitStream,
                            builder: (context, snapshot) {
                              return ElevatedButton(
                                onPressed: snapshot.hasData
                                    ? () async {
                                        await addNotesBloc.saveNotes(notesBloc);
                                        Navigator.pop(context);
                                      }
                                    : null,
                                child: Text(buttonText),
                              );
                            })),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
