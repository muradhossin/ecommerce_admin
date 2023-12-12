import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/core/constants/constants.dart';

class AuthRepository {
  static final _db = FirebaseFirestore.instance;

  static Future<bool> isAdmin(String uid) async {
    final snapshot = await _db.collection(collectionAdmin).doc(uid).get();
    return snapshot.exists;
  }

}