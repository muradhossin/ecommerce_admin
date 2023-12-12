import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/view/order/models/order_constant_model.dart';
import 'package:ecommerce_admin/view/order/models/order_model.dart';

class OrderRepository {
  static final _db = FirebaseFirestore.instance;

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getOrderConstants() =>
      _db.collection(collectionUtils).doc(documentOrderConstants).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllOrders() =>
      _db.collection(collectionOrder).snapshots();

  static Future<void> updateOrderConstants(OrderConstantModel model) {
    return _db
        .collection(collectionUtils)
        .doc(documentOrderConstants)
        .update(model.toMap());
  }

  static Future<void> updateOrderStatus(String orderId, String status) {
    return _db
        .collection(collectionOrder)
        .doc(orderId)
        .update({orderFieldOrderStatus: status});
  }
}