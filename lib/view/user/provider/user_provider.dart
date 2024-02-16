import 'package:ecommerce_admin/view/user/repository/user_repository.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/helper_functions.dart';
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

  void sortUserList(){
    userList.sort((a, b) => b.userCreationTime!.compareTo(a.userCreationTime!));
  }

  Future<UserModel> userFindById(String id) {
    debugPrint('-----------------------> userId: $id');
    return UserRepository.getUserById(id);
  }

  num getTodaysJoinUser(){
    num total = 0;
    for(final user in userList){
      DateTime date = getDateTimeFromTimeStampString(user.userCreationTime!);
      if(date.day == DateTime.now().day && date.month == DateTime.now().month && date.year == DateTime.now().year){
        total += 1;
      }
    }
    return total;
  }

  num getTotalsUser(){
    return userList.length;
  }
}
