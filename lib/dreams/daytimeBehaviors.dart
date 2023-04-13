import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(const DayBehavior());

class DayBehavior extends StatefulWidget {
  const DayBehavior({super.key});

  @override
  _DayBehaviorState createState() => _DayBehaviorState();
}

class _DayBehaviorState extends State<DayBehavior>{

  @override
  Widget build(BuildContext context){
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(

        )
      )
    );
  }
}