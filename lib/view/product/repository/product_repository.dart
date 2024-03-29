import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/view/category/models/category_model.dart';
import 'package:ecommerce_admin/view/category/models/comment_model.dart';
import 'package:ecommerce_admin/view/product/models/product_model.dart';
import 'package:ecommerce_admin/view/product/models/purchase_model.dart';

class ProductRepository {
  static final _db = FirebaseFirestore.instance;

  static Future<void> addNewProduct(
      ProductModel productModel, PurchaseModel purchaseModel) {
    final wb = _db.batch();
    final productDoc = _db.collection(collectionProduct).doc();
    final purchaseDoc = _db.collection(collectionPurchase).doc();
    productModel.productId = productDoc.id;
    purchaseModel.productId = productDoc.id;
    purchaseModel.purchaseId = purchaseDoc.id;
    wb.set(productDoc, productModel.toMap());
    wb.set(purchaseDoc, purchaseModel.toMap());
    final updatedCount =
        purchaseModel.purchaseQuantity + productModel.category.productCount;
    final catDoc = _db
        .collection(collectionCategory)
        .doc(productModel.category.categoryId);
    wb.update(catDoc, {categoryFieldProductCount: updatedCount});
    return wb.commit();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts() =>
      _db.collection(collectionProduct).snapshots();


  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllPurchases() =>
      _db.collection(collectionPurchase).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProductsByCategory(
      String categoryName) =>
      _db
          .collection(collectionProduct)
          .where('$productFieldCategory.$categoryFieldName',
          isEqualTo: categoryName)
          .snapshots();

  static Future<void> updateProductField(
      String productId, Map<String, dynamic> map) {
    return _db.collection(collectionProduct).doc(productId).update(map);
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getAllPurchaseByProductId(
      String productId) =>
      _db
          .collection(collectionPurchase)
          .where(purchaseFieldProductId, isEqualTo: productId)
          .get();


  static Future<void> repurchase(
      PurchaseModel purchaseModel, ProductModel productModel) async {
    final wb = _db.batch();
    final doc = _db.collection(collectionPurchase).doc();
    purchaseModel.purchaseId = doc.id;
    wb.set(doc, purchaseModel.toMap());
    final productDoc =
    _db.collection(collectionProduct).doc(productModel.productId);
    wb.update(productDoc, {
      productFieldStock: (productModel.stock + purchaseModel.purchaseQuantity)
    });
    final snapshot = await _db
        .collection(collectionCategory)
        .doc(productModel.category.categoryId)
        .get();
    final previousCount = snapshot.data()?[categoryFieldProductCount] ?? 0;
    final catDoc = _db
        .collection(collectionCategory)
        .doc(productModel.category.categoryId);
    wb.update(catDoc, {
      categoryFieldProductCount:
      (purchaseModel.purchaseQuantity + previousCount)
    });
    return wb.commit();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getCommentsByProduct(
      String productId) =>
      _db
          .collection(collectionProduct)
          .doc(productId)
          .collection(collectionComment)
          .get();

  static Future<void> approveComment(String productId, CommentModel commentModel) {
    return _db.collection(collectionProduct)
        .doc(productId)
        .collection(collectionComment)
        .doc(commentModel.commentId)
        .update({commentFieldApproved : true});
  }

  static Future<void> updateProduct(ProductModel productModel) {
    return _db.collection(collectionProduct)
        .doc(productModel.productId)
        .update(productModel.toMap());
  }

  static Future<void> deleteProduct(String productId) {
    return _db.collection(collectionProduct).doc(productId).delete();
  }

}
