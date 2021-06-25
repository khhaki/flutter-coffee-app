import 'package:app/models/user.dart';
import 'package:app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //user object based on fire user
  Mosta? _userFromFire(User user) {
    // ignore: unnecessary_null_comparison
    if (user != null) {
      return Mosta(uid: user.uid);
    } else {
      return null;
    }
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user as User;
      return _userFromFire(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //auth change user stream

  Stream<Mosta?> get user {
    return _auth.authStateChanges().map((User? user) => _userFromFire(user!));
  }

  //sign in with email and pass

  Future signinE(String email, String passw) async {
    try {
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: passw);
      User user = result.user as User;
      return _userFromFire(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email
  Future registerE(String email, String passw) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: passw);
      User user = result.user as User;
      await Databaseser(uid: user.uid).updateuserData('0', 'new', 100);
      return _userFromFire(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //sign out

  Future signO() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
