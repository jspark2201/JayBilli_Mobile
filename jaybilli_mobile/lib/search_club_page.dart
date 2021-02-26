import 'package:flutter/material.dart';
import 'package:jaybilli_mobile/my_favorite_club_data.dart';

class SearchClubPage extends StatefulWidget {
  @override
  _SearchClubPageState createState() => _SearchClubPageState();
}

class _SearchClubPageState extends State<SearchClubPage> {

  final items = List.from(MyFavoriteClubData.myFavoriteClubList);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for(final item in items)
          Text(item.title),
      ],
    );
  }
}
