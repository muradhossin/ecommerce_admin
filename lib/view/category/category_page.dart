import 'package:ecommerce_admin/core/components/custom_appbar.dart';
import 'package:ecommerce_admin/core/constants/dimensions.dart';
import 'package:ecommerce_admin/core/extensions/context.dart';
import 'package:ecommerce_admin/view/category/provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../core/utils/widget_functions.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});
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
          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingExtraSmall),
          itemCount: provider.categoryList.length,
          itemBuilder: (context, index){
            final catModel = provider.categoryList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingExtraSmall),
              child: ListTile(
                tileColor: context.theme.primaryColor.withOpacity(.2),
                title: Text(catModel.categoryName),
                subtitle: Text('Total: ${catModel.productCount}'),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [

                  IconButton(
                    onPressed: (){
                      showSingleTextFieldInputDialog(
                        textFieldsInitialValue: catModel.categoryName,
                          context: context,
                          title: "Update Category",
                          positiveButton: "UPDATE",
                          onSubmit: (value) async {
                            EasyLoading.show(status: 'Updating...');
                            await Provider.of<CategoryProvider>(context, listen: false).updateCategory(catModel.categoryId, value);
                            EasyLoading.dismiss();
                          });
                    },
                    icon: const Icon(Icons.edit),
                  ),

                  IconButton(
                    onPressed: (){
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete Category'),
                          content: const Text('Are you sure you want to delete this category?'),
                          actions: [
                            TextButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async{
                                EasyLoading.show(status: 'Deleting...');
                                await Provider.of<CategoryProvider>(context, listen: false).deleteCategory(catModel.categoryId);
                                Navigator.pop(context);
                                EasyLoading.dismiss();
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.delete),
                  ),

                ],),

                onTap: (){
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
