import 'package:flutter/foundation.dart';

class CartTotalMoney extends ChangeNotifier {
  double _counter = 0;
  double get count => _counter;

  setMoney(double x) {
    _counter = 0;
    _counter = _counter + x;
    print(_counter);
    notifyListeners();
  }

  clearCount() {
    _counter = 0;
    notifyListeners();
  }

  Future<void> displayCounter() async {
    print('yes');
    print(_counter);
    await Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }
}
