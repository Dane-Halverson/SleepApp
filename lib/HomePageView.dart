import 'package:flutter/material.dart';
import 'package:units/calculator/presenter/dreams_presenter.dart';
import 'calculator/views/dreams_component.dart';

class HomePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePageStatefulWidget(key: super.key),
    );
  }
}

class HomePageStatefulWidget extends StatefulWidget {
  HomePageStatefulWidget({super.key});

  @override
  State<HomePageStatefulWidget> createState() => _HomePageStatefulWidgetState();
}

class _HomePageStatefulWidgetState extends State<HomePageStatefulWidget> {
  final calcPresenter = new BasicPresenter();

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text("Home"),
            backgroundColor: Colors.deepPurple,
          ),

              body: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  //Calculator(calcPresenter),
                  Calculator(calcPresenter),
                  Text("Test"),

                ],
              ),

          //You can add another children
        );
    });
  }
}
