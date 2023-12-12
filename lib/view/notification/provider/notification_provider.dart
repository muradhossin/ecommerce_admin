
import 'package:ecommerce_admin/view/notification/repository/notification_repository.dart';
import 'package:flutter/material.dart';

import '../models/notification_model.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationModel> notificationList = [];

  getAllNotification() {
    NotificationRepository.getAllNotifications().listen((snapshot) {
      notificationList = List.generate(snapshot.docs.length,
          (index) => NotificationModel.fromMap(snapshot.docs[index].data()));
    notifyListeners();
    });
  }

  Future<void> updateNotificationStatus(String notId) =>
      NotificationRepository.updateNotificationStatus(notId);

  int get totalUnreadMessage{
    int total = 0;
    for (final n in notificationList){
      if(!n.status){
        total += 1;
      }
    }
    return total;
  }
}
