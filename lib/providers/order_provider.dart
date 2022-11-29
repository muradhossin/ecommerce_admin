import 'package:ecommerce_admin/db/db_helper.dart';
import 'package:ecommerce_admin/models/order_constant_model.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier{
  OrderConstantModel orderConstantModel = OrderConstantModel();

  getOrderConstants (){
    DbHelper.getOrderConstants().listen((snapshot) {
      if(snapshot.exists){
        orderConstantModel = OrderConstantModel.fromMap(snapshot.data()!);
        notifyListeners();
      }
    });
  }

  Future<void> updateOrderConstants(OrderConstantModel model){
    return DbHelper.updateOrderConstants(model);
  }
}