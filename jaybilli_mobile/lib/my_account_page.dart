import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jaybilli_mobile/data/provider/my_user_data.dart';
import 'package:jaybilli_mobile/firebase/firestore_provider.dart';
import 'package:jaybilli_mobile/sign_in_page.dart';
import 'package:provider/provider.dart';

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
              firestoreProvider.attemptCreateUser(userKey: snapshot.data.uid, email: snapshot.data.email);
              var myUserData = Provider.of<MyUserData>(context);
              firestoreProvider.connectMyUserData(snapshot.data.uid).listen((user) {
                myUserData.setUserData(user);
              });
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
                                    Consumer<MyUserData>(
                                      builder: (context, myUserData, child){
                                        return Text(
                                          myUserData.data.userEmail,
                                          style: TextStyle(color: Colors.white),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Consumer<MyUserData>(
                                      builder: (context, myUserData, child){
                                        return Text(
                                            myUserData.data.userAvg,
                                            style: TextStyle(color: Colors.white));
                                      },
                                    ),
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
                        onTap: () {
                          // firestoreProvider.sendData().then((_){
                          //   print('데이터 전송 성공!');
                          // });
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('설정'),
                        onTap: () {
                          // firestoreProvider.getData();
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.logout),
                        title: Text('로그아웃'),
                        onTap: () {
                          Provider.of<MyUserData>(context, listen: false).clearUser();
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FlatButton(
                              onPressed: () {
                                print('경기기록');
                              },
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
                              onPressed: () {
                                print('AI 분석실');
                              },
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
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FlatButton(
                              onPressed: () {
                                print('AI 교실');
                              },
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
                              onPressed: () {
                                print('고객센터');
                              },
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
