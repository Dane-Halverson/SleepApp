import 'package:flutter/material.dart';

class LoggedInView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoggedInStatefulWidget(key: super.key),
    );
  }

}

class LoggedInStatefulWidget extends StatefulWidget {
  LoggedInStatefulWidget({required Key? key}) : super(key: key);

  @override
  State<LoggedInStatefulWidget> createState() => _LoggedInStatefulWidgetState();
}

class _LoggedInStatefulWidgetState extends State<LoggedInStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
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
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
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
        child: _widgetOptions.elementAt(_selectedIndex),
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
         child: Text("HomePage widget"),
      ),
    );
  }

}