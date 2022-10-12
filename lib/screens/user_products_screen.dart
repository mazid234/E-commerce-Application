import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_007/providers/products.dart';
import 'package:flutter_application_007/screens/edit_product_screen.dart';
import 'package:flutter_application_007/widgets/app_drawer.dart';
import 'package:flutter_application_007/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  // const UserProductsScreen({Key? key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  'EditProductScreen',
                );
              },
              icon: Icon(Icons.add))
        ],
        title: Text('Your Products'),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Consumer<Products>(builder: (context, products, child) {
          return ListView.builder(
            itemCount: products.items.length,
            itemBuilder: (context, index) => Column(
              children: [
                Card(
                  margin:
                      EdgeInsets.only(bottom: 5, top: 10, left: 5, right: 5),
                  child: UserProductItem(
                      id: products.items[index].id ?? '',
                      title: products.items[index].title,
                      imageUrl: products.items[index].imageUrl),
                ),
                // Divider(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
