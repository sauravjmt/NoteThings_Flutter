import 'dart:math';

import 'package:notethings/widgets/constant.dart';

import 'notes.dart';

class MockNotes {
  static final items = List<String>.generate(10000, (i) => "Item $i");
  static final notesTestItems = List<Notes>.generate(
      10,
      (i) => Notes.addNotes('$i Title', "This is Item Number", "29 APR 2021",
          Random().nextInt(noteBGColors.length)));
}
