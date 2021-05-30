import 'package:flutter/material.dart';
import 'package:notethings/bloc/app_state.dart';
import 'package:notethings/bloc/edit_notes_bloc.dart';
import 'package:notethings/bloc/notes_bloc.dart';
import 'package:notethings/model/notes.dart';
import 'package:notethings/widgets/color_picker.dart';

class NotesDetail extends StatefulWidget {
  final Notes notes;

  const NotesDetail({this.notes});

  @override
  _NotesDetailState createState() => _NotesDetailState(notes: notes);
}

class _NotesDetailState extends State<NotesDetail> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final Notes notes;

  EditNotesBloc editNotesBloc;
  NotesBloc notesBloc;

  _NotesDetailState({this.notes});

  @override
  void didChangeDependencies() {
    editNotesBloc = AppStateContainer.of(context).blocProvider.editNotesBloc;
    notesBloc = AppStateContainer.of(context).blocProvider.notesBloc;

    titleChange(notes.title);
    descChange(notes.description);
    colorChange(notes.color);

    super.didChangeDependencies();
  }

  Function(String) get titleChange => editNotesBloc.titleChange;
  Function(String) get descChange => editNotesBloc.notesDescChange;
  Function(int) get colorChange => editNotesBloc.colorChange;

  @override
  void initState() {
    titleController.text = notes.title;
    descController.text = notes.description;

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotesDetailEdit(
        notes: notes,
        editNotesBloc: editNotesBloc,
        titleController: titleController,
        descController: descController,
        notesBloc: notesBloc);
  }
}

class NotesDetailEdit extends StatelessWidget {
  const NotesDetailEdit({
    Key key,
    @required this.notes,
    @required this.editNotesBloc,
    @required this.titleController,
    @required this.descController,
    @required this.notesBloc,
  }) : super(key: key);

  final Notes notes;
  final EditNotesBloc editNotesBloc;
  final TextEditingController titleController;
  final TextEditingController descController;
  final NotesBloc notesBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${notes.title ?? "Edit Notes"}')),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                height: MediaQuery.of(context).size.height / 4,
                child: StreamBuilder<Object>(
                    stream: editNotesBloc.colorStream,
                    builder: (context, snapshot) {
                      return ColorPicker(
                        selectedIndex: snapshot.data,
                        onTap: editNotesBloc.colorChange,
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
                        stream: editNotesBloc.titleStream,
                        builder: (context, snapshot) {
                          return TextField(
                            controller: titleController,
                            onChanged: editNotesBloc.titleChange,
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
                        stream: editNotesBloc.notesDescStream,
                        builder: (context, snapshot) {
                          return TextField(
                            controller: descController,
                            onChanged: editNotesBloc.notesDescChange,
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
                            stream: editNotesBloc.submitStream,
                            builder: (context, snapshot) {
                              return ElevatedButton(
                                onPressed: snapshot.hasData
                                    ? () async {
                                        await editNotesBloc.saveNotes(
                                            notesBloc, notes);
                                        Navigator.pop(context);
                                      }
                                    : null,
                                child: Text("Save Notes"),
                              );
                            })),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
