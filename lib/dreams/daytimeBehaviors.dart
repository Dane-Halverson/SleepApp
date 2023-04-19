import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

void main() => runApp(const DayBehavior());

class DayBehavior extends StatefulWidget {
  const DayBehavior({super.key});

  @override
  _DayBehaviorState createState() => _DayBehaviorState();
}

class _DayBehaviorState extends State<DayBehavior>{

  double _currentValue = 1;
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context){
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Daily behaviors for ' + _dateTime.month.toString() +'/' + _dateTime.day.toString()+'/' + _dateTime.year.toString()+ '\n',
            style: TextStyle(fontWeight: FontWeight.bold
            ),),
            Text('Stress:'),
            Slider(
                activeColor: Colors.deepPurple,
                secondaryActiveColor: Colors.deepPurpleAccent,
                value: _currentValue,
                min: 1,
                max: 5,
                divisions: 4,
                label: _currentValue.round().toString(),
                onChanged: (value) => setState(() =>
                _currentValue = value)
            ),
            Text('Very low (1) - Very high (5)\n\n\n',
                style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.8)),
            Text('Caffeine Intake:'),
            TextField(
              decoration: new InputDecoration(
                  labelText: 'Caffeine in mg',
                  icon: Icon(Icons.coffee)
              ),
              keyboardType: TextInputType.number,
              inputFormatters:  <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            Text('\n\nExercise:'),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Time in Hours/Minutes',
            icon: Icon(Icons.directions_bike_rounded),
            hintText: '00:00',
          ),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly // This input formatter will do the job
          ],)
          ]
        )
      )
    );
  }
}