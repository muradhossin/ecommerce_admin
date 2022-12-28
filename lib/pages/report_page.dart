import 'package:ecommerce_admin/providers/order_provider.dart';
import 'package:ecommerce_admin/providers/product_provider.dart';
import 'package:ecommerce_admin/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);
  static const String routeName = '/reportpage';

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late OrderProvider orderProvider;
  late ProductProvider productProvider;
  late UserProvider userProvider;

  @override
  void didChangeDependencies() {
    orderProvider = Provider.of<OrderProvider>(context);
    productProvider = Provider.of<ProductProvider>(context);
    userProvider = Provider.of<UserProvider>(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Orders',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          const Divider(
            color: Colors.black,
            height: 3,
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  headerSection('Today'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Total Orders',
                            style: TextStyle(fontSize: 14),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              orderProvider
                                  .getOrderByDate(DateTime.now().day,
                                      DateTime.now().month, DateTime.now().year)
                                  .toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'Items Sold',
                            style: TextStyle(fontSize: 14),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              orderProvider
                                  .getTotalItemsSoldByDate(DateTime.now().day,
                                  DateTime.now().month, DateTime.now().year)
                                  .toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  headerSection('Last 7 Days'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Total Orders',
                            style: TextStyle(fontSize: 14),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              orderProvider
                                  .getOrderByDate(DateTime.now().day,
                                  DateTime.now().month, DateTime.now().year)
                                  .toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'Items Sold',
                            style: TextStyle(fontSize: 14),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              orderProvider
                                  .getTotalItemsSoldByDate(DateTime.now().day,
                                  DateTime.now().month, DateTime.now().year)
                                  .toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column headerSection(String title) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        const Divider(
          color: Colors.black,
          height: 3,
        ),
      ],
    );
  }
}
