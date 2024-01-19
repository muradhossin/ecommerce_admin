import 'package:ecommerce_admin/core/components/custom_button.dart';
import 'package:ecommerce_admin/core/components/custom_text_form_field.dart';
import 'package:ecommerce_admin/core/constants/dimensions.dart';
import 'package:ecommerce_admin/core/extensions/context.dart';
import 'package:ecommerce_admin/core/extensions/style.dart';
import 'package:ecommerce_admin/view/category/models/category_model.dart';
import 'package:ecommerce_admin/view/category/provider/category_provider.dart';
import 'package:ecommerce_admin/view/product/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductEditDialog extends StatefulWidget {
  final ProductModel productModel;
  final Function(ProductModel) onProductUpdated;
  const ProductEditDialog({super.key, required this.productModel, required this.onProductUpdated});

  @override
  State<ProductEditDialog> createState() => _ProductEditDialogState();
}

class _ProductEditDialogState extends State<ProductEditDialog> {
  TextEditingController nameController = TextEditingController();
  TextEditingController salePriceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController shortDescriptionController = TextEditingController();
  TextEditingController longDescriptionController = TextEditingController();


  @override
  void initState() {
    super.initState();
    nameController.text = widget.productModel.productName;
    salePriceController.text = widget.productModel.salePrice.toString();
    discountController.text = widget.productModel.productDiscount.toString();
    shortDescriptionController.text = widget.productModel.shortDescription ?? '';
    longDescriptionController.text = widget.productModel.longDescription ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(child: Column(mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            SingleChildScrollView(
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
                      widget.productModel.productName = value;

                    },
                  ),
                  const SizedBox(height: Dimensions.paddingSmall),

                  Consumer<CategoryProvider>(
                    builder: (context, categoryProvider, child) =>
                    DropdownButtonFormField<CategoryModel>(
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(),
                      ),
                      isExpanded: true,
                      hint: const Text('Category'),
                      value: widget.productModel.category,
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
                          widget.productModel.category.categoryName = value?.categoryName ?? '';
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSmall),

                  CustomTextFormField(
                    controller: salePriceController,
                    hintText: 'Sale Price',
                    labelText: 'Sale Price',
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      widget.productModel.salePrice = num.tryParse(value.toString()) ?? 0;
                    },
                  ),
                  const SizedBox(height: Dimensions.paddingSmall),

                  CustomTextFormField(
                    controller: discountController,
                    hintText: 'Price Discount (%)',
                    labelText: 'Price Discount (%)',
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      widget.productModel.productDiscount = num.tryParse(value.toString()) ?? 0;
                    },
                  ),
                  const SizedBox(height: Dimensions.paddingSmall),

                  CustomTextFormField(
                    controller: shortDescriptionController,
                    hintText: 'Short Description',
                    labelText: 'Short Description',
                    onChanged: (value) {
                      widget.productModel.shortDescription = value;
                    },
                  ),
                  const SizedBox(height: Dimensions.paddingSmall),

                  CustomTextFormField(
                    controller: longDescriptionController,
                    hintText: 'Long Description',
                    labelText: 'Long Description',
                    onChanged: (value) {
                      widget.productModel.longDescription = value;
                    },
                  ),

                  const SizedBox(height: Dimensions.paddingSmall),

                  CustomButton(
                    width: double.infinity,
                    text: 'Update',
                    onPressed: () {
                      widget.onProductUpdated(widget.productModel);
                      Navigator.pop(context);
                    },
                  ),

                  const SizedBox(height: Dimensions.paddingSmall),


                ]),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close, color: context.theme.disabledColor),
              ),
            ),
          ],
        ),
      ],
    ));
  }

  @override
  void dispose() {
    nameController.dispose();
    salePriceController.dispose();
    discountController.dispose();
    shortDescriptionController.dispose();
    longDescriptionController.dispose();

    super.dispose();
  }
}
