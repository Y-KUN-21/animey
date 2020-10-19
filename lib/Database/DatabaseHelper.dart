import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  String _tableWatching = "watching";
  String name = "name";
  String url = "url";
  String pkey = "pkey";
  String imageUrl = "imageUrl";
  String category = "categories";
  String status = "categories";
  String season = "categories";
  static final id = 'id';
  String _tablePlanning = "planning";

  DatabaseHelper.db();
  static final DatabaseHelper instance = DatabaseHelper.db();

  static Database _database;

  Future<Database> get db async {
    if (_database != null) {
      return _database;
    }
    _database = await initDb();
    return _database;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'animey_db');
    Database db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_tableWatching(
      $pkey INTEGER UNIQUE,
      $name TEXT,
      $url TEXT UNIQUE,
      $imageUrl TEXT,
      $season TEXT,
      $status TEXT)
    ''');
  }

  Future<int> insertWatching(Map<String, dynamic> row) async {
    Database db = await instance.db;
    return await db.insert(_tableWatching, row);
  }

  Future<List<Map<String, dynamic>>> queryAllWatching() async {
    Database db = await instance.db;
    var result = await db.query(_tableWatching);
    return result.toList();
  }

  Future<int> delete(int pkey) async {
    Database db = await instance.db;
    try {
      return await db
          .rawDelete("DELETE FROM $_tableWatching WHERE $pkey = $pkey");
    } on Exception {
      return null;
    }
  }

  Future<int> deletePlanning(int pkey) async {
    Database db = await instance.db;
    try {
      return await db
          .rawDelete("DELETE FROM $_tablePlanning WHERE $pkey = $pkey");
    } on Exception {
      return null;
    }
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
