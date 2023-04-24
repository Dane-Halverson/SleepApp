import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:units/AppColors.dart';
import '../contracts/calculator_view_contract.dart';
import '../presenters/CalculatorPresenter.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class CalculatorStatefulWidget extends StatefulWidget {
  CalculatorStatefulWidget({super.key});

  @override
  State<CalculatorStatefulWidget> createState() => _CalculatorState();
}

class _CalculatorState extends State<CalculatorStatefulWidget> implements UNITSView {
  late UNITSPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = new BasicPresenter();
    this.presenter.unitsView = this;
  }

  var _sleepHourController = TextEditingController();
  var _sleepMinuteController = TextEditingController();
  var _hourController = TextEditingController();
  var _minuteController = TextEditingController();
  String _hour = "0.0";
  String _minute = "0.0";
  String _sleepMinute = "0.0";
  String _sleepHour = "0.0";
  var _resultString = '';
  var _timeString = '';
  var _message = '';
  var _value = 0;
  var _valueTime = 0;
  final FocusNode _hourFocus = FocusNode();
  final FocusNode _sleepHourFocus = FocusNode();
  final FocusNode _sleepMinuteFocus = FocusNode();
  final FocusNode _minuteFocus = FocusNode();

  var _formKey = GlobalKey<FormState>();


  void handleRadioValueChanged(int? value) {
    this.presenter.onOptionChanged(value!, sleepHourString: _sleepHour, sleepMinuteString: _sleepMinute );
  }
  void handleRadioValueChangedTime(int? value) {
    this.presenter.onTimeOptionChanged(value!);
  }

  void _calculator() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      this.presenter.onCalculateClicked(_hour, _minute, _sleepMinute, _sleepHour);
    }
  }

  @override
  void updateResultValue(String resultValue){
    setState(() {
      _resultString = resultValue;
    });
  }
  @override
  void updateTimeString(String timeString){
    setState(() {
      _timeString = timeString;
    });
  }
  @override
  void updateMessage(String message){
    setState(() {
      _message = message;
    });
  }
  @override
  void updateSleepMinute({required String sleepMinute}){
    setState(() {
      // ignore: unnecessary_null_comparison
      _sleepMinuteController.text = sleepMinute != null?sleepMinute:'';
    });
  }
  @override
  void updateSleepHour({required String sleepHour}){
    setState(() {
      // ignore: unnecessary_null_comparison
      _sleepHourController.text = sleepHour != null?sleepHour:'';
    });
  }
  @override
  void updateHour({required String hour}) {
    setState(() {
      _hourController.text = hour != null ? hour : '';
    });
  }
  @override
  void updateMinute({required String minute}) {
    setState(() {
      _minuteController.text = minute != null ? minute : '';
    });
  }
  @override
  void updateUnit(int value){
    setState(() {
      _value = value;
    });
  }
  @override
  void updateTimeUnit(int value){
    setState(() {
      _valueTime = value;
    });
  }

  @override
  Widget build(BuildContext context) {

    var _unitView = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio<int>(
          activeColor: AppColors.secondary,
          value: 0, groupValue: _value, onChanged: handleRadioValueChanged,
        ),
        Text(
          'Wake up at',
          style: TextStyle(color: AppColors.accentLight),
        ),
        Radio<int>(
          activeColor: AppColors.secondary,
          value: 1, groupValue: _value, onChanged: handleRadioValueChanged,
        ),
        Text(
          'Go to bed at',
          style: TextStyle(color: AppColors.accentLight),
        ),
      ],
    );

    var _unitViewTime = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio<int>(
          activeColor: AppColors.secondary,
          value: 0, groupValue: _valueTime, onChanged: handleRadioValueChangedTime,
        ),
        Text(
          'AM',
          style: TextStyle(color: AppColors.accentLight),
        ),
        Radio<int>(
          activeColor: AppColors.secondary,
          value: 1, groupValue: _valueTime, onChanged: handleRadioValueChangedTime,
        ),
        Text(
          'PM',
          style: TextStyle(color: AppColors.accentLight),
        ),
      ],
    );

    var _mainPartView = Container(
      color: AppColors.secondary,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(2),
      child: Container(
        padding: EdgeInsets.all(5),
        color: AppColors.dark,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text("I want to:",style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.accentLight), textScaleFactor: 1.5,)
                ,),
              _unitView,
              Row(
                children: <Widget>[
                  Expanded(
                    child: hourFormField(context),
                  ),
                  Expanded(
                    child: minFormField(context),
                  )
                ],
              ),
              _unitViewTime,
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text("I want to sleep for:",style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.accentLight), textScaleFactor: 1.5,)
                ,),
              Row(
                children: <Widget>[
                  Expanded(
                    child: sleepHourFormField(context),
                  ),
                  Expanded(
                    child: sleepMinuteFormField(),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: calculateButton()
                ,),
            ],
          ),
        ),
      ),
    );

    var _resultView = Column(
      children: <Widget>[
        Center(
          child: Text(
            '$_message $_resultString $_timeString',
            style: TextStyle(
                color: Colors.deepPurpleAccent,
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic
            ),
          ),
        ),
      ],
    );

    return Container (
      color: AppColors.dark,
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(5.0)),
            _mainPartView,
            Padding(padding: EdgeInsets.all(5.0)),
            _resultView
          ],
        )

    );
  }

  ElevatedButton calculateButton() {
    return ElevatedButton(
      onPressed: _calculator,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary,
        textStyle: TextStyle()
      ),
      child: Text(
        'Calculate',
        style: TextStyle(fontSize: 16.9, color: AppColors.dark),
      ),
    );
  }

  TextFormField sleepMinuteFormField() {
    return TextFormField(
      style: TextStyle(
          color: AppColors.accentLight
      ),
      cursorColor: AppColors.secondary,
      controller: _sleepMinuteController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      focusNode: _sleepMinuteFocus,
      onFieldSubmitted: (value){
        _sleepMinuteFocus.unfocus();
      },
      validator: (value) {
        if (value!.length == 0 || (double.parse(value) < 0 || double.parse(value) > 59)) {
          return ('Minute between 0 - 59');
        }
      },
      onSaved: (value) {
        _sleepMinute = value!;
      },
      decoration: InputDecoration(
          labelStyle: TextStyle(
              color: AppColors.accentLight
          ),
          hintText: 'e.g.) 40',
          labelText: 'Minute',
          icon: Icon(Icons.assessment, color: AppColors.secondary,),
          fillColor: Colors.white,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.darkAccent),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondary),
        ),
      ),
    );
  }

  TextFormField sleepHourFormField(BuildContext context) {
    return TextFormField(
      style: TextStyle(
          color: AppColors.accentLight
      ),
      cursorColor: AppColors.secondary,
      controller: _sleepHourController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      focusNode: _sleepHourFocus,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _sleepHourFocus, _sleepMinuteFocus);
      },
      validator: (value) {
        if (value!.length == 0 || (double.parse(value) < 1 || double.parse(value) > 12)) {
          return ('Hour between 1 - 12');
        }
      },
      onSaved: (value) {
        _sleepHour = value!;
      },
      decoration: InputDecoration(
        labelStyle: TextStyle(
            color: AppColors.accentLight
        ),
        hintText: "e.g.) 7",
        labelText: "Hour",
        icon: Icon(Icons.assessment, color: AppColors.secondary,),
        fillColor: Colors.white,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.darkAccent),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondary),
        ),
      ),
    );
  }

  TextFormField hourFormField(BuildContext context) {
    return TextFormField(
      style: TextStyle(
          color: AppColors.accentLight
      ),
      cursorColor: AppColors.secondary,
      controller: _hourController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      focusNode: _hourFocus,
      onFieldSubmitted: (term){
        _fieldFocusChange(context, _hourFocus, _minuteFocus);
      },
      validator: (value) {
        if (value!.length == 0 || (double.parse(value) < 1 || double.parse(value) > 12)) {
          return ('Hour between 1 - 12');
        }
      },
      onSaved: (value) {
        _hour = value!;
      },
      decoration: InputDecoration(
        labelStyle: TextStyle(
            color: AppColors.accentLight
        ),
        hintText: 'e.g.) 6',
        labelText: 'Hour',
        icon: Icon(Icons.assessment, color: AppColors.secondary,),
        fillColor: Colors.white,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.darkAccent),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondary),
        ),
      ),
    );
  }

  TextFormField minFormField(BuildContext context) {
    return TextFormField(
      style: TextStyle(
          color: AppColors.accentLight
      ),
      cursorColor: AppColors.secondary,
      controller: _minuteController,

      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      focusNode: _minuteFocus,
      onFieldSubmitted: (term){
        _fieldFocusChange(context, _minuteFocus, _sleepHourFocus);
      },
      validator: (value) {
        if (value!.length == 0 || (double.parse(value) < 0 || double.parse(value) > 59)) {
          return ('Minute between 0 - 59');
        }
      },
      onSaved: (value) {
        _minute = value!;
      },
      decoration: InputDecoration(
        hintText: 'e.g.) 30',
        labelText: 'Minute',
        labelStyle: TextStyle(
            color: AppColors.accentLight
        ),
        icon: Icon(Icons.assessment, color: AppColors.secondary,),
        fillColor: Colors.white,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.darkAccent),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondary),
        ),
      ),
    );
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }


}
