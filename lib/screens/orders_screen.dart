import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_007/providers/cart.dart';
import 'package:flutter_application_007/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../widgets/order_item.dart';
import '../providers/orders.dart' show Orders;

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, '/dashboard');
            },
          ),
          title: Text('Your Orders'),
          // leading: InkWell(
          //     onTap: () {
          //       Navigator.pop(context);
          //     },
          //     child: Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(
              //   height: 60,
              // ),
              Consumer<Orders>(
                builder: (context, orderData, child) {
                  return ListView.builder(
                      itemCount: orderData.order.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => OrderItem(
                            orderData.order[index],
                          ));
                },
              ),
            ],
          ),
        ));
  }
}
