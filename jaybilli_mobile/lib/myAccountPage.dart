import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jaybilli_mobile/signInPage.dart';

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
                          child:Text(snapshot.data.email),
                        decoration: BoxDecoration(
                          color: Colors.blue
                        ),),
                      ListTile(
                        title: Text('로그아웃'),
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                        },
                      )
                    ],
                  ),
                ),
                appBar: AppBar(
                  leading: SizedBox(),
                  title: Center(child: Text('마이 페이지')),
                ),
                body: SafeArea(
                  child: Column(

                  ),
                ),
              );
            }
            return SignInPage();
          }
        });
  }
}
