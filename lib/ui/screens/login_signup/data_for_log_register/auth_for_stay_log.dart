import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);

}
class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged =>
      _firebaseAuth.authStateChanges().map(
            ( User user) => user?.uid,
      );
  @override
  Future<String> signInWithEmailAndPassword(String email,
      String password) async {
    final  User user = (await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password)) as  User;
    return user?.uid;
  }

  @override
  Future<String> createUserWithEmailAndPassword(String email,
      String password) async {
    final  User user = (await _firebaseAuth
        .createUserWithEmailAndPassword(
        email: email, password: password)) as  User;
    return user?.uid;
  }

  @override
  Future<String> currentUser() async {
    final  User user = await _firebaseAuth.currentUser ;
    return user?.uid;
  }
  Future<String> getCurrentUID() async {
    return (_firebaseAuth.currentUser ).uid;
  }

  Future getCurrentUser() async {
    return _firebaseAuth.currentUser ;
  }
}