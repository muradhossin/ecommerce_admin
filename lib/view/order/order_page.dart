import 'package:ecommerce_admin/core/components/custom_appbar.dart';
import 'package:ecommerce_admin/core/constants/dimensions.dart';
import 'package:ecommerce_admin/view/order/provider/order_provider.dart';
import 'package:ecommerce_admin/core/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/constants.dart';
import 'order_details_page.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});
  static const String routeName = '/orderpage';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
      appBar: const CustomAppbar(title: 'Orders'),
      body: Consumer<OrderProvider>(
        builder: (context, provider, child) {
          provider.sortOrderList();
          return ListView.builder(
            itemCount: provider.orderList.length,
            itemBuilder: (context, index) {
              final order = provider.orderList[index];
              return ListTile(
                tileColor: order.orderId == id? Colors.grey : null,
                onTap: () {
                  Navigator.pushNamed(context, OrderDetailsPage.routeName, arguments: order.orderId);
                },
                title: Text(getFormattedDate(
                    getDateTimeFromTimeStampString(order.orderDate.timestamp),
                    pattern: 'dd MMM yyyy hh:mm a')),
                subtitle: Wrap(
                  children: [
                    Text('Order ID: ${order.orderId}'),
                    const SizedBox(height: 20, child: VerticalDivider()),
                    Text('Status: ${order.orderStatus}'),
                  ],
                ),
                trailing: Text('$currencySymbol${order.grandTotal}'),
              );
            },
          );
        }
      ),
    );
  }
}
