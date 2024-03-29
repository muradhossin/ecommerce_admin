import 'package:ecommerce_admin/view/auth/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static User? get currentUser => _auth.currentUser;

  static Future<bool> loginAdmin(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return AuthRepository.isAdmin(credential.user!.uid);
  }

  static Future<void> logout(){
    return _auth.signOut();
  }

  static Future<bool> getThemeFromSharedPref() async{
    return AuthRepository.getTheme();
  }


}
