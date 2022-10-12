import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_007/providers/cart.dart';
import 'package:flutter_application_007/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../widgets/order_item.dart';
import '../providers/orders.dart' show Orders;

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;
  @override
  //init ya didchangedepedencies me krenge taki jab v screen load ho data fetch ho jaye
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
      setState(() {
        _isLoading = false;
      });
    }); //this will queued to the end
    super.initState();
  }

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
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
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
