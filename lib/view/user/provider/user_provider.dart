import 'package:ecommerce_admin/view/user/repository/user_repository.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  List<UserModel> userList = [];

  Future<bool> doesUserExist(String uid) => UserRepository.doesUserExist(uid);

  getAllUser() {
    UserRepository.getAllUsers().listen((snapshot) {
      userList = List.generate(snapshot.docs.length,
          (index) => UserModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }
}
