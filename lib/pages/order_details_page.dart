import 'package:flutter/material.dart';

class OrderDetailsPage extends StatefulWidget {
  static const String routeName = '/order_details';
  const OrderDetailsPage({Key? key,}) : super(key: key);

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {

  @override
  Widget build(BuildContext context) {
    final orderId = ModalRoute.of(context)!.settings!.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(orderId),
      ),
    );
  }
}
