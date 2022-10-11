import 'package:flutter/material.dart';
// import 'package:flutter_application_007/providers/product.dart';
import 'package:flutter_application_007/providers/products.dart';
import 'package:flutter_application_007/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    // print('ccccccccc :${showFavs.toString()}');
    final productsData = Provider.of<Products>(context); //products instance
    final products = showFavs
        ? productsData.favoriteItems
        : productsData
            .items; // list of product instance // agr showfavs true to fav item nahi to all

    return GridView.builder(
        itemCount: products.length,
        padding: const EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
              value: products[
                  index], // providing single product  //.value kra hai kyuki products already initiat ho chucka h
              child: ProductItem(
                  // products[index].id,
                  // products[index].title,
                  // products[index].imageUrl,
                  ),
            ));
  }
}
