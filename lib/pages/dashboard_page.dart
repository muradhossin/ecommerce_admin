import 'package:ecommerce_admin/auth/auth_service.dart';
import 'package:ecommerce_admin/pages/launcher_page.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);
  static const String routeName = '/dashboardpage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              AuthService.logout().then(
                (value) => Navigator.pushReplacementNamed(context, LauncherPage.routeName),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Text('Dashboard page'),
      ),
    );
  }
}
