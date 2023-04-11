import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter your sleep',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState!.validate()) {
                  // Process data.
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

/*import 'package:path/path.dart';
import 'package:lib/dreams/sleep.dart';
import 'package:sqflite/sqflite.dart';

/*
  Singleton for database access.
 */

class MyDatabase {
  // make this a singleton class
  MyDatabase._privateConstructor();
  static final MyDatabase instance = MyDatabase._privateConstructor();

  // A single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // Opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'sleeps_database.db'),
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          "CREATE TABLE sleeps(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, start INTEGER, end INTEGER)",
        );
      },
      version: 1,
    );
  }

  /*
    Inserts one sleep object.
   */
  Future<void> insertSleep(Sleep sleep) async {
    await _database.insert(
      'sleeps',
      sleep.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /*
    Gets all sleeps.
   */
  Future<List<Sleep>> sleeps() async {
    final List<Map<String, dynamic>> maps = await _database.query('sleeps');

    print("Gettting all sleeps...");
    return List.generate(maps.length, (i) {
      print("Sleep ${maps[i]['id']}: ${maps[i]['start']}");
      return Sleep(
        id: maps[i]['id'],
        start: maps[i]['start'],
        end: maps[i]['end'],
      );
    });
  }

  /*
    Gets all sleeps within a week.
   */
  Future<List<Sleep>> sleepsThisWeek() async {
    int currentTimestamp = DateTime.now().millisecondsSinceEpoch;
    int weekLength = 1000 * 60 * 60 * 24 * 7;
    final List<Map<String, dynamic>> maps = await _database.rawQuery(
      "SELECT * FROM 'sleeps' WHERE $currentTimestamp - start < $weekLength"
    );

    return List.generate(maps.length, (i) {
      return Sleep(
        id: maps[i]['id'],
        start: maps[i]['start'],
        end: maps[i]['end'],
      );
    });
  }
}

//This code is from the github project https://github.com/LihanZhuH/Sleep-Organized/blob/master/lib/models/database.dart
//You can look at it

*/

