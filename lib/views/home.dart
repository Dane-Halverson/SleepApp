import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:units/AppColors.dart';
import 'package:units/models/models.dart';
import 'package:units/presenters/home_presenters.dart';
import 'package:units/views/statistics.dart';

import '../models/statistics.dart';
import 'package:units/presenters/CalculatorPresenter.dart';
import 'CalculatorView.dart';
import '../presenters/CalculatorPresenter.dart';

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

  HomeStatefulWidgetState(UserModel model) {
    this._presenter = new HomePresenter(this, model);
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
            Padding(padding: EdgeInsets.all(5),
            child: Text('Welcome back, $firstname', style: headingStyle),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Calculator(),

            )
            ,
            FutureBuilder<StatisticsModel>(
              future: _presenter.getStatisticsData(),
              builder: (BuildContext ctx, AsyncSnapshot<StatisticsModel> snapshot) {
                if (snapshot.hasData) {
                  StatisticsModel? data = snapshot.data;
                  if (data != null) {
                    return StatisticsView(data);
                  }
                  else return Row (
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: const CircularProgressIndicator(),
                        )
                      ]
                  );
                }
                else {
                  return Row (
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: const CircularProgressIndicator(),
                        )
                      ]
                  );
                }
              }
            ),// FutureBuilder for stats view
          ]
        ),
      );
    });
  }
}