import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:units/AppColors.dart';
import 'package:units/models/behaviors.dart';
import 'package:units/models/models.dart';
import 'package:units/presenters/home_presenters.dart';
import 'package:units/views/statistics.dart';
import 'CalculatorView.dart';

class HomeView extends StatelessWidget {
  final UserModel userData;

  HomeView({
    required this.userData
  });
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _HomeStatefulWidget(model: userData, key: super.key),
    );
  }
}

class _HomeStatefulWidget extends StatefulWidget {
  final UserModel model;
  _HomeStatefulWidget({
    required this.model,
    super.key
  });

  @override
  State<_HomeStatefulWidget> createState() => HomeStatefulWidgetState(model);
}

class HomeStatefulWidgetState extends State<_HomeStatefulWidget> {
  late final HomePresenter _presenter;
  final headingStyle = new TextStyle(
    inherit: false,
    color: AppColors.accentLight,
    fontSize: 28.0,
    letterSpacing: 0.6,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w300
  );
  final h2Style = new TextStyle(
      inherit: false,
      color: AppColors.accentLight,
      fontSize: 24.0,
      letterSpacing: 0.6,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w300
  );

  final Padding sectionSep = new Padding(padding: EdgeInsets.only(top: 25.0));

  HomeStatefulWidgetState(UserModel model) {
    this._presenter = new HomePresenter(this, model);
  }

  Future<void> _showSleepLog(DateTime date) async {
    String getTimeSuffix(int hour) => hour < 12 ? 'a.m.' : 'p.m.';
    int getHour(int hour) => hour > 12 ? hour - 12 : hour;
    String formatMins(int mins) {
      final minsString = mins.toString();
      return minsString.length == 1 ? '0$minsString' : minsString;
    }

    final SleepModel? log = await _presenter.getSleepLogForDate(date);
    List<Widget> content;
    if (log == null) {
      content = <Widget>[
        Text('There is no sleep data entered for this date.')
      ];
    }
    else {
      int sleepTime = log.sleepTime;
      int totalTimeInBed = log.totalTimeInBed;
      DateTime bedTimeDate = DateTime.fromMillisecondsSinceEpoch(log.timeFellAsleep);
      DateTime wakeTimeDate = DateTime.fromMillisecondsSinceEpoch(log.riseTime);
      String timeSuffix = bedTimeDate.hour < 12 ? 'a.m.' : 'p.m.';
      String wakeTimeSuffix = getTimeSuffix(wakeTimeDate.hour);
      int hour = getHour(bedTimeDate.hour);
      int wakeHour = getHour(wakeTimeDate.hour);
      String bedMins = formatMins(bedTimeDate.minute);
      String wakeMins = formatMins(wakeTimeDate.minute);
      String bedTime = '$hour:$bedMins $timeSuffix';
      String wakeTime = '$wakeHour:$wakeMins $wakeTimeSuffix';

      content = <Widget>[
        Text('You slept $sleepTime hours.'),
        Text('You fell asleep at $bedTime and spent $totalTimeInBed hours in bed total.'),
        Text('You woke up at $wakeTime'),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            'Dream Diary',
            style: h2Style
          )
        ),
      ];
      final dreamsView = <Widget>[];
      await for (var dreams in log.getDreams()) {
        final Column column = new Column(children: []);
        if (dreams.isNightmare) {
          column.children.add(const Text('Nightmare'));
        }
        String? description = dreams.description;
        if (description != null) column.children.add(Text(description));
        dreamsView.add(
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: column
          )
        );
      }
      if (dreamsView.length > 0) {
        content.add(
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: dreamsView
          )
        );
      }
      else {
        content.add(
          Text('There were no dreams reported for this entry.')
        );
      }
    }
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        String dateStr = date.toString().split(' ')[0];
        return AlertDialog(
          title: Text('Sleep Log For $dateStr'),
          content: SingleChildScrollView(
            child: ListBody(
              children: content
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext ctx) {
    final String? firstname = this._presenter.firstname;
    return new LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return  Scaffold(
        backgroundColor: AppColors.dark,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Home"),
          backgroundColor: Colors.deepPurple,
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Text('Welcome back, $firstname', style: headingStyle),
            sectionSep,
            Calculator(),
            sectionSep,
            FutureBuilder<AllData>(
              future: _presenter.fetchData(),
              builder: (BuildContext ctx, AsyncSnapshot<AllData> snapshot) {
                if (snapshot.hasData) {
                  AllData? data = snapshot.data;
                  if (data != null) {
                    final rec = SleepRecommendation.getSleepRecommendation(
                      userData: this._presenter.model,
                      behaviors: data.behaviors,
                      statistics: data.sleep,
                      wakeUpHour: this._presenter.model.preferences.wakeUpHour
                    );
                    Column column = Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0, left: 10.0),
                          child: Text(
                            'Sleep Recommendations',
                            style: h2Style,
                          ),
                        ),
                        RecommendationsView(rec),
                        sectionSep,
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0, left: 10.0),
                          child: Text(
                            'Sleep Overview',
                            style: h2Style,
                          ),
                        ),
                        StatisticsView(data.sleep),
                        sectionSep,
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0, left: 10.0),
                          child: Text(
                            'Analyze Your Behaviors',
                            style: h2Style,
                          ),
                        ),
                        BehaviorsView(data.behaviors),
                      ],
                    );
                    return column;
                  }
                  else return const Center(child: CircularProgressIndicator());
                }
                else {
                  return const Center(child: CircularProgressIndicator());
                }
              }
            ),
            sectionSep,
            Padding(
              padding: EdgeInsets.only(bottom: 20.0, left: 10.0),
              child: Text(
                'Revisit Your Sleep Logs',
                style: h2Style,
              ),
            ),
            SfDateRangePicker(
              selectionMode: DateRangePickerSelectionMode.single,
              maxDate: DateTime.now(),
              minDate: DateTime.now().subtract(new Duration(days: 30)),
              selectionColor: AppColors.primary,
              showActionButtons: true,
              onSubmit: (Object? value) {
                if (value is DateTime) {
                  _showSleepLog(value);
                }
              },
            )
          ]
        ),
      );
    });
  }
}