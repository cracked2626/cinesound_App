import 'package:flutter/foundation.dart';
import 'package:shop_app/Config/config.dart';

class CartItemCounter extends ChangeNotifier {
  int _counter = EcommerceApp.sharedPreferences
      .getStringList(EcommerceApp.userCartList)
      .length;
  int get count => _counter;

  Future<void> displayCounter() async {
    print('yes');
    _counter = EcommerceApp.sharedPreferences
        .getStringList(EcommerceApp.userCartList)
        .length;
    print(_counter);
    await Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }
}
