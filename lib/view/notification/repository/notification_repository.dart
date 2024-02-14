import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/core/constants/app_constants.dart';
import 'package:ecommerce_admin/view/notification/models/notification_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

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

  static Future<void> sendTopicNotification(NotificationModel notificationModel, String topic) async {
    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=${AppConstants.serverKey}',
    };

    final body = jsonEncode({
      'to': '/topics/$topic',
      'notification': {
        'title': notificationModel.title,
        'body': notificationModel.body,
        'type' : notificationModel.type,
        'id' : '${notificationModel.orderModel?.orderId}',
        'type_data' : '${notificationModel.typedata}'
      },
      'data': notificationModel.toMap(),
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      debugPrint('Notification sent successfully');
    } else {
      debugPrint('Failed to send notification: ${response.body}');
    }
  }



}