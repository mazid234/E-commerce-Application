import 'package:flutter/material.dart';
import 'package:flutter_application_007/providers/products.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)
        ?.settings
        .arguments; // this will give us the id passed
    final loadedProducts = Provider.of<Products>(context,
            listen:
                false) // listen: false this will not rebuid the widget if there is any change
        .findById(productId.toString());
    return Scaffold(
      appBar: AppBar(title: Text(loadedProducts.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              width: double.infinity,
              child: Image.network(
                loadedProducts.imageUrl,
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "\$${loadedProducts.price}",
              style: TextStyle(color: Colors.blueGrey, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                loadedProducts.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
