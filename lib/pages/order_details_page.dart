import 'package:ecommerce_admin/models/order_model.dart';
import 'package:ecommerce_admin/providers/order_provider.dart';
import 'package:ecommerce_admin/utils/constants.dart';
import 'package:ecommerce_admin/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class OrderDetailsPage extends StatefulWidget {
  static const String routeName = '/order_details';

  const OrderDetailsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  late OrderProvider orderProvider;
  late OrderModel orderModel;
  late String orderId;
  late String orderStatusGroupValue;

  @override
  void didChangeDependencies() {
    orderProvider = Provider.of<OrderProvider>(context);
    orderId = ModalRoute.of(context)!.settings!.arguments as String;
    orderModel = orderProvider.getOrderById(orderId);
    orderStatusGroupValue = orderModel.orderStatus;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(orderId),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          buildHeader('Product Info'),
          buildProductInfoSection(),
          buildHeader('Order Summary'),
          buildOrderSummarySection(),
          buildHeader('Order Status'),
          buildOrderStatusSection(),
        ],
      ),
    );
  }

  Padding buildHeader(String header) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        header,
        style: const TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }

  Widget buildProductInfoSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: orderModel.productDetails
              .map((cartModel) => ListTile(
                    title: Text(cartModel.productName),
                    trailing:
                        Text('${cartModel.quantity} x ${cartModel.salePrice}'),
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget buildOrderSummarySection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            ListTile(
              title: const Text('Discount'),
              trailing: Text('${orderModel.discount}%'),
            ),
            ListTile(
              title: const Text('VAT'),
              trailing: Text('${orderModel.VAT}%'),
            ),
            ListTile(
              title: const Text('Delivery Charge'),
              trailing: Text('$currencySymbol${orderModel.deliveryCharge}'),
            ),
            ListTile(
              title: const Text(
                'Grand Total',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Text(
                '$currencySymbol${orderModel.grandTotal}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOrderStatusSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Radio(
                  value: OrderStatus.pending,
                  groupValue: orderStatusGroupValue,
                  onChanged: (value) {
                    setState(() {
                      orderStatusGroupValue = value!;
                    });
                  },
                ),
                const Text(OrderStatus.pending),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: OrderStatus.processing,
                  groupValue: orderStatusGroupValue,
                  onChanged: (value) {
                    setState(() {
                      orderStatusGroupValue = value!;
                    });
                  },
                ),
                const Text(OrderStatus.processing),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: OrderStatus.delivered,
                  groupValue: orderStatusGroupValue,
                  onChanged: (value) {
                    setState(() {
                      orderStatusGroupValue = value!;
                    });
                  },
                ),
                const Text(OrderStatus.delivered),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: OrderStatus.cancelled,
                  groupValue: orderStatusGroupValue,
                  onChanged: (value) {
                    setState(() {
                      orderStatusGroupValue = value!;
                    });
                  },
                ),
                const Text(OrderStatus.cancelled),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: OrderStatus.returned,
                  groupValue: orderStatusGroupValue,
                  onChanged: (value) {
                    setState(() {
                      orderStatusGroupValue = value!;
                    });
                  },
                ),
                const Text(OrderStatus.returned),
              ],
            ),
            ElevatedButton(
              onPressed: orderModel.orderStatus == orderStatusGroupValue ? null : (){
                EasyLoading.show(status: "Updating Status");
                orderProvider.updateOrderStatus(orderModel.orderId, orderStatusGroupValue).then((value) {
                  EasyLoading.dismiss();
                  showMsg(context, "Updated");
                }).catchError((error){
                  EasyLoading.dismiss();
                  showMsg(context, "Failed to update");
                });
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
