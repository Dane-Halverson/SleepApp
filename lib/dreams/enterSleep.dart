import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:numberpicker/numberpicker.dart';

//Widget that creates the text input for sleep quality
class TextStore extends StatefulWidget {
  const TextStore({Key? key}) : super(key: key);

  @override
  _TextStoreState createState() => _TextStoreState();
}

class _TextStoreState extends State<TextStore> {

  double _currentValue = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
          child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Rate Your Quality of Sleep'),
                Slider(
                  activeColor: Colors.deepPurple,
                  secondaryActiveColor: Colors.deepPurpleAccent,
                  value: _currentValue,
                  min: 1,
                  max: 5,
                  divisions: 5,
                  label: _currentValue.round().toString(),
                  onChanged: (value) => setState(() =>
                    _currentValue = value)
                )
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
    return Container(
        child: Padding(
        padding: const EdgeInsets.all(20.0),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('What Time Did You Go To Bed?'),
      TimePickerSpinner(
        spacing: 20,
        is24HourMode: false,
        minutesInterval: 15,
        onTimeChange: (time) {
          setState(() {

          });
        },
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
    return Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('What Time Did You Fall Asleep?', textAlign: TextAlign.center),
              TimePickerSpinner(
                spacing: 20,
                is24HourMode: false,
                minutesInterval: 15,
                onTimeChange: (time) {
                  setState(() {

                  });
                },
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

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
        padding: const EdgeInsets.all(20.0),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('What Time Did You Wake Up?', textAlign: TextAlign.center),
      TimePickerSpinner(
        spacing: 20,
        is24HourMode: false,
        minutesInterval: 15,
        onTimeChange: (time) {
          setState(() {

          });
        },
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
    return Container(
      child: Center(
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