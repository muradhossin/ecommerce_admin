import 'package:ecommerce_admin/core/components/custom_button.dart';
import 'package:ecommerce_admin/core/components/custom_text_form_field.dart';
import 'package:ecommerce_admin/core/constants/dimensions.dart';
import 'package:ecommerce_admin/core/extensions/style.dart';
import 'package:ecommerce_admin/view/category/models/category_model.dart';
import 'package:ecommerce_admin/view/category/provider/category_provider.dart';
import 'package:ecommerce_admin/view/product/models/product_model.dart';
import 'package:ecommerce_admin/view/product/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductEditDialog extends StatefulWidget {
  final ProductModel productModel;
  const ProductEditDialog({super.key, required this.productModel});

  @override
  State<ProductEditDialog> createState() => _ProductEditDialogState();
}

class _ProductEditDialogState extends State<ProductEditDialog> {
  CategoryModel? categoryModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController salePriceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController shortDescriptionController = TextEditingController();
  TextEditingController longDescriptionController = TextEditingController();


  void initState() {
    super.initState();
    // categoryModel = widget.productModel.category;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingMedium),
        child: Column(mainAxisSize: MainAxisSize.min, children: [

          Text('Edit Product', style: TextStyle().semiBold.copyWith(fontSize: Dimensions.fontSizeSmall),),
          const SizedBox(height: Dimensions.paddingMedium),

          CustomTextFormField(
            controller: nameController,
            hintText: 'Product Name',
            labelText: 'Product Name',
            onChanged: (value) {

            },
          ),
          const SizedBox(height: Dimensions.paddingSmall),

          Consumer<CategoryProvider>(
            builder: (context, categoryProvider, child) =>
            DropdownButtonFormField<CategoryModel>(
              decoration: InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              isExpanded: true,
              hint: const Text('Category'),
              value: categoryModel,
              validator: (value) {
                if (value == null) {
                  return 'Please select a category';
                }
                return null;
              },
              items: categoryProvider.getAllCategoriesList
                  .map((catModel) => DropdownMenuItem(
                key: ValueKey(catModel.categoryId),
                  value: catModel,
                  child: Text(
                    catModel.categoryName,
                  )))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  categoryModel = value;
                });
              },
            ),
          ),
          const SizedBox(height: Dimensions.paddingSmall),

          CustomTextFormField(
            controller: salePriceController,
            hintText: 'Sale Price',
            labelText: 'Sale Price',
            onChanged: (value) {

            },
          ),
          const SizedBox(height: Dimensions.paddingSmall),

          CustomTextFormField(
            controller: discountController,
            hintText: 'Price Discount (%)',
            labelText: 'Price Discount (%)',
            onChanged: (value) {

            },
          ),
          const SizedBox(height: Dimensions.paddingSmall),

          CustomTextFormField(
            controller: shortDescriptionController,
            hintText: 'Short Description',
            labelText: 'Short Description',
            onChanged: (value) {

            },
          ),
          const SizedBox(height: Dimensions.paddingSmall),

          CustomTextFormField(
            controller: longDescriptionController,
            hintText: 'Long Description',
            labelText: 'Long Description',
            onChanged: (value) {

            },
          ),

          const SizedBox(height: Dimensions.paddingSmall),

          CustomButton(
            width: double.infinity,
            text: 'Update',
            onPressed: () {

            },
          ),

          const SizedBox(height: Dimensions.paddingSmall),


        ]),
      ),
    ));
  }
}
