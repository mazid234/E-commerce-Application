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
import 'package:flutter_application_007/widgets/shimmer_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
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
  var _isInit = true;
  var _isLoading = false;
  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); //.of(contex) wont work in initstate
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // we will not async with @overide method so will use .the
    // TODO: implement didChangeDependencies
    if (_isInit) {
      setState(() {
        _isLoading = true;
      }); //set will reflect it in ui otherwise only property will change to true
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      }); // then will triggred when we are done with fetching
    }
    _isInit = false; //runs onces as page loaded
    super.didChangeDependencies();
  }

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
          Expanded(
              child: _isLoading
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.2 / 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) => Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24)),
                          child: buildFoodShimmer()),
                    )
                  : ProductsGrid(_showOnlyFavorite)),

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

  Widget buildFoodShimmer() => Stack(
        alignment: Alignment.topCenter,
        children: const [
          Positioned(
            top: 50,
            child: GridTile(
              child: ShimmerWidget.circular(height: 150, width: 150),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 42,
            left: 42,
            child: GridTileBar(
              title: ShimmerWidget.rectangular(width: 20, height: 14),
            ),
          ),
          Positioned(
            bottom: 50,
            right: 30,
            left: 30,
            child: GridTileBar(
              title: ShimmerWidget.rectangular(width: 20, height: 14),
            ),
          )
        ],
      );
}
