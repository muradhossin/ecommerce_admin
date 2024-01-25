import 'package:ecommerce_admin/view/auth/login_page.dart';
import 'package:ecommerce_admin/view/auth/services/auth_service.dart';
import 'package:ecommerce_admin/view/dashboard/dashboard_page.dart';

import 'package:flutter/material.dart';

class LauncherPage extends StatelessWidget {
  const LauncherPage({super.key});
  static const String routeName = '/launcherpage';
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, (){
      if(AuthService.currentUser != null){
        Navigator.pushReplacementNamed(context, DashboardPage.routeName);
      }else{
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }
    });
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
