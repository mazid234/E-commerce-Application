import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_application_007/providers/cart.dart';
import 'package:http/http.dart' as http;

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

  Future<void> fetchAndSetOrders() async {
    final url = Uri.https(
        'flutter-update-1eb33-default-rtdb.firebaseio.com', '/orders.json');
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
    if (extractedData == {}) {
      return;
    }
    //agey ka code nhi chlega
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(
            orderData['dateTime'],
          ),
          products: (orderData['products'] as List<dynamic>).map((item) {
            return CartItem(
              id: item['id'],
              title: item['title'],
              price: item['price'],
              quantity: item['quantity'],
            );
          }
              // print("success");
              ).toList(),
        ),
      );
    });
    _order = loadedOrders.reversed.toList();
    notifyListeners();
  }

// add all the content of the cart into one order
  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.https(
        'flutter-update-1eb33-default-rtdb.firebaseio.com', '/orders.json');
    final timestamp =
        DateTime.now(); //so we have single timestamp when the product is called
    final response = await http.post(url,
        body: jsonEncode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartProducts
              .map((cartProd) => {
                    'id': cartProd.id,
                    'title': cartProd.title,
                    'quantity': cartProd.quantity,
                    'price': cartProd.price,
                  })
              .toList(),
        }));
    _order.insert(
        0,
        OrderItem(
            id: jsonDecode(response.body)['name'],
            amount: total,
            products: cartProducts,
            dateTime: DateTime.now()));
    notifyListeners();
  }
}
