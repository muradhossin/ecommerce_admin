import 'package:ecommerce_admin/view/notification/notification_page.dart';
import 'package:flutter/material.dart';

import '../../product/add_product_page.dart';
import '../../category/category_page.dart';
import '../../order/order_page.dart';
import '../../report/report_page.dart';
import '../../setting/settings_page.dart';
import '../../user/user_list_page.dart';
import '../../product/view_product_page.dart';

class DashboardModel {
  final String title;
  final IconData iconData;
  final String routeName;

  const DashboardModel({
    required this.title,
    required this.iconData,
    required this.routeName,
  });
}

const List<DashboardModel>dashboardModelList = [
  DashboardModel(title: 'Add Product', iconData: Icons.add, routeName: AddProductPage.routeName),
  DashboardModel(title: 'View Product', iconData: Icons.card_giftcard, routeName: ViewProductPage.routeName),
  DashboardModel(title: 'Categories', iconData: Icons.category, routeName: CategoryPage.routeName),
  DashboardModel(title: 'Orders', iconData: Icons.monetization_on, routeName: OrderPage.routeName),
  DashboardModel(title: 'Users', iconData: Icons.person, routeName: UserListPage.routeName),
  DashboardModel(title: 'Settings', iconData: Icons.settings, routeName: SettingsPage.routeName),
  DashboardModel(title: 'Report', iconData: Icons.pie_chart, routeName: ReportPage.routeName),
  DashboardModel(title: 'Notification', iconData: Icons.notification_important, routeName: NotificationPage.routeName),
];