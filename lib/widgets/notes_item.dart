import 'package:flutter/material.dart';
import 'package:notethings/bloc/notes_bloc.dart';
import 'package:notethings/model/notes.dart';
import 'package:notethings/pages/notes_detail.dart';

import 'constant.dart';

class NotesItem extends StatelessWidget {
  final Notes notes;
  final NotesBloc notesBloc;
  const NotesItem({this.notes, this.notesBloc});

  _showMyDialog(BuildContext buildContext) {
    return showDialog(
      context: buildContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Confirm",
            style: kAlertTitleStyle,
          ),
          content: const Text(
            "Are you sure you wish to delete this item?",
            style: kAlertBodyStyle,
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  "DELETE",
                )),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("CANCEL"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print('data to show===>$notes');
    return Dismissible(
      key: Key(notes.id.toString()),
      confirmDismiss: (direction) async {
        return await _showMyDialog(context);
      },
      onDismissed: (direction) {
        notesBloc.deleteNotes(notes.id);
      },
      background: Container(
        padding: EdgeInsets.all(20.0),
        color: Colors.white,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Remove",
            style: kTextRemoveStyle,
          ),
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NotesDetail(notes: notes)));
        },
        borderRadius: BorderRadius.circular(10.0),
        highlightColor: Color.fromRGBO(0, 255, 0, 1),
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(4.0),
            decoration: BoxDecoration(
                color: noteBGColors[notes.color],
                border:
                    Border.all(width: 1, color: Color.fromRGBO(0, 255, 0, 1)),
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${notes.title} ${notes.id}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${notes.description}'
                    " Notes detail descripton here",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${notes.date}',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
