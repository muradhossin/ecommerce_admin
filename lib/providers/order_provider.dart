import 'package:ecommerce_admin/db/db_helper.dart';
import 'package:ecommerce_admin/models/order_constant_model.dart';
import 'package:flutter/material.dart';

import '../auth/auth_service.dart';
import '../models/order_model.dart';

class OrderProvider extends ChangeNotifier{
  OrderConstantModel orderConstantModel = OrderConstantModel();
  List<OrderModel> orderList = [];

  getOrders() {
    DbHelper.getAllOrders().listen((snapshot) {
      orderList = List.generate(snapshot.docs.length, (index) => OrderModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }


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