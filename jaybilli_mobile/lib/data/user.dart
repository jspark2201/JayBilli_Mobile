import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jaybilli_mobile/constant/firebase_keys.dart';

class User{
  final String userKey;
  final String profileImg;
  final String userId;
  final String userName;
  final String userGender;
  final String userBirthday;
  final String userEmail;
  final String userPhoneNumber;
  final String userAvg;
  final DocumentReference reference;

  User.fromMap(Map<String, dynamic> map, this.userKey, {this.reference})
    : profileImg = map[KEY_PROFILEIMG],
      userId = map[KEY_USERID],
      userName = map[KEY_USERNAME],
      userGender = map[KEY_USERGENDER],
      userBirthday = map[KEY_USERBIRTHDAY],
      userEmail = map[KEY_USEREMAIL],
      userPhoneNumber = map[KEY_USERPHONENUMBER],
      userAvg = map[KEY_USERAVG];

  User.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(
      snapshot.data,
      snapshot.documentID,
      reference: snapshot.reference,
  );

  static Map<String, dynamic> getMapForCreateUser(String email) {
    Map<String, dynamic> map = Map();
    map[KEY_PROFILEIMG] = '';
    map[KEY_USERID] = '';
    map[KEY_USERNAME] = '';
    map[KEY_USERGENDER] = '';
    map[KEY_USERBIRTHDAY] = '';
    map[KEY_USEREMAIL] = email;
    map[KEY_USERPHONENUMBER] = '';
    map[KEY_USERAVG] = '2';
    return map;
  }
}