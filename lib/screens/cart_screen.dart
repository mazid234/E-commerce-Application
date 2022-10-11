import 'package:flutter/material.dart';
import 'package:flutter_application_007/constants/constants.dart';
import 'package:flutter_application_007/providers/cart.dart' show Cart;
import 'package:flutter_application_007/providers/orders.dart';
import 'package:flutter_application_007/widgets/cart_item.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  // static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) => Scaffold(
        appBar: AppBar(
          title: Text("Cart Items"),
        ),
        body: Column(children: [
          // SizedBox(
          //   height: 60,
          // ),
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Amount",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      "\$${cart.totalAmount?.toStringAsFixed(2)}",
                    ),
                    backgroundColor: colorPrimarylight,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false).addOrder(
                            cart.items.values.toList(), cart.totalAmount ?? 0);
                        cart.clear();
                      },
                      child: Text('Place Order'))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return CartItem(
                  id: cart.items.values.toList()[index].id,
                  productId: cart.items.keys.toList()[index],
                  title: cart.items.values.toList()[index].title,
                  price: cart.items.values.toList()[index].price,
                  quantity: cart.items.values.toList()[index].quantity,
                );
              },
              itemCount: cart.itemCount,
            ),
          ),
        ]),
      ),
    );
  }
}
