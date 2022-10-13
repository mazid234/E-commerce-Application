import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_007/providers/cart.dart';
import 'package:flutter_application_007/widgets/app_drawer.dart';
import 'package:flutter_application_007/widgets/shimmer_widget.dart';
import 'package:provider/provider.dart';
import '../widgets/order_item.dart';
import '../providers/orders.dart' show Orders;

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future? _ordersFuture;
  Future _obtainOrdersFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  //init ya didchangedepedencies me krenge taki jab v screen load ho data fetch ho jaye
  void initState() {
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print('building orders');
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
        body: FutureBuilder(
            future: _ordersFuture,
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                // print('first if ');

                return Consumer<Orders>(
                  builder: (context, orderData, child) => ListView.builder(
                    itemCount: orderData.order.length,
                    itemBuilder: (context, index) => Column(children: const [
                      SizedBox(
                        height: 4,
                      ),
                      Card(
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          title:
                              ShimmerWidget.rectangular(width: 10, height: 15),
                          horizontalTitleGap: 10,
                          subtitle:
                              ShimmerWidget.rectangular(width: 400, height: 10),
                        ),
                      ),
                    ]),
                  ),
                );
              } else {
                if (dataSnapshot.error != null) {
                  // print('first else ');

                  //Do error handling here
                  return Center(
                    child: Text('An occured errored!'),
                  );
                } else {
                  print('Second else ');

                  return Consumer<Orders>(
                    builder: (context, orderData, child) =>
                        // SizedBox(
                        //   height: 60,
                        // ),
                        ListView.builder(
                            itemCount: orderData.order.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => OrderItem(
                                  orderData.order[index],
                                )),
                  );
                }
              }
            }));
  }
}
