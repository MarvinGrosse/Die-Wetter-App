import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:die_wetter_app/models/locations.dart';

final databaseProvider = Provider<DBHandler>((ref) => DBHandler());

class DBHandler {
  late final Database db;

  DBHandler() {
    _start();
  }

  static final DBHandler _instance = DBHandler._internal();

  DBHandler._internal();

  static DBHandler get instance => _instance;
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _init();
    return _database!;
  }

  void _start() async {
    db = await _init();
  }

  Future<Database> _init() async {
    return await openDatabase(join(await getDatabasesPath(), 'WetterApp.db'),
        onCreate: ((db, version) {
      db.execute(
        "CREATE TABLE locations(id TEXT PRIMARY KEY, name TEXT);",
      );
    }), version: 1);
  }

  Future<int> insertLocation(Location location) async {
    // Get a reference to the database.
    final db = await database;

    //insert Location
    return await db.insert(
      'locations',
      location.toMap(),
    );
  }

  Future<List<Location>> getAllLocations() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Locations.
    final List<Map<String, dynamic>> maps = await db.query('locations');

    // Convert the List<Map<String, dynamic> into a List<Location>.
    return List.generate(maps.length, (i) {
      return Location.fromMap(maps[i]);
    });
  }

  Future<int> deleteLocation(String id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Location from the database.
    return await db.delete(
      'locations',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  void resetDB() async {
    final db = await database;
    await db.delete('locations');
  }
}
