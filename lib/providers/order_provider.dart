import 'package:ecommerce_admin/db/db_helper.dart';
import 'package:ecommerce_admin/models/order_constant_model.dart';
import 'package:flutter/material.dart';

import '../auth/auth_service.dart';
import '../models/order_model.dart';

class OrderProvider extends ChangeNotifier{
  OrderConstantModel orderConstantModel = OrderConstantModel();
  List<OrderModel> orderList = [];

  OrderModel getOrderById(String id) {
    return orderList.firstWhere((element) => element.orderId == id);
  }

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
  Future<void> updateOrderStatus(String orderId, String status){
    return DbHelper.updateOrderStatus(orderId, status);
  }

  num getOrderByDate(num day, num month, num year){
    num total = 0;
    for(final order in orderList){
      if(order.orderDate.day == day && order.orderDate.month == month && order.orderDate.year == year){
        total += 1;
      }
    }
    return total;
  }

  num getTotalItemsSoldByDate(num day, num month, num year){
    num total = 0;
    for(final order in orderList){
      if(order.orderDate.day == day && order.orderDate.month == month && order.orderDate.year == year){
        for(final model in order.productDetails){
          total += model.quantity;
        }
      }
    }
    return total;
  }


}