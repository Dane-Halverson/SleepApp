import 'package:flutter/material.dart';

void main() => runApp(const Behaviorwidget());

class Behaviorwidget extends StatelessWidget {
  const Behaviorwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Behaviorwidget'),
        ),
        body: const Center(
          child: Behaviorwidget(),
        ),
      ),
    );
  }
}

@immutable
class User {
  const User({
    required this.behavior,
    required this.quality,
  });

  final String behavior;
  final String quality;

  @override
  String toString() {
    return '$quality, $behavior';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is User && other.quality == quality && other.behavior == behavior;
  }

  @override
  int get hashCode => Object.hash(behavior, quality);
}

class Behaviorinput extends StatelessWidget {
  const Behaviorinput({super.key});

  static const List<User> _userOptions = <User>[
    User(quality: '1''2''3''4''5', behavior: 'sleep quality'),
    User(quality: '1''2''3''4''5', behavior: 'bob@example.com'),
    User(quality: '1''2''3''4''5', behavior: 'charlie123@gmail.com'),
  ];

  static String _displayStringForOption(User option) => option.quality;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<User>(
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<User>.empty();
        }
        return _userOptions.where((User option) {
          return option
              .toString()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (User selection) {
        debugPrint('You just selected ${_displayStringForOption(selection)}');
      },
    );
  }
}
/*import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
//db variable
var db;
//main function
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //connection and creation
  db = openDatabase(
    join(await getDatabasesPath(),'sleep'),
    onCreate:(db,ver){
      return db.execute('CREATE TABLE Sleep(email TEXT PRIMARY KEY, name TEXT, age INTEGER, rollNo TEXT)',);
    },
    //version is used to execute onCreate and make database upgrades and downgrades.
    version:1,
  );

  //insertion
  var sleepOne = Sleep(email:'userOne@gmail.com',name:'XYZ', age:20, rollNo:'2P-23');
  await insertSleep(sleepOne);
  //read
  print(await getSleep());
  //updation
  var sleepUpdate = Sleep(
    email: userOne.email,
    name: userOne.name,
    age: userOne.age + 7,
    rollNo: userOne.rollNo,
  );
  await updateSleep(sleepUpdate);
  // Print the updated results.
  print(await getSleep());
  //deletion
  deleteSleep("studentOne@gmail.com");
}
/* might not be needed with other code
//Class
class User{
  final String email;
  final String name;
  final int age;
  final String rollNo;
//constructor
  Student({
    required this.email,
    required this.name,
    required this.age,
    required this.rollNo,
  });
  Map<String, dynamic> mapStudent() {
    return {
      'email': email,
      'name': name,
      'age': age,
      'rollNo':rollNo,
    };
  }
}
*/
//Insert
//the 'future' keyword defines a function that works asynchronously
Future<void> insertSleep(Sleep sleep) async{
  //local database variable
  final curDB = await db;
  //insert function
  await curDB.insert(
    //first parameter is Table name
    'Student',
    //second parameter is data to be inserted
    sleep.mapSleep(),
    //replace if two same entries are inserted
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
//Read
Future<List<Sleep>> getSleep() async {
  final curDB = await db;
  //query to get all students into a Map list
  final List<Map<String, dynamic>> sleepMaps = await curDB.query('Sleep behaviors');
  //converting the map list to student list
  return List.generate(sleepMaps.length, (i) {
    //loop to traverse the list and return student object
    return Sleep(
      email: sleepMaps[i]['email'],
      name: sleepMaps[i]['name'],
      age: sleepMaps[i]['age'],
      rollNo: sleepMaps[i]['rollNo'],
    );
  });
}
//Update
Future<void> updateSleep(Sleep sleep) async {
  final curDB = await db;
  //update a specific student
  await curDB.update(
    //table name
    'Sleep',
    //convert student object to a map
    sleep.mapSleep(),
    //ensure that the student has a matching email
    where: 'email = ?',
    //argument of where statement(the email we want to search in our case)
    whereArgs: [user.email],
  );
}
//Delete
Future<void> deleteSleep(String email) async {
  final curDB = await db;
  // Delete operation
  await curDB.delete(
    //table name
    'Sleep',
    //'where statement to identify a specific student'
    where: 'email = ?',
    //arguments to the where statement(email passed as parameter in our case)
    whereArgs: [email],
  );
}
*/
//This code may not be the most simple so it is commented to not loose it.
//code is dervived from the tutorial https://www.educative.io/answers/how-to-use-flutter-to-read-and-write-data-to-sqflite-database

