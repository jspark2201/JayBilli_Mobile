import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jaybilli_mobile/my_account_page.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _pageList.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black54,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(label:'클럽 검색', icon: Icon(Icons.search)),
          BottomNavigationBarItem(label: '홈',icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: '마이 페이지',icon: Icon(Icons.account_circle_outlined)),
        ],
      ),
    );
  }

  List _pageList = [
    Text('클럽 검색'),
    Text('홈'),
    MyAccountPage(),
  ];

}
