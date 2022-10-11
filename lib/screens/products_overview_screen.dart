import 'package:android_intent_plus/android_intent.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_007/providers/products.dart';
import 'package:flutter_application_007/screens/cart_screen.dart';
import 'package:flutter_application_007/screens/home_page.dart';
import 'package:flutter_application_007/screens/more_screen.dart';
import 'package:flutter_application_007/screens/orders_screen.dart';
import 'package:flutter_application_007/widgets/app_drawer.dart';
import 'package:flutter_application_007/widgets/badge.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import '../providers/cart.dart';
import '../widgets/products_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        // iconTheme: IconThemeData(color: colorPrimary),
        elevation: 0,
        // backgroundColor: colorWhite,
        title: Text(
          'Discover',
          style: TextStyle(
            // color: colorPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton(
            // color: colorPrimary,
            onSelected: (FilterOptions selectedValue) {
              p("aaaaaa:${selectedValue.toString()}");
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorite = true;
                  p("bbbbbb: ${_showOnlyFavorite.toString()}");
                } else {
                  _showOnlyFavorite = false;
                }
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                  child: Text('Only Favorites'),
                  value: FilterOptions.Favorites),
              PopupMenuItem(child: Text('Show All'), value: FilterOptions.All),
            ],
            icon: Icon(
              Icons.more_vert,
              // color: colorPrimary,
            ),
          ),
          Consumer<Cart>(
            builder: (context, cart, ch) => Badge(
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart_checkout_sharp,
                  // color: colorPrimary
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/cartscreen',
                  );
                },
              ),
              value: cart.itemCount.toString(),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(child: ProductsGrid(_showOnlyFavorite)),

          // Container(
          //   padding: EdgeInsets.all(10),
          //   width: double.infinity,
          //   child: ElevatedButton(
          //     style: ButtonStyle(),
          //     onPressed: () async {
          //       // var isAppInstalledResult = await LaunchApp.isAppInstalled(
          //       //   androidPackageName: "com.example.new_ui",
          //       // );
          //       // print(
          //       //     'isAppInstalledResult => $isAppInstalledResult ${isAppInstalledResult.runtimeType}');
          //     },
          //     child: Text('Add'),
          //   ),
          // ),
        ],
      ),
    );
  }
}