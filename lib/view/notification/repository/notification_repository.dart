import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/view/notification/models/notification_model.dart';

class NotificationRepository {
  static final _db = FirebaseFirestore.instance;

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllNotifications() =>
      _db.collection(collectionNotification).snapshots();

  static Future<void> updateNotificationStatus(String id) {
    return _db
        .collection(collectionNotification)
        .doc(id)
        .update({notificationFieldStatus: true});
  }


}