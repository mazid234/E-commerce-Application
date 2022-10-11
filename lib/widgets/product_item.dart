import 'package:flutter/material.dart';
import 'package:flutter_application_007/constants/constants.dart';
import 'package:flutter_application_007/providers/cart.dart';
import 'package:flutter_application_007/providers/product.dart';
import 'package:flutter_application_007/screens/product_detail_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductItem extends StatefulWidget {
  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  double? rating;

  // final String id, title, imageUrl;
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(
      context,
    ); //when we use provider of as listner than whole build method will re run when there is any change in data
    // print(product.title + product.isFavorite.toString());
    // final cart = Provider.of<Cart>(context);

    return Stack(children: [
      Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: GridTile(
            child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    'ProductDetailScreen',
                    arguments: product.id,
                  ); // only forward id in namedroute which will be extracted in product_detail_screen
                },
                child: Stack(children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Image.asset(
                        'assets/images/circle_image.png',
                        height: 180,
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      SizedBox(
                        height: 45,
                      ),
                      Container(
                          height: 150.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(
                                    product.imageUrl,
                                  )))),
                    ],
                  ),
                  // Container(
                  //     // height: 100,
                  //     decoration: BoxDecoration(shape: BoxShape.circle),
                  //     child: Image.network(product.imageUrl))
                ])
                // Image.network(product.imageUrl, fit: BoxFit.fitWidth),
                ),
            footer: Container(
              height: 80,
              child: GridTileBar(
                  // leading:
                  //  Consumer<Product>(
                  //   builder: (context, value, child) => IconButton(
                  //     icon: Icon(product.isFavorite == true
                  //         ? Icons.favorite
                  //         : Icons.favorite_outline),
                  //     color: product.isFavorite == true
                  //         ? colorDarkPink
                  //         : Colors.white,
                  //     onPressed: () {
                  //       product.toggleFavoriteStatus();
                  //       Fluttertoast.showToast(
                  //           msg: (product.isFavorite == true
                  //               ? "Added to favorites"
                  //               : "Removed from favorites"),
                  //           toastLength: Toast.LENGTH_SHORT,
                  //           gravity: ToastGravity.BOTTOM,
                  //           timeInSecForIosWeb: 1,
                  //           backgroundColor: Colors.grey[700],
                  //           textColor: Colors.white,
                  //           fontSize: 16.0);
                  //     },
                  //   ),
                  // ),
                  // backgroundColor: Colors.transparent,
                  // trailing:
                  // Consumer<Cart>(
                  //   builder: (context, cart, child) => IconButton(
                  //     icon: Icon(
                  //       Icons.shopping_cart_rounded,
                  //       // color: Theme.of(context).iconTheme.color,
                  //     ),
                  //     onPressed: () {
                  //       cart.addItem(product.id, product.price, product.title);
                  //       ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //         content: Text('Added Item To Cart'),
                  //         duration: Duration(seconds: 2),
                  //         action: SnackBarAction(
                  //             label: "Undo",
                  //             onPressed: () {
                  //               cart.removeSingleItem(product.id);
                  //             }),
                  //       ));
                  //       // print("cart item :${cart.itemCount.toString()}");
                  //       // Fluttertoast.showToast(
                  //       //     msg: "Added to cart",
                  //       //     toastLength: Toast.LENGTH_SHORT,
                  //       //     gravity: ToastGravity.BOTTOM,
                  //       //     timeInSecForIosWeb: 1,
                  //       //     backgroundColor: Colors.grey[700],
                  //       //     textColor: Colors.white,
                  //       //     fontSize: 16.0);
                  //     },
                  //     // color: Colors.deepOrange,
                  //   ),
                  // ),
                  title: Center(
                child: FittedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        product.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: colorSecondary),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "\$${product.price}",
                        style: TextStyle(color: Colors.blueGrey, fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          RatingBar.builder(
                            updateOnDrag: true,
                            initialRating: 3.5,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 10,
                            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              return setState(() {
                                this.rating = rating;
                              });
                              ;
                            },
                          ),
                          (rating == null)
                              ? Text(
                                  "(3.5)",
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 10),
                                )
                              : Text(
                                  "($rating)",
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 10),
                                )
                        ],
                      )
                    ],
                  ),
                ),
              )),
            ),
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 1,
          ),
          Card(
              color: colorPrimarylight,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  "40% OFF",
                  style: TextStyle(
                      color: colorSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              )),
          SizedBox(
            width: 10,
          ),
          Consumer<Cart>(
            builder: (context, cart, child) => IconButton(
              padding: EdgeInsets.all(1),
              iconSize: 16,
              icon: Icon(
                Icons.shopping_cart_rounded,
                // color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () {
                cart.addItem(product.id ?? '', product.price, product.title);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Added Item To Cart'),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                      label: "Undo",
                      onPressed: () {
                        cart.removeSingleItem(product.id ?? '');
                      }),
                ));
                // print("cart item :${cart.itemCount.toString()}");
                // Fluttertoast.showToast(
                //     msg: "Added to cart",
                //     toastLength: Toast.LENGTH_SHORT,
                //     gravity: ToastGravity.BOTTOM,
                //     timeInSecForIosWeb: 1,
                //     backgroundColor: Colors.grey[700],
                //     textColor: Colors.white,
                //     fontSize: 16.0);
              },
              // color: Colors.deepOrange,
            ),
          ),
          Consumer<Product>(
            builder: (context, value, child) => IconButton(
              padding: EdgeInsets.all(1),
              iconSize: 16,
              icon: Icon(product.isFavorite == true
                  ? Icons.favorite
                  : Icons.favorite_outline),
              color: product.isFavorite == true ? colorDarkPink : Colors.grey,
              onPressed: () {
                product.toggleFavoriteStatus();
                Fluttertoast.showToast(
                    msg: (product.isFavorite == true
                        ? "Added to favorites"
                        : "Removed from favorites"),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey[700],
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
            ),
          ),
        ],
      )
    ]);
  }
}
