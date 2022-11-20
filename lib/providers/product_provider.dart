import 'dart:io';

import 'package:ecommerce_admin/db/db_helper.dart';
import 'package:ecommerce_admin/models/purchase_model.dart';
import 'package:ecommerce_admin/utils/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../models/image_model.dart';
import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<CategoryModel> categoryList = [];
  List<ProductModel> productList = [];
  List<PurchaseModel> purchaseList = [];

  Future<void> addCategory(String category) {
    final categoryModel = CategoryModel(
      categoryName: category,
    );
    return DbHelper.addCategory(categoryModel);
  }

  getAllCategories() {
    DbHelper.getAllCategories().listen((snapshot) {
      categoryList = List.generate(snapshot.docs.length,
          (index) => CategoryModel.fromMap(snapshot.docs[index].data()));
      categoryList.sort((model1, model2) =>
          model1.categoryName.compareTo(model2.categoryName));
      notifyListeners();
    });
  }

  List<CategoryModel> getCategoriesForFiltering(){
    return <CategoryModel>[
      CategoryModel(categoryName: "All"),
      ...categoryList,
    ];
  }

  getAllProducts() {
    DbHelper.getAllProducts().listen((snapshot) {
      productList = List.generate(snapshot.docs.length,
              (index) => ProductModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  getAllPurchases() {
    DbHelper.getAllPurchases().listen((snapshot) {
      purchaseList = List.generate(snapshot.docs.length,
              (index) => PurchaseModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  getAllProductsByCategory(String categoryName) {
    DbHelper.getAllProductsByCategory(categoryName).listen((snapshot) {
      productList = List.generate(snapshot.docs.length,
              (index) => ProductModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  Future<ImageModel> uploadImage(String path) async {
    final imageName = 'pro_${DateTime.now().millisecondsSinceEpoch}';
    final imageRef = FirebaseStorage.instance
        .ref()
        .child('$firebaseStorageProductImageDir/$imageName');
    final uploadTask = imageRef.putFile(File(path));
    final snapshot = await uploadTask.whenComplete(() => null);
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return ImageModel(
      title: imageName,
      imageDownloadUrl: downloadUrl,
    );
  }

  Future<void>addNewProduct(ProductModel productModel, PurchaseModel purchaseModel) {
    return DbHelper.addNewProduct(productModel, purchaseModel);
  }

  List<PurchaseModel> getPurchaseByProductId(String productId) {
    return purchaseList.where((element) => element.productId == productId).toList();
  }

  Future<void> repurchase(PurchaseModel purchaseModel, ProductModel productModel) {
    return DbHelper.repurchase(purchaseModel, productModel);
  }
}
