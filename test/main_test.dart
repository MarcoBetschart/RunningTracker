import 'package:flutter_test/flutter_test.dart';
import 'package:runningtracker/models/run.dart';
import 'package:runningtracker/services/runService.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // Initialize ffi implementation
  sqfliteFfiInit();
  // Set global factory, do not use isolate here
  databaseFactory = databaseFactoryFfiNoIsolate;

  testWidgets('Test sqflite database', (WidgetTester tester) async {
    var db = await openDatabase(inMemoryDatabasePath, version: 1,
        onCreate: (db, version) async {
      await db
          .execute('CREATE TABLE Test (id INTEGER PRIMARY KEY, value TEXT)');
    });
    // Insert some data
    var runService = new RunService();
    var newRun = new Run();
    newRun.date = '1.1.2022';
    newRun.averagespeed = 3.3;
    newRun.distance = 3.3;
    newRun.durationminutes = 60;
    runService.saveRun(newRun);

    // Check content
    expect(await db.query('Test'), [
      {'id': 1}
    ]);

    await db.close();
  });
}
