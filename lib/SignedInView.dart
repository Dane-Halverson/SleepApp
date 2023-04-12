import 'package:flutter/material.dart';
import 'package:units/HomePageView.dart';
import 'package:units/SettingsView.dart';
import 'package:units/VideosView.dart';


class SignedInView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignedInStatefulWidget(key: super.key),
    );
  }

}

class SignedInStatefulWidget extends StatefulWidget {
  SignedInStatefulWidget({required Key? key}) : super(key: key);

  @override
  State<SignedInStatefulWidget> createState() => _SignedInStatefulWidgetState();
}

class _SignedInStatefulWidgetState extends State<SignedInStatefulWidget> {


  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _pages = <Widget>[
    //HomePage(),
    HomePageView(),
    //Log page
    Text(
      'Index 1: Log Activity',
      style: optionStyle,
    ),
    //Videos page
    VideosView(),
    //Settings Page
    SettingsView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  static const _navColor = Colors.deepPurple;
  static const _selectedColor = Colors.amber;

  @override
  Widget build(BuildContext context) {
    //_page = _homePage;
    return Scaffold(
      body: Center (
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: _navColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.addchart),
            label: 'Log Activity',
            backgroundColor: _navColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            label: 'Videos',
            backgroundColor: _navColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: _navColor,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: _selectedColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
