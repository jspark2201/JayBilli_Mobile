import 'dart:async';

import 'package:flutter/material.dart';

import 'constant/contants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Size _size;
  int _currentNoticeIndex = 0;
  PageController _noticeController = PageController(initialPage: 0);
  List<Widget> _noticeList = [
    RichText(overflow: TextOverflow.ellipsis,text: TextSpan(style: TextStyle(color: Colors.black),text:'공지사항1 입니다.')),
    RichText(overflow: TextOverflow.ellipsis,text: TextSpan(style: TextStyle(color: Colors.black),text:'공지사항2 입니다.')),
    RichText(overflow: TextOverflow.ellipsis,text: TextSpan(style: TextStyle(color: Colors.black),text:'공지사항3 입니다. 최대 세 개의 공지사항을 보여줍니다.')),
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentNoticeIndex < 2) {
        _currentNoticeIndex++;
      } else {
        _currentNoticeIndex = 0;
      }
      if(_noticeController.hasClients) {
        _noticeController.animateToPage(_currentNoticeIndex,
            duration: Duration(milliseconds: 350), curve: Curves.easeIn);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _noticeController.dispose();
  }

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
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: _notice(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.grey,
                        width: double.infinity,
                        height: _size.height / 3,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('자주가는 클럽'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          color: Colors.grey,
                          width: double.infinity,
                          height: _size.height / 4,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('추천 영상'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          color: Colors.grey,
                          width: double.infinity,
                          height: _size.height / 3,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
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
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red, width: 1.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text('공지사항'),
        ),
        Expanded(
          child: Container(
            height: 30,
            padding: const EdgeInsets.all(6.0),
            child: PageView(
              scrollDirection: Axis.vertical,
              controller: _noticeController,
              children: [
                _noticeList[0],
                _noticeList[1],
                _noticeList[2],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
