import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'runningTracker');
    var database =
        await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    String sql =
        "CREATE TABLE runningTracker (id INTEGER PRIMARY KEY, name TEXT NOT NULL,date TEXT NOT NULL,distance REAL NOT NULL,durationminutes REAL NOT NULL,averagespeed REAL NOT NULL);";
    await database.execute(sql);
  }
}
