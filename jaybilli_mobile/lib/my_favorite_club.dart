import 'package:flutter/material.dart';
import 'package:jaybilli_mobile/constant/contants.dart';
import 'package:jaybilli_mobile/data/my_favorite_club_item.dart';
import 'package:jaybilli_mobile/favorite_club_edit_page.dart';
import 'package:jaybilli_mobile/my_favorite_club_data.dart';
import 'package:jaybilli_mobile/my_favorite_club_widget.dart';
import 'package:vibrate/vibrate.dart';

class MyFavoriteClub extends StatefulWidget {
  @override
  _MyFavoriteClubState createState() => _MyFavoriteClubState();
}

class _MyFavoriteClubState extends State<MyFavoriteClub> {
  bool _canVibrate = true;
  final key = GlobalKey<AnimatedListState>();

  final items = List.from(MyFavoriteClubData.myFavoriteClubList);
  //List<String> items= ['새롬 당구장', '제이빌리', 'SBS 당구장', '나르샤 당구클럽'];
  final test = 'abcde';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    canUseVibrate();
  }

  canUseVibrate() async {
    bool canVibrate = await Vibrate.canVibrate;
    setState(() {
      _canVibrate = canVibrate;
      _canVibrate
          ? print("This device can vibrate")
          : print("This device cannot vibrate");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(mainColor),
        centerTitle: true,
        title: Text('자주가는 클럽'),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => FavoriteClubEditPage(title: test,)));
            },
            icon: Icon(Icons.edit),
          )
        ],

      ),
      body: SafeArea(
          child: Column(
        children: [
          // Expanded(
          //   child: ListView.builder(
          //       padding: EdgeInsets.all(8.0),
          //       itemCount: items.length,
          //       itemBuilder: (BuildContext context, int index) {
          //         final item = items[index];
          //         return Dismissible(
          //           key: Key(item),
          //           child: ListTile(
          //             leading: index == 1
          //                 ? SizedBox(
          //                     width: 30.0,
          //                     child: Icon(
          //                       Icons.star_rate_rounded,
          //                       color: Colors.yellow,
          //                     ))
          //                 : SizedBox(
          //                     width: 30.0,
          //                   ),
          //             trailing: GestureDetector(
          //                 onLongPress: (){
          //                   print('asdasda');
          //                   //Vibrate.vibrate();
          //                 },
          //                 child: Icon(Icons.menu_rounded)),
          //             title: Text('$item'),
          //           ),
          //           background: slideRightBackground(),
          //           secondaryBackground: slideLeftBackground(),
          //           confirmDismiss: (direction) async {
          //             if (direction == DismissDirection.endToStart) {
          //               final bool endToStartResult = await showDialog(
          //                   context: context,
          //                   builder: (BuildContext context) {
          //                     return AlertDialog(
          //                         content: Text(
          //                             "${items[index]}을(를) 자주가는 목록에서 삭제하시겠습니까?"),
          //                         actions: <Widget>[
          //                           FlatButton(
          //                             child: Text(
          //                               "아니오",
          //                               style: TextStyle(color: Colors.black),
          //                             ),
          //                             onPressed: () {
          //                               Navigator.of(context).pop();
          //                             },
          //                           ),
          //                           FlatButton(
          //                             child: Text(
          //                               "삭제",
          //                               style: TextStyle(color: Colors.red),
          //                             ),
          //                             onPressed: () {
          //                               // TODO: Delete the item from DB etc..
          //                               setState(() {
          //                                 items.removeAt(index);
          //                               });
          //                               Navigator.of(context).pop();
          //                             },
          //                           ),
          //                         ]);
          //                   });
          //               return endToStartResult;
          //             } else {
          //               // 해당 당구장을 즐겨찾기 설정할 것인지 물어보는 다이얼로그
          //               final bool startToEndResult = await showDialog(
          //                   context: context,
          //                   builder: (BuildContext context) {
          //                     return AlertDialog(
          //                         content: Text(
          //                             "${items[index]}을(를) 즐겨찾는 클럽으로 등록하시겠습니까?"),
          //                         actions: <Widget>[
          //                           FlatButton(
          //                             child: Text(
          //                               "아니오",
          //                               style: TextStyle(color: Colors.black),
          //                             ),
          //                             onPressed: () {
          //                               Navigator.of(context).pop();
          //                             },
          //                           ),
          //                           FlatButton(
          //                             child: Text(
          //                               "등록",
          //                               style: TextStyle(color: Colors.green),
          //                             ),
          //                             onPressed: () {
          //                               // TODO: Delete the item from DB etc..
          //                               setState(() {});
          //                               Navigator.of(context).pop();
          //                             },
          //                           ),
          //                         ]);
          //                   });
          //               return startToEndResult;
          //             }
          //           },
          //         );
          //       }),
          // ),
          Expanded(
            child: ReorderableListView(
                children: [
                  for(final item in items)
                    Dismissible(
                      key: Key(item.key),
                      background: slideRightBackground(),
                      secondaryBackground: slideLeftBackground(),
                      child: Card(
                        key: ValueKey(item),
                        elevation: 2,
                        child: ListTile(
                          title: Text(item.title),
                          leading: item.bookMark?Icon(Icons.star_rate_rounded, color: Colors.yellow,):Icon(Icons.star_border_rounded),
                          trailing: IconButton(
                              onPressed: (){

                              },
                              icon: Icon(Icons.menu_rounded,)),
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.endToStart) {
                          final bool endToStartResult = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    content: Text(
                                        "${item.title}을(를) 자주가는 목록에서 삭제하시겠습니까?"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text(
                                          "아니오",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      FlatButton(
                                        child: Text(
                                          "삭제",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () {
                                          // TODO: Delete the item from DB etc..
                                          setState(() {
                                            items.removeAt(items.indexOf(item));
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ]);
                              });
                          return endToStartResult;
                        } else {
                          // 해당 당구장을 즐겨찾기 설정할 것인지 물어보는 다이얼로그
                          final bool startToEndResult = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    content: Text(
                                        "${item.title}을(를) 즐겨찾는 클럽으로 등록하시겠습니까?"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text(
                                          "아니오",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      FlatButton(
                                        child: Text(
                                          "등록",
                                          style: TextStyle(color: Colors.green),
                                        ),
                                        onPressed: () {
                                          // TODO: Delete the item from DB etc..
                                          setState(() {

                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ]);
                              });
                          return startToEndResult;
                        }
                      },
                    )
                ],
                onReorder: (int oldIndex, int newIndex) {
                  setState(() {
                    if(newIndex>oldIndex){
                      newIndex-=1;
                    }
                    final item = items.removeAt(oldIndex);
                    items.insert(newIndex, item);
                  });
                }
                ),
          ),
          InkWell(
            onTap: () {
              print('Tapped add button');
            },
            child: Container(
              margin: EdgeInsets.all(8.0),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle_outline),
                  Text('자주가는 클럽 등록'),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.yellow,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.star,
              color: Colors.white,
            ),
            Text(
              "즐겨찾기",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " 삭제",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

// Widget buildInsertButton() {
//   return RaisedButton(
//     child: Text('Insert item'),
//     onPressed: () {
//       insertItem(0, MyFavoriteClubData.myFavoriteClubList.first);
//     },
//   );
// }

// void insertItem(int index, MyFavoriteClubItem item) {
//   items.insert(index, item);
//   key.currentState.insertItem(index);
// }
}
