import 'dart:developer';
import 'package:ecommerce_admin/view/auth/repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';

class ThemeProvider with ChangeNotifier {
  bool _isLightTheme = true;

  ThemeProvider(this._isLightTheme);

  bool get isLightTheme => _isLightTheme;

  void toggleTheme() {
    _isLightTheme = !isLightTheme;
    setTheme(isLightTheme);
    notifyListeners();
  }

  Future<void> setTheme(bool isLightTheme) async {
    AuthRepository.setTheme(isLightTheme);
  }

  Future<bool> getTheme() async{
    _isLightTheme = await AuthRepository.getTheme();
    log('-----------------> THEME: $isLightTheme');
    return isLightTheme;

  }

}
