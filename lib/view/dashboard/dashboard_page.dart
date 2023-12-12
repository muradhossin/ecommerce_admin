import 'dart:convert';

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
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);
  static const String routeName = '/dashboardpage';

  @override
  Widget build(BuildContext context) {
    Provider.of<CategoryProvider>(context, listen: false).getAllCategories();
    Provider.of<ProductProvider>(context, listen: false).getAllProducts();
    Provider.of<ProductProvider>(context, listen: false).getAllPurchases();
    Provider.of<OrderProvider>(context, listen: false).getOrderConstants();
    Provider.of<OrderProvider>(context, listen: false).getOrders();
    Provider.of<UserProvider>(context, listen: false).getAllUser();
    Provider.of<NotificationProvider>(context, listen: false)
        .getAllNotification();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              AuthService.logout().then(
                (value) => Navigator.pushReplacementNamed(
                    context, LauncherPage.routeName),
              );
            },
            icon: const Icon(Icons.logout),
          ),
          IconButton(
            onPressed: (){
              _sendNotification();
            },
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: GridView.builder(
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
    final url = 'https://fcm.googleapis.com/fcm/send';
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
      print('STATUS CODE: ${response.statusCode}');
    }catch(error){
      print(error.toString());
    }

  }
}