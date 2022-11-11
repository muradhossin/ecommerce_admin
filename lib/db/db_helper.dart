import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/models/category_model.dart';

class DbHelper {
  static const String collectionAdmin = 'Admins';
  static final _db = FirebaseFirestore.instance;

  static Future<bool> isAdmin(String uid) async{
    final snapshot = await _db.collection(collectionAdmin).doc(uid).get();
    return snapshot.exists;
  }

  static Future<void> addCategory(CategoryModel categoryModel){
    final catDoc = _db.collection(collectionCategory).doc();
    categoryModel.categoryId = catDoc.id;
    return catDoc.set(categoryModel.toMap());
  }
}