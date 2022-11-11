import 'package:ecommerce_admin/db/db_helper.dart';
import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<CategoryModel> categoryList = [];
  List<ProductModel> productList = [];

  Future<void> addCategory(String category) {
    final categoryModel = CategoryModel(
      categoryName: category,
    );
    return DbHelper.addCategory(categoryModel);
  }
}
