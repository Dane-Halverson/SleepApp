import 'package:flutter/material.dart';


//Widget that creates the text input for sleep quality
class TextStore extends StatefulWidget {
  const TextStore({Key? key}) : super(key: key);

  @override
  _TextStoreState createState() => _TextStoreState();
}

class _TextStoreState extends State<TextStore> {

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.end,
             mainAxisAlignment: MainAxisAlignment.center,
              children: [
               TextField(
                controller: _textController,
                 decoration: InputDecoration(
                   hintText: 'Sleep Quality, 1 through 5',
                   border: OutlineInputBorder(),
                   suffixIcon: IconButton(
                   onPressed: () {
                       _textController.clear();
                     },
                     icon: const Icon(Icons.clear),
                ),
              ),
            ),
                MaterialButton(
                onPressed: () {},
                color: Colors.blue,
                child: Text('Post', style: TextStyle(color: Colors.white)),
           ),
        ],
      ),
    ));
  }
}

//Widget that tells time went to bed
class TimeforBed extends StatefulWidget {
  const TimeforBed({Key? key}) : super(key: key);

  @override
  _TimeforBedState createState() => _TimeforBedState();
}

class _TimeforBedState extends State<TimeforBed> {

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
        padding: const EdgeInsets.all(20.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    TextField(
    controller: _textController,
    decoration: InputDecoration(
    hintText: 'What time did you go to bed?',
    border: OutlineInputBorder(),
    suffixIcon: IconButton(
    onPressed: () {
    _textController.clear();
    },
    icon: const Icon(Icons.clear),
    ),
    ),
    ),
    MaterialButton(
    onPressed: () {},
    color: Colors.blue,
    child: Text('Post', style: TextStyle(color: Colors.white)),
    ),
    ],
    ),
    ));
  }
}

//Widget that records when the person fell asleep
class fellAsleep extends StatefulWidget {
  const fellAsleep({Key? key}) : super(key: key);

  @override
  _fellAsleepState createState() => _fellAsleepState();
}

class _fellAsleepState extends State<fellAsleep> {

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
        padding: const EdgeInsets.all(20.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    TextField(
    controller: _textController,
    decoration: InputDecoration(
    hintText: 'What time did you fall to sleep?',
    border: OutlineInputBorder(),
    suffixIcon: IconButton(
    onPressed: () {
    _textController.clear();
    },
    icon: const Icon(Icons.clear),
    ),
    ),
    ),
    MaterialButton(
    onPressed: () {},
    color: Colors.blue,
    child: Text('Post', style: TextStyle(color: Colors.white)),
    ),
    ],
    ),
    ));
  }
}

//Widget that tells time when the user woke up
class Wokeup extends StatefulWidget {
  const Wokeup({Key? key}) : super(key: key);

  @override
  _WokeupState createState() => _WokeupState();
}

class _WokeupState extends State<Wokeup> {

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
        padding: const EdgeInsets.all(20.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    TextField(
    controller: _textController,
    decoration: InputDecoration(
    hintText: 'What time did you wake up?',
    border: OutlineInputBorder(),
    suffixIcon: IconButton(
    onPressed: () {
    _textController.clear();
    },
    icon: const Icon(Icons.clear),
    ),
    ),
    ),
    MaterialButton(
    onPressed: () {},
    color: Colors.blue,
    child: Text('Post', style: TextStyle(color: Colors.white)),
    ),
    ],
    ),
    ));
  }
}

//Widget that creates the datepicker
class Datepicker extends StatefulWidget {
  const Datepicker({Key? key}) : super(key: key);

  @override
  _Datepicker createState() => _Datepicker();
}

class _Datepicker extends State<Datepicker>{

  //Datetime variable
  DateTime _dateTime = DateTime.now();

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((value) {
      setState(() {
      _dateTime = value!;
    });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //display chosen date
            Text(_dateTime.toString(), style: TextStyle(fontSize: 30)),

            MaterialButton(
              onPressed: _showDatePicker,
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('Choose Date',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      )),
              ),
            ),
          ],
        ),
      ));
  }
}

//commented to save if needed
/*
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'FlutterenterSleep';

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
*/
//Code from tutorial on form classes https://api.flutter.dev/flutter/widgets/Form-class.html