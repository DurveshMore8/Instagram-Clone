import 'package:firebase_auth/firebase_auth.dart';

Future<void> signoutUser() async {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  await firebaseAuth.signOut();
}
