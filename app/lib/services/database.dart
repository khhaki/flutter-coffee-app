import 'package:app/models/brew.dart';
import 'package:app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Databaseser {
  final uid;
  Databaseser({this.uid});
  //collection reference
  final CollectionReference hakocoll =
      FirebaseFirestore.instance.collection('hako');
  Future updateuserData(String sugars, String name, int strength) async {
    return await hakocoll
        .doc(uid)
        .set({'sugars': sugars, 'name': name, 'strength': strength});
  }

  //brew list from snopshot
  List<Brew> _brewList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map jh = doc.data() as Map;
      return Brew(
          name: jh['name'] ?? '',
          strength: jh['strength'] ?? 0,
          sugar: jh['sugars'] ?? '');
    }).toList();
  }

  //user data from snapshot
  UserData _userdfsn(DocumentSnapshot snapshot) {
    final mmp = snapshot.data() as Map;
    return UserData(
        name: mmp['name'],
        strength: mmp['strength'],
        sugars: mmp['sugars'],
        uid: uid);
  }

//get hakos stream
  Stream<List<Brew>> get hakos {
    return hakocoll.snapshots().map(_brewList);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return hakocoll.doc(uid).snapshots().map(_userdfsn);
  }
}
