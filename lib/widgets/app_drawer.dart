import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_007/constants/constants.dart';
import 'package:flutter_application_007/screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text(
              'Hi! Guest',
              style: TextStyle(color: colorPrimary),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: colorWhite,
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.shop),
              title: Text('Shop'),
              onTap: () {
                Navigator.of(context)
                    .pushNamed('/dashboard'); // back to route homepage
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.payment),
              title: Text('Your Orders'),
              onTap: () {
                Navigator.of(context)
                    .pushNamed('/orderscreen'); // back to route homepage
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.edit),
              title: Text('Manage Products'),
              onTap: () {
                Navigator.of(context)
                    .pushNamed('/userproducts'); // back to route homepage
              }),
        ],
      ),
    );
  }
}
