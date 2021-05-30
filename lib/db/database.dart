import 'dart:io';

import 'package:notethings/model/notes.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._(); // This is a private constructor

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "notes_database.db");
    print('db path======>${path}');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Notes ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "description TEXT,"
          "date TEXT,"
          "color INTEGER"
          ")");
    });
  }

  // Insert using rawInsert:

  addNotesRawInsert(Notes notes) async {
    final db = await database;
    var res = await db.rawInsert(
        "INSERT into Notes(id,title,description,date,color)"
        "VALUES(${notes.id},${notes.title},${notes.description},${notes.date},${notes.color})");
    return res;
  }

  //Using insert:

  addNotesInsert(Notes notes) async {
    final db = await database;
    var res = await db.insert("Notes", notes.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  addNewNotes(Notes notes) async {
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as if FROM Notes");
    print(' table====>$table');

    int id = table.first["id"];
    var raw = await db.rawInsert(
        "INSERT into Notes(id,title,description,date,color)"
        "VALUES (?,?,?,?,?)",
        [id, notes.title, notes.description, notes.date, notes.color]);

    print('$raw');

    return raw;
  }

  Future<List<Notes>> allNotes() async {
    final db = await database;
    var res = await db.query("Notes");
    List<Notes> list =
        res.isNotEmpty ? res.map((e) => Notes.fromMap(e)).toList() : [];

    return list;
  }

  deleteNotes(int id) async {
    final db = await database;

    return db.delete("Notes", where: "id = ?", whereArgs: [id]);
  }

  Future<List<Notes>> searchNotes(String searchTerm) async {
    final db = await database;
    var res = await db.rawQuery(
        "SELECT * FROM Notes WHERE title LIKE '%$searchTerm%' OR  description LIKE '%$searchTerm%'");
    List<Notes> list =
        res.isNotEmpty ? res.map((e) => Notes.fromMap(e)).toList() : [];

    return list;
  }

  Future<void> editNotes(Notes notes) async {
    final db = await database;
    return await db
        .update("Notes", notes.toMap(), where: "id = ?", whereArgs: [notes.id]);
  }
}
