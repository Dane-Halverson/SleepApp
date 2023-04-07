import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:units/models/models.dart';
import 'package:units/presenters/home_presenters.dart';
import 'package:units/views/statistics.dart';

import '../models/statistics.dart';

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
  UserModel model;
  _HomeStatefulWidget({
    required this.model,
    super.key
  });

  @override
  State<_HomeStatefulWidget> createState() => HomeStatefulWidgetState(model);
}

class HomeStatefulWidgetState extends State<_HomeStatefulWidget> {
  late final HomePresenter _presenter;
  
  HomeStatefulWidgetState(UserModel model) {
    this._presenter = new HomePresenter(this, model);
  }
  @override
  Widget build(BuildContext ctx) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            FutureBuilder<StatisticsModel>(
              future: _presenter.getStatisticsData(),
              builder: (BuildContext ctx, AsyncSnapshot<StatisticsModel> snapshot) {
                if (snapshot.hasData) {
                  StatisticsModel? data = snapshot.data;
                  if (data != null) return StatisticsView(data);
                  else return const CircularProgressIndicator();
                }
                else {
                  return const CircularProgressIndicator();
                }
              }
            ),
            Row(
              children: <Widget>[
              ],
            )
          ]
        ),
      )
    );
  }
}