import 'dart:io';
import 'package:countries_interview_application/model/noteModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class NoteController {
  final String tableName = "notes";
  final String columnId = "id";
  final String columnTitle = "title";
  final String columnNotes = "content";
  final String columnCountryId = "countryid";

  static final NoteController _instance = NoteController.internal();
  factory NoteController() => _instance;

  static Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  NoteController.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "notes.db");

    var ourDb = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return ourDb;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute("CREATE TABLE IF NOT EXISTS $tableName("
        "$columnId INTEGER PRIMARY KEY, "
        "$columnTitle TEXT, "
        "$columnNotes TEXT, "
        "$columnCountryId TEXT "
        ")");
  }

  //Insertion
  Future<int> saveNote(Note note) async {
    var dbClient = await db;
    int res = await dbClient.insert("$tableName", note.toMap());
    return res;
  }

  // Get Notes with Country ID
  Future<List> getNoteById(dynamic id) async {
    var dbClient = await db;
    var res = await dbClient
        .rawQuery("SELECT * FROM $tableName WHERE $columnCountryId = $id");
    return res.toList();
  }

  //Delete a Note
  Future<int> deleteNote(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableName, where: "$columnId = ?", whereArgs: [id]);
  }

  //Update a Note
  Future<int> updateNote(Note note) async {
    var dbClient = await db;
    return await dbClient.update(tableName, note.toMap(),
        where: "$columnId = ?", whereArgs: [note.id]);
  }

  //Close the connection
  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
