import 'package:flutter/material.dart';
import 'package:flutter_application_007/screens/cart_screen.dart';
import 'package:flutter_application_007/screens/dashboard_screen.dart';
import 'package:flutter_application_007/screens/edit_product_screen.dart';
import 'package:flutter_application_007/screens/more_screen.dart';
import 'package:flutter_application_007/screens/orders_screen.dart';
import 'package:flutter_application_007/screens/user_products_screen.dart';

class Routes {
  static Route? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/dashboard':
        return MaterialPageRoute(
          builder: (context) => DashboardScreen(),
        );
      case '/cartscreen':
        return MaterialPageRoute(
          builder: (context) => CartScreen(),
        );
      case '/orderscreen':
        return MaterialPageRoute(
          builder: (context) => OrdersScreen(),
        );
      case '/morescreen':
        return MaterialPageRoute(
          builder: (context) => MoreScreen(),
        );
      case '/userproducts':
        return MaterialPageRoute(
          builder: (context) => UserProductsScreen(),
        );
      // case '/editproduct':
      //   return MaterialPageRoute(
      //     builder: (context) => EditProductScreen(),
      //   );
    }
  }
}
