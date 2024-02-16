import 'package:ecommerce_admin/core/components/custom_appbar.dart';
import 'package:ecommerce_admin/core/constants/dimensions.dart';
import 'package:ecommerce_admin/view/order/provider/order_provider.dart';
import 'package:ecommerce_admin/view/product/provider/product_provider.dart';
import 'package:ecommerce_admin/view/user/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});
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
      appBar: const CustomAppbar(title: 'Report'),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [

          // order section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Order Report',
              style: Theme.of(context).textTheme.titleLarge,
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
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'Delivered',
                            style: TextStyle(fontSize: 14),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              orderProvider
                                  .getTodaysDelivery().toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),

                      Column(
                        children: [
                          const Text(
                            'Cancelled',
                            style: TextStyle(fontSize: 14),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              orderProvider
                                  .getTodaysCancelled()
                                  .toString(),
                              style: const TextStyle(fontSize: 20),
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
                  headerSection('All time'),
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
                                  .orderList.length
                                  .toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'Delivered',
                            style: TextStyle(fontSize: 14),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              orderProvider
                                  .getTotalDelivered()
                                  .toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),

                      Column(
                        children: [
                          const Text(
                            'Cancelled',
                            style: TextStyle(fontSize: 14),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              orderProvider
                                  .getTotalCancelled()
                                  .toString(),
                              style: const TextStyle(fontSize: 20),
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

          const SizedBox(height: Dimensions.paddingSmall),
          // user section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Customer Report',
              style: Theme.of(context).textTheme.titleLarge,
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
                            'New Customers',
                            style: TextStyle(fontSize: 14),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              userProvider
                                  .getTodaysJoinUser()
                                  .toString(),
                              style: const TextStyle(fontSize: 20),
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
                  headerSection('All time'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Total Customers',
                            style: TextStyle(fontSize: 14),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              userProvider
                                  .getTotalsUser()
                                  .toString(),
                              style: const TextStyle(fontSize: 20),
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
            style: Theme.of(context).textTheme.titleLarge,
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
