import 'package:ecommerce_admin/core/components/custom_appbar.dart';
import 'package:ecommerce_admin/core/components/custom_button.dart';
import 'package:ecommerce_admin/core/constants/dimensions.dart';
import 'package:ecommerce_admin/core/extensions/context.dart';
import 'package:ecommerce_admin/core/extensions/style.dart';
import 'package:ecommerce_admin/view/order/models/order_model.dart';
import 'package:ecommerce_admin/view/order/provider/order_provider.dart';
import 'package:ecommerce_admin/core/constants/constants.dart';
import 'package:ecommerce_admin/core/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
      appBar: CustomAppbar(title: 'Order ID: $orderId'),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          buildHeader('Product Info'),
          buildProductInfoSection(),
          buildHeader('Customer Info'),
          buildCustomerInfoSection(),
          buildHeader('Delivery Address'),
          buildDeliveryAddressSection(),
          buildHeader('Order Summary'),
          buildOrderSummarySection(),
          buildHeader('Order Status'),
          buildOrderStatusSection(),

          const SizedBox(height: Dimensions.paddingExtraSmall,),
          CustomButton(
            textColor: orderModel.orderStatus == orderStatusGroupValue ? context.theme.textTheme.bodyLarge!.color : context.theme.cardColor,
            text: 'Update',
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
          ),

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

  Widget buildCustomerInfoSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            ListTile(
              title: const Text('Name'),
              trailing: Text(orderModel.contactInfo.name ?? ''),
            ),
            ListTile(
              onTap: () {
                try {
                  launchUrl(
                    Uri(
                      scheme: 'tel',
                      path: orderModel.contactInfo.phoneNumber ?? '',
                    ),
                  );
                } catch (e) {
                  showMsg(context, 'Failed to open phone app',);
                }

              },
              title: const Text('Phone'),
              trailing: Text(orderModel.contactInfo.phoneNumber ?? '', style: const TextStyle(decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDeliveryAddressSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            ListTile(
              title: const Text('Address'),
              trailing: Text(orderModel.deliveryAddress.address ?? ''),
            ),
            ListTile(
              title: const Text('City'),
              trailing: Text(orderModel.deliveryAddress.city ?? ''),
            ),
            ListTile(
              title: const Text('Zip Code'),
              trailing: Text(orderModel.deliveryAddress.zipcode ?? ''),
            ),
          ],
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
          ],
        ),
      ),
    );
  }
}
