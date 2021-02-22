import 'package:flutter/material.dart';
import 'package:jaybilli_mobile/data/my_favorite_club_item.dart';

class MyFavoriteClubWidget extends StatelessWidget {
  final MyFavoriteClubItem item;
  final Animation animation;
  final VoidCallback onClicked;

  const MyFavoriteClubWidget({Key key, this.item, this.animation, this.onClicked}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: Container(
        margin: EdgeInsets.all(8.0),
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.grey[300],
        ),
        child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            leading: CircleAvatar(
              radius: 32,
              backgroundImage: NetworkImage(item.url),
            ),
          title: Text(item.title, style: TextStyle(fontSize: 20.0),),
          trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.redAccent  , ),
            onPressed: onClicked ,
          ),
        ),
      ),
    );
  }
}
