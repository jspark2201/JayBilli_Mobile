import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jaybilli_mobile/constant/firebase_keys.dart';
import 'package:jaybilli_mobile/data/user.dart';
import 'package:jaybilli_mobile/firebase/transformer.dart';

class FirestoreProvider with Transformer{
  final Firestore _firestore = Firestore.instance;

  Future<void> attemptCreateUser({String userKey, String email}) async{
    final DocumentReference userRef = _firestore.collection(COLLECTION_USERS).document(userKey);
    final DocumentSnapshot snapshot = await userRef.get();
    return _firestore.runTransaction((Transaction tx) async{
      if(!snapshot.exists) {
        await tx.set(userRef, User.getMapForCreateUser(email));
      }
    });
  }

  Stream<User> connectMyUserData(String userKey) {
    return _firestore.collection(COLLECTION_USERS).document(userKey).snapshots().transform(toUser);
  }


  // Future<void> sendData() {
  //   return Firestore.instance
  //       .collection(COLLECTION_USERS)
  //       .document('123123123')
  //       .setData({'email':'testing@test.com', 'author':'author'});
  // }
  //
  // void getData() {
  //   Firestore.instance
  //       .collection(COLLECTION_USERS)
  //       .document('123123123')
  //       .get()
  //       .then((DocumentSnapshot ds){
  //         print(ds.data);
  //   });
  // }
}

FirestoreProvider firestoreProvider = FirestoreProvider();