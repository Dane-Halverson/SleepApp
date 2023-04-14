import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:units/AppColors.dart';

import 'package:units/SettingsView.dart';
import 'package:units/dreams/callforbevhaviors.dart';
import 'package:units/views/home.dart';
import 'models/models.dart';
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<UserModel> _getUserData() async {
    final db = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;
    final userId = auth.currentUser?.uid;
    if (userId == null) 
      throw new ErrorDescription(
        "The user is not signed in when the home page is rendered!"
      );
    final userDoc = await getUserDocRef(db.collection('users'), userId).get();
    final data = userDoc.data();
    if (data == null) 
      throw new ErrorDescription(
        "The sign up page needs to store the user information in the database and it has apparently not done that!"
      );

    return data;
  }

  static const _navColor = AppColors.darkAccent;
  var _selectedColor = Colors.deepPurpleAccent.shade100;

  @override
  Widget build(BuildContext context) {
    UserModel model;
    List<Widget> _pages = <Widget>[
      FutureBuilder<UserModel>(
        future: _getUserData(),
        builder: (BuildContext ctx, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            if (data != null) return HomeView(userData: data);
            else return const CircularProgressIndicator();
          }
          else {
            return const CircularProgressIndicator();
          }
        }
      ),
      //Log page
      Behaviorwidget(),
      //Videos page
      VideosView(),
      //Settings Page
      SettingsView(),
    ];
    //_page = _homePage;
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: Center (
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
            ),
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
        unselectedItemColor: AppColors.primary,
        onTap: _onItemTapped,
      ),
    );
  }
}
