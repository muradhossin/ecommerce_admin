import 'dart:convert';

import 'package:ecommerce_admin/core/components/custom_appbar.dart';
import 'package:ecommerce_admin/core/constants/dimensions.dart';
import 'package:ecommerce_admin/core/extensions/context.dart';
import 'package:ecommerce_admin/core/utils/notification_helper.dart';
import 'package:ecommerce_admin/view/auth/services/auth_service.dart';
import 'package:ecommerce_admin/view/category/provider/category_provider.dart';
import 'package:ecommerce_admin/view/dashboard/widgets/badge_view.dart';
import 'package:ecommerce_admin/view/dashboard/widgets/dashboard_item_view.dart';
import 'package:ecommerce_admin/view/dashboard/models/dashboard_model.dart';
import 'package:ecommerce_admin/view/dashboard/launcher_page.dart';
import 'package:ecommerce_admin/view/notification/provider/notification_provider.dart';
import 'package:ecommerce_admin/view/order/provider/order_provider.dart';
import 'package:ecommerce_admin/view/product/provider/product_provider.dart';
import 'package:ecommerce_admin/view/user/provider/user_provider.dart';
import 'package:ecommerce_admin/core/constants/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  static const String routeName = '/dashboardpage';

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    setupInteractedMessage();
    notificationPermission();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<CategoryProvider>(context, listen: false).getAllCategories();
    Provider.of<ProductProvider>(context, listen: false).getAllProducts();
    Provider.of<ProductProvider>(context, listen: false).getAllPurchases();
    Provider.of<OrderProvider>(context, listen: false).getOrderConstants();
    Provider.of<OrderProvider>(context, listen: false).getOrders();
    Provider.of<UserProvider>(context, listen: false).getAllUser();
    Provider.of<NotificationProvider>(context, listen: false).getAllNotification();
    super.didChangeDependencies();
  }

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      NotificationHelper.handleBackgroundNotification(initialMessage);
    }

  }

  void notificationPermission() async {
    if (!await NotificationHelper.checkNotificationPermission()) {
      await NotificationHelper.requestNotificationPermission();
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: CustomAppbar(
        title: 'Dashboard',
        actions: [
          IconButton(
            onPressed: () {
              AuthService.logout().then(
                (value) => Navigator.pushReplacementNamed(context, LauncherPage.routeName),
              );
            },
            icon: Icon(Icons.logout, color: context.theme.cardColor),
          ),
          IconButton(
            onPressed: (){
              _sendNotification();
            },
            icon: Icon(Icons.send, color: context.theme.cardColor,),
          ),
        ],
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(Dimensions.paddingSmall),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,

        ),
        itemCount: dashboardModelList.length,
        itemBuilder: (context, index) {
          final model = dashboardModelList[index];
          if (model.title == 'Notification') {
            final count =
                Provider.of<NotificationProvider>(context).totalUnreadMessage;
            return DashboardItemView(
              model: model,
              badge: BadgeView(
                count: count,
              ),
            );
          }
          return DashboardItemView(
            model: model,
          );
        },
      ),
    );
  }

  void _sendNotification() async{
    const url = 'https://fcm.googleapis.com/fcm/send';
    final header = {
      'Content-Type' : 'application/json',
      'Authorization' : 'key=$serverKey',
    };
    final body = {
      "to": "/topics/promo",
      "notification": {
        "title": "Breaking News",
        "body": "New news story available."
      },
      "data": {
        "key": "promo",
        "value": "PB293473"
      }
    };

    try{
      final response = await http.post(Uri.parse(url), headers: header, body: json.encode(body));
      if (kDebugMode) {
        print('STATUS CODE: ${response.statusCode}');
      }
    }catch(error){
      if (kDebugMode) {
        print(error.toString());
      }
    }

  }
}
