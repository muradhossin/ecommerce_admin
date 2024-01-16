import 'package:ecommerce_admin/core/components/custom_appbar.dart';
import 'package:ecommerce_admin/view/category/provider/category_provider.dart';
import 'package:ecommerce_admin/view/product/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/widget_functions.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);
  static const String routeName = '/categorypage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Categories'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSingleTextFieldInputDialog(
              context: context,
              title: "Category",
              positiveButton: "ADD",
              onSubmit: (value) {
                Provider.of<CategoryProvider>(context, listen: false)
                    .addCategory(value);
              });
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.categoryList.length,
          itemBuilder: (context, index){
            final catModel = provider.categoryList[index];
            return ListTile(
              title: Text(catModel.categoryName),
              trailing: Text('Total: ${catModel.productCount}'),
            );
          },
        ),
      ),
    );
  }
}
