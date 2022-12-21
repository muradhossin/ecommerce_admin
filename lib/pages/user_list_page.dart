import 'package:ecommerce_admin/providers/user_provider.dart';
import 'package:ecommerce_admin/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({Key? key}) : super(key: key);
  static const String routeName = '/userlistpage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.userList.length,
          itemBuilder: (context, index) {
            final user = provider.userList[index];
            return ListTile(
              title: Text(user.displayName ?? 'No Display Name'),
              subtitle: Text(user.email),
              trailing: Text(
                  "Joint on \n${getFormattedDate(user.userCreationTime!.toDate())}"),
            );
          },
        ),
      ),
    );
  }
}
