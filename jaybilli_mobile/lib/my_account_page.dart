import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jaybilli_mobile/sign_in_page.dart';
import 'package:jaybilli_mobile/sign_in_page.dart';

class MyAccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<MyAccountPage> {
  bool isItFirstData = true;

  @override
  void initState() {
    super.initState();
    isItFirstData = true;
  }

  @override
  Widget build(BuildContext context) {
    double _iconSize = 42.0;

    return StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          if (isItFirstData) {
            isItFirstData = false;
            return Container();
          } else {
            if (snapshot.hasData) {
              return Scaffold(
                endDrawer: Drawer(
                  child: ListView(
                    children: [
                      DrawerHeader(
                        decoration: BoxDecoration(color: Colors.lightBlue),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '내 정보',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 30.0,
                                      backgroundImage:
                                          AssetImage('images/account.png'),
                                    ),
                                    Visibility(
                                      visible: true,
                                      child: Positioned(
                                          right: 0.0,
                                          bottom: 0.0,
                                          child: Image.asset(
                                        'images/add_2.png',
                                        width: 20.0,
                                        height: 20.0,
                                      )),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      //snapshot.data.email,
                                      '박준성',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('avg:0.333',
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text('개인정보 수정'),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('설정'),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Icon(Icons.logout),
                        title: Text('로그아웃'),
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                        },
                      )
                    ],
                  ),
                ),
                appBar: AppBar(
                  backgroundColor: Color(0xff0287FA),
                  leading: SizedBox(),
                  title: Center(child: Text('마이 페이지')),
                ),
                body: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FlatButton(
                              onPressed: () {},
                              child: Column(
                                children: [
                                  Image.asset(
                                    'images/chart.png',
                                    width: _iconSize,
                                    height: _iconSize,
                                  ),
                                  Text('경기 기록'),
                                ],
                              )),
                          FlatButton(
                              onPressed: () {},
                              child: Column(
                                children: [
                                  Image.asset(
                                    'images/club.png',
                                    width: _iconSize,
                                    height: _iconSize,
                                  ),
                                  Text('동호회'),
                                ],
                              )),
                          FlatButton(
                              onPressed: () {},
                              child: Column(
                                children: [
                                  Image.asset(
                                    'images/friends.png',
                                    width: _iconSize,
                                    height: _iconSize,
                                  ),
                                  Text('내 친구'),
                                ],
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FlatButton(
                              onPressed: () {},
                              child: Column(
                                children: [
                                  Image.asset(
                                    'images/ai_1.png',
                                    width: _iconSize,
                                    height: _iconSize,
                                  ),
                                  Text('AI 분석실'),
                                ],
                              )),
                          FlatButton(
                              onPressed: () {},
                              child: Column(
                                children: [
                                  Image.asset(
                                    'images/ai_2.png',
                                    width: _iconSize,
                                    height: _iconSize,
                                  ),
                                  Text('AI 교실'),
                                ],
                              )),
                          FlatButton(
                              onPressed: () {},
                              child: Column(
                                children: [
                                  Image.asset(
                                    'images/billiards.png',
                                    width: _iconSize,
                                    height: _iconSize,
                                  ),
                                  Text('내 클럽'),
                                ],
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FlatButton(
                              onPressed: () {},
                              child: Column(
                                children: [
                                  Image.asset(
                                    'images/trophy.png',
                                    width: _iconSize,
                                    height: _iconSize,
                                  ),
                                  Text('랭킹'),
                                ],
                              )),
                          FlatButton(
                              onPressed: () {},
                              child: Column(
                                children: [
                                  Image.asset(
                                    'images/cart.png',
                                    width: _iconSize,
                                    height: _iconSize,
                                  ),
                                  Text('제이 마켓'),
                                ],
                              )),
                          FlatButton(
                              onPressed: () {},
                              child: Column(
                                children: [
                                  Image.asset(
                                    'images/service.png',
                                    width: _iconSize,
                                    height: _iconSize,
                                  ),
                                  Text('고객센터'),
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
            return SignInPage();
          }
        });
  }
}
