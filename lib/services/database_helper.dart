import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../entity/activity.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _db;

  DatabaseHelper._internal();
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'activities.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE activities (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        name TEXT NOT NULL
      )
    ''');
  }

  Future<void> initializeDatabase() async => await database;

  Future<int> insertActivity(Activity a) async {
    final db = await database;
    return await db.insert('activities', a.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Activity>> getAllActivities() async {
    final db = await database;
    final rows = await db.query('activities', orderBy: 'date DESC');
    return rows.map((r) => Activity.fromMap(r)).toList();
  }

  Future<int> updateActivity(Activity a) async {
    final db = await database;
    return await db.update('activities', a.toMap(),
        where: 'id = ?', whereArgs: [a.id]);
  }

  Future<int> deleteActivity(int id) async {
    final db = await database;
    return await db.delete('activities', where: 'id = ?', whereArgs: [id]);
  }
}
