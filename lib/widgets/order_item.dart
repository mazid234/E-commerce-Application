import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_007/providers/orders.dart' as ord;
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;
  OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          title: Text('Total:  \$${widget.order.amount.toStringAsFixed(2)}'),
          subtitle: (Text(
            DateFormat('dd-MM-yyyy hh:mm').format(widget.order.dateTime),
          )),
          trailing: IconButton(
            onPressed: () {
              setState(() {
                _expanded = !_expanded;
              });
              print(_expanded);
            },
            icon: _expanded ? Icon(Icons.expand_less) : Icon(Icons.expand_more),
          ),
        ),
        if (_expanded)
          Container(
            padding: EdgeInsets.all(10),
            height: min(widget.order.products.length * 20.0 + 30, 150),
            child: ListView(
                children: widget.order.products
                    .map(
                      (prod) => Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                prod.title,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${prod.quantity}x \$${prod.price}',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 6,
                          )
                        ],
                      ),
                    )
                    .toList()),
          ),
      ]),
    );
  }
}
