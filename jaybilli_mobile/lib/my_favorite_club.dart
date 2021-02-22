import 'package:flutter/material.dart';
import 'package:jaybilli_mobile/constant/contants.dart';
import 'package:jaybilli_mobile/data/my_favorite_club_item.dart';
import 'package:jaybilli_mobile/my_favorite_club_data.dart';
import 'package:jaybilli_mobile/my_favorite_club_widget.dart';

class MyFavoriteClub extends StatefulWidget {
  @override
  _MyFavoriteClubState createState() => _MyFavoriteClubState();
}

class _MyFavoriteClubState extends State<MyFavoriteClub> {
  final key = GlobalKey<AnimatedListState>();
  final items = List.from(MyFavoriteClubData.myFavoriteClubList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(mainColor),
        centerTitle: true,
        title: Text('자주가는 클럽'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: AnimatedList(
                  key: key,
                   initialItemCount: items.length,
                  itemBuilder: (context, index, animation) =>
                    buildItem(items[index], index, animation),
                )
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: buildInsertButton(),
            )
          ],
        )
      ),
    );
  }

  Widget buildItem(item, int index, Animation<double> animation) =>
      MyFavoriteClubWidget(
      item: item,
      animation: animation,
      onClicked:() {
        removeItem(index);
      }
    );

  Widget buildInsertButton() {
    return RaisedButton(
      child: Text('Insert item'),
      onPressed: () {
        insertItem(0, MyFavoriteClubData.myFavoriteClubList.first);
      },
    );
  }

  void removeItem(int index){
    final item = items.removeAt(index);

    key.currentState.removeItem(index, (context, animation) => buildItem(item, index, animation));
  }

  void insertItem(int index, MyFavoriteClubItem item) {
    items.insert(index, item);
    key.currentState.insertItem(index);
  }
}
