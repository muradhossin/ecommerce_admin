import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/view/user/models/user_model.dart';

class UserRepository {
  static final _db = FirebaseFirestore.instance;

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() =>
      _db.collection(collectionUser).snapshots();

  static Future<bool> doesUserExist(String uid) async {
    final snapshot = await _db.collection(collectionUser).doc(uid).get();
    return snapshot.exists;
  }

  static getUserById(String id) {
    return _db.collection(collectionUser).doc(id).get().then((doc) {
      return UserModel.fromMap(doc.data()!);
    });
  }
}