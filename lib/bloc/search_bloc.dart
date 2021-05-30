import 'dart:async';

import 'package:notethings/db/database.dart';
import 'package:notethings/model/notes.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  final BehaviorSubject<String> _searchSteamController =
      BehaviorSubject<String>();

  //Input for Search

  Function(String) get searchChange => _searchSteamController.sink.add;
  //Output for Search

  Stream<List<Notes>> get searchStream => _searchSteamController.stream
          .debounceTime(Duration(milliseconds: 300))
          .where((value) => value.isNotEmpty)
          .distinct()
          .transform(
              StreamTransformer.fromHandlers(handleData: (data, sink) async {
        final searchResult = await DBProvider.db.searchNotes(data);
        sink.add(searchResult);
      }));

  void dispose() {
    _searchSteamController.close();
  }
}
