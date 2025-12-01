import 'package:firebase_auth/firebase_auth.dart';

bool isLogged() {
  return FirebaseAuth.instance.currentUser?.email != null;
}
