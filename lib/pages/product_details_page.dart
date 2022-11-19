import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_admin/models/product_model.dart';
import 'package:ecommerce_admin/pages/product_repurchase_page.dart';
import 'package:ecommerce_admin/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

class ProductDetailsPage extends StatelessWidget {
  ProductDetailsPage({Key? key}) : super(key: key);
  static const String routeName = '/productdetailspage';
  late ProductModel productModel;
  late ProductProvider productProvider;

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    productModel = ModalRoute.of(context)!.settings.arguments as ProductModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(productModel.productName),
      ),
      body: ListView(
        children: [
          CachedNetworkImage(
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
            imageUrl: productModel.thumbnailImageModel.imageDownloadUrl,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, ulr, error) => const Icon(Icons.error),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () => Navigator.pushNamed(context, ProductRepurchasePage.routeName, arguments: productModel),
                child: const Text('Re-Purchase'),
              ),
              OutlinedButton(
                onPressed: () {
                  _showPurchaseHistory(context, productModel);
                },
                child: const Text('Purchase history'),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _showPurchaseHistory(BuildContext context, ProductModel productModel) {
    showModalBottomSheet(

      context: context,
      builder: (context) => FutureBuilder(
        future: productProvider.getPurchaseByProductId(productModel.productId!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final purchaseList = snapshot.data;
            return ListView.builder(
              itemCount: purchaseList!.length,
              itemBuilder: (context, index){
                final purchaseModel = purchaseList[index];
                return ListTile(
                  title: Text(getFormattedDate(purchaseModel.dateModel.timestamp.toDate())),
                  subtitle: Text('BDT: ${purchaseModel.purchasePrice}'),
                  trailing: Text('Quantity: ${purchaseModel.purchaseQuantity}'),
                );
              },
            );
          }
          if(snapshot.hasError){
            return const Center(child: Text('Failed to fetch data'),);
          }
          return const Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}
