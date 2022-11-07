import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService{
  static final _auth = FirebaseAuth.instance;
  static User? get currentUser => _auth.currentUser;
}