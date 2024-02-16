import 'package:ecommerce_admin/core/components/custom_appbar.dart';
import 'package:ecommerce_admin/core/components/no_data_view.dart';
import 'package:ecommerce_admin/view/notification/models/notification_model.dart';
import 'package:ecommerce_admin/view/order/order_details_page.dart';
import 'package:ecommerce_admin/view/product/product_details_page.dart';
import 'package:ecommerce_admin/view/user/user_list_page.dart';
import 'package:ecommerce_admin/view/notification/provider/notification_provider.dart';
import 'package:ecommerce_admin/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  static const String routeName = '/notification';

  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Notifications'),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, child) {
          provider.sortNotificationList();
          return provider.notificationList.isNotEmpty ? ListView.builder(
            itemCount: provider.notificationList.length,
            itemBuilder: (context, index) {
              final notification = provider.notificationList[index];
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  onTap: (){
                    _navigate(context, notification, provider);
                  },
                  tileColor: notification.status! ? null : Colors.grey.withOpacity(.5),
                  title: Text(notification.title ?? notification.type.toString()),
                  subtitle: Text(notification.message!),
                ),
              );
            },)  : const Center(child: NoDataView(),);
        }

      ),
    );
  }

  void _navigate(BuildContext context, NotificationModel notification, NotificationProvider provider) {
    String routeName = '';
    String id = '';
    debugPrint('notification type: ${notification.type}');
    switch (notification.type){
      case NotificationType.user:
        routeName = UserListPage.routeName;
        id = notification.userModel!.userId;
        break;
      case NotificationType.comment:
        routeName = ProductDetailsPage.routeName;
        id = notification.commentModel!.productId;
        break;
      case NotificationType.order:
        routeName = OrderDetailsPage.routeName;
        id = notification.orderModel!.orderId;
    }
    provider.updateNotificationStatus(notification.id!);
    Navigator.pushNamed(context, routeName, arguments: id);
  }
}
