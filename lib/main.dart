import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/pages/add_product_page.dart';
import 'package:ecommerce_admin/pages/category_page.dart';
import 'package:ecommerce_admin/pages/dashboard_page.dart';
import 'package:ecommerce_admin/pages/launcher_page.dart';
import 'package:ecommerce_admin/pages/login_page.dart';
import 'package:ecommerce_admin/pages/notification_page.dart';
import 'package:ecommerce_admin/pages/order_details_page.dart';
import 'package:ecommerce_admin/pages/order_page.dart';
import 'package:ecommerce_admin/pages/product_details_page.dart';
import 'package:ecommerce_admin/pages/product_repurchase_page.dart';
import 'package:ecommerce_admin/pages/report_page.dart';
import 'package:ecommerce_admin/pages/settings_page.dart';
import 'package:ecommerce_admin/pages/user_list_page.dart';
import 'package:ecommerce_admin/pages/view_product_page.dart';
import 'package:ecommerce_admin/providers/notification_provider.dart';
import 'package:ecommerce_admin/providers/order_provider.dart';
import 'package:ecommerce_admin/providers/product_provider.dart';
import 'package:ecommerce_admin/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName: (_) => const LauncherPage(),
        LoginPage.routeName: (_) => const LoginPage(),
        DashboardPage.routeName: (_) => const DashboardPage(),
        AddProductPage.routeName: (_) => const AddProductPage(),
        ViewProductPage.routeName: (_) => const ViewProductPage(),
        ProductDetailsPage.routeName: (_) => ProductDetailsPage(),
        CategoryPage.routeName: (_) => const CategoryPage(),
        OrderPage.routeName: (_) => const OrderPage(),
        ReportPage.routeName: (_) => const ReportPage(),
        SettingsPage.routeName: (_) => const SettingsPage(),
        ProductRepurchasePage.routeName: (_) => const ProductRepurchasePage(),
        UserListPage.routeName: (_) => const UserListPage(),
        OrderDetailsPage.routeName: (_) => const OrderDetailsPage(),
        NotificationPage.routeName: (_) => const NotificationPage(),

      },
    );
  }
}


