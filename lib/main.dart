import 'package:ecommerce_admin/view/auth/login_page.dart';
import 'package:ecommerce_admin/view/category/provider/category_provider.dart';
import 'package:ecommerce_admin/view/product/add_product_page.dart';
import 'package:ecommerce_admin/view/category/category_page.dart';
import 'package:ecommerce_admin/view/dashboard/dashboard_page.dart';
import 'package:ecommerce_admin/view/dashboard/launcher_page.dart';
import 'package:ecommerce_admin/view/notification/notification_page.dart';
import 'package:ecommerce_admin/view/order/order_details_page.dart';
import 'package:ecommerce_admin/view/order/order_page.dart';
import 'package:ecommerce_admin/view/product/product_details_page.dart';
import 'package:ecommerce_admin/view/product/product_repurchase_page.dart';
import 'package:ecommerce_admin/view/report/report_page.dart';
import 'package:ecommerce_admin/view/setting/settings_page.dart';
import 'package:ecommerce_admin/view/user/user_list_page.dart';
import 'package:ecommerce_admin/view/product/view_product_page.dart';
import 'package:ecommerce_admin/view/notification/provider/notification_provider.dart';
import 'package:ecommerce_admin/view/order/provider/order_provider.dart';
import 'package:ecommerce_admin/view/product/provider/product_provider.dart';
import 'package:ecommerce_admin/view/user/provider/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
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
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
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
      debugShowCheckedModeBanner:false,
      builder: EasyLoading.init(),
      initialRoute: LauncherPage.routeName,
      themeMode: ThemeMode.system,
      theme: LightTheme.theme,
      darkTheme: DarkTheme.theme,
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


