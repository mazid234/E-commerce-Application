import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem>? _items =
      {}; //we can simply have list of cart bus as we want to relate every cart to product it we will map it as key value pair
  //where key is productId and value is cart item
  Map<String, CartItem> get items {
    return {...?_items}; // it will return  copy of  key value map
  }

  double? get totalAmount {
    var total = 0.0;
    //runs this fun for every item in our map
    _items?.forEach((key, CartItem) {
      total += CartItem.price * CartItem.quantity;
    });
    return total;
  }

  int? get itemCount {
    return _items?.length;
  }

  void addItem(String productId, double price, String title) {
    // add that item to our cart
    if ((_items ?? {}).containsKey(productId)) {
      // first we need to check if do have that item than we only need to increase the quantity
      //...  change the quantity
      _items?.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity + 1,
              ));
    } else {
      // add new entry
      _items?.putIfAbsent(
          productId,
          () => CartItem(
                id: DateTime.now().toString(),
                title: title,
                price: price,
                quantity: 1,
              ));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items?.remove(productId);
    notifyListeners();
  }

//when we call this item we are checking it there is a item in cart if not it will simply return, and if there is any we will update and reduce the quantity by 1 and else means quatity is equal to one the will remove entire product
  void removeSingleItem(String productId) {
    if (!_items!.containsKey(productId)) {
      return;
    }
    if ((_items![productId]?.quantity ?? 0) > 1) {
      _items?.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity - 1));
    } else {
      _items?.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
