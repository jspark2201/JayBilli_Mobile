import 'dart:async';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:jaybilli_mobile/my_favorite_club.dart';
import 'package:url_launcher/url_launcher.dart';
import 'constant/contants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Size _size;
  int _currentNoticeIndex = 0;
  PageController _noticeController = PageController(initialPage: 0);
  bool isRegisteredClub = true;

  List<Widget> _noticeList = [
    RichText(
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
            style: TextStyle(color: Colors.black), text: '공지사항1 입니다.')),
    RichText(
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
            style: TextStyle(color: Colors.black), text: '공지사항2 입니다.')),
    RichText(
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
            style: TextStyle(color: Colors.black),
            text: '공지사항3 입니다. 최대 세 개의 공지사항을 보여줍니다.')),
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
      if (_noticeController.hasClients) {
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
    const String _url = 'https://www.youtube.com/watch?v=bbqqmQsQOxU';

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
                      _advertisement(),
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
                        child: _favoriteClub(),
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
                        child: _recommendedVideo(_url),
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

  Widget _advertisement() {
    return Container(
      color: Colors.grey,
      width: double.infinity,
      height: _size.height / 3,
      child: Carousel(
        dotSize: 4.0,
        dotSpacing: 15.0,
        indicatorBgPadding: 5.0,
        dotBgColor: Colors.transparent,
        dotVerticalPadding: 5.0,
        dotPosition: DotPosition.bottomRight,
        animationDuration: Duration(milliseconds: 500),
        autoplayDuration: Duration(seconds: 5),
        images: [
          InkWell(
              onTap: () {
                print('1 Item Click');
              },
              child: Image.asset(
                'images/advertisement1.jpg',
                fit: BoxFit.cover,
              )),
          InkWell(
              onTap: () {
                print('2 Item Click');
              },
              child: Image.asset(
                'images/advertisement2.jpg',
                fit: BoxFit.cover,
              )),
          InkWell(
              onTap: () {
                print('3 Item Click');
              },
              child: Image.asset(
                'images/advertisement3.jpg',
                fit: BoxFit.cover,
              )),
        ],
      ),
    );
  }

  Widget _favoriteClub() {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyFavoriteClub()));
      },
      child: Container(
        width: double.infinity,
        height: _size.height / 7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
            boxShadow: [
              //to make elevation
              BoxShadow(
                color: Colors.black45,
                offset: Offset(2,2),
                blurRadius: 4
              )
            ]
        ),
        child: isRegisteredClub
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('제이빌리', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                  Text('(10:00 ~ 22:00)',style: TextStyle(color: Colors.grey),),
                  SizedBox(height: 10,),
                  Text('이용 가능 테이블', style: TextStyle(fontWeight: FontWeight.bold),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('대대: 3'),
                      SizedBox(
                        width: 10,
                      ),
                      Text('중대: 2'),
                      SizedBox(
                        width: 10,
                      ),
                      Text('포켓볼: 0'),
                    ],
                  )
                ],
              )
            : IconButton(
                icon: Icon(Icons.add),
                iconSize: 30,
                onPressed: () {
                  print('자주가는 클럽 눌림');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyFavoriteClub()));
                },
              ),
      ),
    );
  }

  Widget _recommendedVideo(String url) {
    return GestureDetector(
      onTap: () {
        launchInBrowser(url);
      },
      child: Container(
        color: Colors.grey[300],
        width: double.infinity,
        padding: EdgeInsets.all(10.0),
        height: _size.height / 3,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.network('https://img.youtube.com/vi/bbqqmQsQOxU/0.jpg'),
            //'https://img.youtube.com/vi/youtube video id/0.jpg'
            Container(
              width: 70,
              height: 70,
              child: Icon(
                Icons.play_arrow,
                size: 70,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  void launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      showErrorDialog('브라우저에서 $url 열기 실패');
    }
  }

  void showErrorDialog(String errorMsg) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('실패'),
            content: Text(errorMsg),
            actions: [
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('다시 시도하세요.'))
            ],
          );
        });
  }
}
