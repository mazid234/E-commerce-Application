import 'package:flutter/material.dart';
import 'package:flutter_application_007/constants/constants.dart';
import 'package:flutter_application_007/providers/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem(
      {required this.id,
      required this.productId,
      required this.price,
      required this.quantity,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      direction: DismissDirection.endToStart,
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirm"),
              content: const Text("Are you sure you wish to delete this item?"),
              actions: <Widget>[
                TextButton(
                  // style: ButtonStyle(
                  //     backgroundColor:
                  //         MaterialStateProperty.all(Colors.transparent)),
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text(
                    "CANCEL",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text(
                      "DELETE",
                      style: TextStyle(color: Colors.red),
                    )),
              ],
            );
          },
        );
      },
      key: ValueKey(id),
      background: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          padding: EdgeInsets.only(right: 20),
          alignment: Alignment.centerRight,
          color: Theme.of(context).colorScheme.error,
          child: Icon(
            Icons.delete,
            color: colorWhite,
            size: 40,
          )),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              radius: 20,
              foregroundColor: Theme.of(context).primaryColorDark,
              backgroundColor: colorPrimarylight,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: FittedBox(
                  child: Text(
                    "\$$price",
                    style: TextStyle(color: colorBlack),
                  ),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text("Total: \$${price * quantity}"),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
