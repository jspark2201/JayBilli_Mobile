import 'package:flutter/material.dart';

import 'constant/contants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  centerTitle: true,
                  title: Text('JAY BILLY'),
                  backgroundColor: Color(mainColor),
                  floating: true,
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:8.0),
                        child: _notice(),
                      ),
                      SizedBox(height: 10,),
                      Container(color: Colors.grey, width: double.infinity, height: _size.height/3,),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text('자주가는 클럽'),
                      ),
                      SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:8.0),
                        child: Container(color: Colors.grey, width: double.infinity, height: _size.height/4,),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text('추천 영상'),
                      ),
                      SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:8.0),
                        child: Container(color: Colors.grey, width: double.infinity, height: _size.height/3,),
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _notice() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5.0),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            border: Border.all(color:Colors.red, width: 1.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text('공지사항'),
        ),
        Expanded(
          child: Container(
            height: 20,
            color: Colors.yellow,
            child: Text('공지사항입니다.'),
          ),
        ),
      ],
    );
  }
}


