import 'package:flutter/material.dart';
import 'package:flutter_application_007/providers/cart.dart';
import 'package:flutter_application_007/providers/dashboard_provider.dart';
import 'package:flutter_application_007/providers/orders.dart';
import 'package:flutter_application_007/providers/products.dart';
import 'package:flutter_application_007/routes.dart';
import 'package:flutter_application_007/screens/cart_screen.dart';
import 'package:flutter_application_007/screens/dashboard_screen.dart';
import 'package:flutter_application_007/screens/edit_product_screen.dart';
import 'package:flutter_application_007/screens/orders_screen.dart';
import 'package:flutter_application_007/screens/product_detail_screen.dart';
import 'package:flutter_application_007/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';
import './screens/auth_screen.dart';
import 'constants/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Products()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Orders()),
        ChangeNotifierProvider(create: (context) => DashboardProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          errorColor: colorError,
          // backgroundColor: Colors.yellow,
          // primaryColor: Colors.deepOrange,
          // primarySwatch: Colors.blueGrey,
          // primaryColor: colorPrimary,
          // appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
          appBarTheme: appBarTheme,
          // iconTheme: IconThemeData(color: colorDarkPink),
          elevatedButtonTheme: elevatedButtonThemeData,
          fontFamily: 'QuattrocentoSans',
        ),
        onGenerateRoute: Routes.generateRoutes,
        initialRoute: 'auth',
        routes: {
          //   "/": (context) => DashboardScreen(),
          "auth": (context) => AuthScreen(),
          "ProductDetailScreen": (context) => ProductDetailScreen(),
          "EditProductScreen": (context) => EditProductScreen(),
          //   CartScreen.routeName: (context) => CartScreen(),
          //   OrdersScreen.routeName: (context) => OrdersScreen(),
        },
      ),
    );
  }
}
