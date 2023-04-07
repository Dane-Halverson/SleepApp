import 'package:flutter/material.dart';
import 'package:units/SettingsView.dart';
import 'package:units/views/home.dart';

import 'models/models.dart';

class SignedInView extends StatelessWidget {
  UserModel userData;

  SignedInView({
    required this.userData
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignedInStatefulWidget(userData: userData, key: super.key),
    );
  }

}

class SignedInStatefulWidget extends StatefulWidget {
  UserModel userData;
  SignedInStatefulWidget({required Key? key, required this.userData}) : super(key: key);

  @override
  State<SignedInStatefulWidget> createState() => _SignedInStatefulWidgetState(userData: userData);
}

class _SignedInStatefulWidgetState extends State<SignedInStatefulWidget> {
  UserModel userData;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  _SignedInStatefulWidgetState({required this.userData});

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  static const _navColor = Colors.deepPurple;
  static const _selectedColor = Colors.amber;

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[
      //HomePage(),
      HomeView(userData: userData),
      //Log page
      Text(
        'Index 1: Log Activity',
        style: optionStyle,
      ),
      //Videos page
      Text(
        'Index 2: Videos',
        style: optionStyle,
      ),
      //Settings Page
      SettingsView(),
    ];
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
