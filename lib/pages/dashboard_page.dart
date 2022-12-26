import 'package:ecommerce_admin/auth/auth_service.dart';
import 'package:ecommerce_admin/customwidgets/badge_view.dart';
import 'package:ecommerce_admin/customwidgets/dashboard_item_view.dart';
import 'package:ecommerce_admin/models/dashboard_model.dart';
import 'package:ecommerce_admin/pages/launcher_page.dart';
import 'package:ecommerce_admin/providers/notification_provider.dart';
import 'package:ecommerce_admin/providers/order_provider.dart';
import 'package:ecommerce_admin/providers/product_provider.dart';
import 'package:ecommerce_admin/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);
  static const String routeName = '/dashboardpage';

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context,listen: false).getAllCategories();
    Provider.of<ProductProvider>(context,listen: false).getAllProducts();
    Provider.of<ProductProvider>(context,listen: false).getAllPurchases();
    Provider.of<OrderProvider>(context,listen: false).getOrderConstants();
    Provider.of<OrderProvider>(context,listen: false).getOrders();
    Provider.of<UserProvider>(context, listen: false).getAllUser();
    Provider.of<NotificationProvider>(context, listen: false).getAllNotification();
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
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: dashboardModelList.length,
        itemBuilder: (context, index) {
          final model = dashboardModelList[index];
          if(model.title == 'Notification'){
            final count = Provider.of<NotificationProvider>(context).totalUnreadMessage;
            return DashboardItemView(
              model: model, badge: BadgeView(count: count,),);
          }
          return DashboardItemView(
              model: model,);
        },
      ),
    );
  }
}
