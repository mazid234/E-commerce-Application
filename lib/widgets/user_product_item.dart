import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_007/providers/products.dart';
import 'package:flutter_application_007/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(
      {required this.id, required this.title, required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    // print('sbdjkasjkd:$title.toString()');
    // print('sbdjkasjkd:$imageUrl.toString()');
    return Consumer<Products>(
      builder: (context, prod, child) => ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    // Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: id);
                    Navigator.of(context)
                        .pushNamed("EditProductScreen", arguments: id);
                  },
                  icon: Icon(Icons.edit)),
              IconButton(
                onPressed: () =>
                    // prod.deleteProduct(id);

                    Alert(
                  context: context,
                  // type: AlertType.success,
                  title: "ALERT",

                  desc: "Do you really want to delete the item!.",
                  buttons: [
                    DialogButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.red, fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: (Color.fromARGB(255, 255, 255, 255)),

                      // color: Color.fromRGBO(0, 179, 134, 1.0),
                    ),
                    DialogButton(
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.red, fontSize: 20),
                      ),
                      onPressed: () {
                        prod.deleteProduct(id);

                        Navigator.pop(context);
                      },
                      color: (Color.fromARGB(255, 255, 255, 255)),

                      // gradient: LinearGradient(colors: [
                      //   Color.fromRGBO(116, 116, 191, 1.0),
                      //   Color.fromRGBO(52, 138, 199, 1.0)
                      // ]),
                    )
                  ],
                ).show(),
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
