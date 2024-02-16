
import 'package:ecommerce_admin/core/constants/app_constants.dart';
import 'package:ecommerce_admin/core/constants/constants.dart';
import 'package:ecommerce_admin/view/order/models/order_constant_model.dart';
import 'package:ecommerce_admin/view/order/repository/order_repository.dart';
import 'package:flutter/material.dart';

import '../models/order_model.dart';

class OrderProvider extends ChangeNotifier{
  OrderConstantModel orderConstantModel = OrderConstantModel();
  List<OrderModel> orderList = [];

  OrderModel getOrderById(String id) {
    return orderList.firstWhere((element) => element.orderId == id);
  }

  getOrders() {
    OrderRepository.getAllOrders().listen((snapshot) {
      orderList = List.generate(snapshot.docs.length, (index) => OrderModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  void sortOrderList(){
    orderList.sort((a, b) => b.orderDate.timestamp.compareTo(a.orderDate.timestamp));
  }


  getOrderConstants (){
    OrderRepository.getOrderConstants().listen((snapshot) {
      if(snapshot.exists){
        orderConstantModel = OrderConstantModel.fromMap(snapshot.data()!);
        notifyListeners();
      }
    });
  }

  Future<void> updateOrderConstants(OrderConstantModel model){
    return OrderRepository.updateOrderConstants(model);
  }
  Future<void> updateOrderStatus(String orderId, String status){
    return OrderRepository.updateOrderStatus(orderId, status);
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

  num getTotalItemsSold(){
    num total = 0;
    for(final order in orderList){
      for(final model in order.productDetails){
        total += model.quantity;
      }
    }
    return total;
  }

  num getTodaysDelivery(){
    num total = 0;
    for(final order in orderList){
      if(order.orderDate.day == DateTime.now().day && order.orderDate.month == DateTime.now().month && order.orderDate.year == DateTime.now().year){
        if(order.orderStatus == OrderStatus.delivered){
          total += 1;
        }
      }
    }
    return total;
  }

  num getTodaysCancelled(){
    num total = 0;
    for(final order in orderList){
      if(order.orderDate.day == DateTime.now().day && order.orderDate.month == DateTime.now().month && order.orderDate.year == DateTime.now().year){
        if(order.orderStatus == OrderStatus.cancelled){
          total += 1;
        }
      }
    }
    return total;
  }

  num getTotalDelivered(){
    num total = 0;
    for(final order in orderList){
      if(order.orderStatus == OrderStatus.delivered){
        total += 1;
      }
    }
    return total;
  }

  num getTotalCancelled(){
    num total = 0;
    for(final order in orderList){
      if(order.orderStatus == OrderStatus.cancelled){
        total += 1;
      }
    }
    return total;
  }








}