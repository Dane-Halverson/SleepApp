import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:units/AppColors.dart';
import 'package:units/TextPresets.dart';

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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Daily behaviors for ' + _dateTime.month.toString() +'/' + _dateTime.day.toString()+ '\n',
            style: TextPresets.h2Style
            ),
            Text('Stress:',
            style: TextPresets.bodyStyle),
            Slider(
                activeColor: AppColors.secondary,
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
                style: TextStyle(
                  color: AppColors.accentLight,
                  fontSize: 10.0,
                  letterSpacing: 0.6,
                  fontFamily: 'Roboto'
                )),
            Text('Caffeine Intake:',
              style: TextPresets.bodyStyle),
            TextField(
              style: TextStyle(
                  color: AppColors.accentLight
              ),
              decoration: new InputDecoration(
                  labelStyle: TextStyle(color: AppColors.accentLight,
                  fontSize: 13.0),
                  labelText: 'Caffeine in mg',
                  icon: Icon(Icons.coffee,
                  color: AppColors.secondary)
              ),
              keyboardType: TextInputType.number,
              inputFormatters:  <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            Text('\n\nExercise:',
            style: TextPresets.bodyStyle),
        TextFormField(
          style: TextStyle(
            color: AppColors.accentLight
          ),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: AppColors.accentLight,
            fontSize: 13.0),
            labelText: 'Time in Hours/Minutes',
            icon: Icon(Icons.directions_bike_rounded,
            color: AppColors.secondary),
            hintText: '00:00',
            hintStyle: TextStyle(color: AppColors.accent,
            fontSize: 13.0)
          ),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],)
          ]
        )
      )
    );
  }
}