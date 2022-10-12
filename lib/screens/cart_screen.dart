import 'package:flutter/material.dart';
import 'package:flutter_application_007/constants/constants.dart';
import 'package:flutter_application_007/providers/cart.dart' show Cart;
import 'package:flutter_application_007/providers/orders.dart';
import 'package:flutter_application_007/widgets/cart_item.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class CartScreen extends StatelessWidget {
  // static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Cart Items"),
        ),
        body: Column(children: [
          // SizedBox(
          //   height: 60,
          // ),
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Amount",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      "\$${cart.totalAmount?.toStringAsFixed(2)}",
                    ),
                    backgroundColor: colorPrimarylight,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  //when we point onpressed to null it automatically disable
                  OrderButton(
                    cart: cart,
                  )
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);
  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CircularStepProgressIndicator(
            circularDirection: CircularDirection.clockwise,
            totalSteps: 100,
            currentStep: 50,
            // startingAngle: 0,
            stepSize: 5,
            selectedColor: Colors.greenAccent,
            unselectedColor: Colors.grey[200],
            padding: 0,
            width: 30,
            height: 30,
            selectedStepSize: 5,
            roundedCap: (_, __) => true,
          )
        : ElevatedButton(
            onPressed: (widget.cart.totalAmount! <= 0 || _isLoading)
                ? null
                : () async {
                    setState(() {
                      _isLoading = true;
                    });
                    await Provider.of<Orders>(context, listen: false).addOrder(
                        widget.cart.items.values.toList(),
                        widget.cart.totalAmount ?? 0);
                    setState(() {
                      _isLoading = false;
                    });
                    widget.cart.clear();
                  },
            child: const Text('Place Order'));
  }
}
