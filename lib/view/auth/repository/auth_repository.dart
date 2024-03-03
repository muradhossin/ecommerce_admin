import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/core/constants/app_constants.dart';
import 'package:ecommerce_admin/core/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  static final _db = FirebaseFirestore.instance;
  static final sharedPref = SharedPreferences.getInstance();

  static Future<bool> isAdmin(String uid) async {
    final snapshot = await _db.collection(collectionAdmin).doc(uid).get();
    return snapshot.exists;
  }

  static Future<void> setTheme(bool isLightTheme) async {
    sharedPref.then((value) => value.setBool(AppConstants.themeMode, isLightTheme));
  }

  static Future<bool> getTheme() async{
    return sharedPref.then((value) => value.getBool(AppConstants.themeMode) ?? true);
  }



}