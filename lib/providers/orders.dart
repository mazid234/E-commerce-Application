import 'package:flutter/cupertino.dart';
import 'package:flutter_application_007/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _order = [];

  List<OrderItem> get order {
    return [..._order];
    // as it will return a copy of address where order are stored, wecant edit orders outside this class
  }

// add all the content of the cart into one order
  void addOrder(List<CartItem> cartProducts, double total) {
    _order.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            amount: total,
            products: cartProducts,
            dateTime: DateTime.now()));
    notifyListeners();
  }
}
