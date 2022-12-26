import 'package:ecommerce_admin/providers/order_provider.dart';
import 'package:ecommerce_admin/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';
import 'order_details_page.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);
  static const String routeName = '/orderpage';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.orderList.length,
          itemBuilder: (context, index) {
            final order = provider.orderList[index];
            return ListTile(
              tileColor: order.orderId == id? Colors.grey : null,
              onTap: () {
                Navigator.pushNamed(context, OrderDetailsPage.routeName, arguments: order.orderId);
              },
              title: Text(getFormattedDate(
                  order.orderDate.timestamp.toDate(),
                  pattern: 'dd/MM/yyyy HH:mm:ss')),
              subtitle: Text(order.orderStatus),
              trailing: Text('$currencySymbol${order.grandTotal}'),
            );
          },
        ),
      ),
    );
  }
}
