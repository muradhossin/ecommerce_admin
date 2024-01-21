import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/view/category/models/category_model.dart';

class CategoryRepository {
  static final _db = FirebaseFirestore.instance;

  static Future<void> addCategory(CategoryModel categoryModel) {
    final catDoc = _db.collection(collectionCategory).doc();
    categoryModel.categoryId = catDoc.id;
    return catDoc.set(categoryModel.toMap());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategories() =>
      _db.collection(collectionCategory).snapshots();

  static Future<void> updateCategory(CategoryModel categoryModel) {
    return _db
        .collection(collectionCategory)
        .doc(categoryModel.categoryId)
        .update(categoryModel.toMap());
  }

  static Future<void> deleteCategory(String? categoryId) {
    return _db.collection(collectionCategory).doc(categoryId).delete();
  }
}