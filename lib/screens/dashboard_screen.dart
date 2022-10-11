import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_007/providers/dashboard_provider.dart';
import 'package:flutter_application_007/screens/cart_screen.dart';
import 'package:flutter_application_007/screens/home_page.dart';
import 'package:flutter_application_007/screens/more_screen.dart';
import 'package:flutter_application_007/screens/orders_screen.dart';
import 'package:flutter_application_007/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // List pages = [
  //   ProductsOverviewScreen(),
  //   CartScreen(),
  //   OrdersScreen(),
  //   MoreScreen(),
  // ];
  // int currentIndexIs = 0;
  // void onTap(int index) {
  //   setState(() {
  //     currentIndexIs = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, dashboardProvider, child) => Scaffold(
        body: dashboardProvider.getIndex == 0
            ? ProductsOverviewScreen()
            : dashboardProvider.getIndex == 1
                ? CartScreen()
                : dashboardProvider.getIndex == 2
                    ? OrdersScreen()
                    : dashboardProvider.getIndex == 3
                        ? MoreScreen()
                        : ProductsOverviewScreen(),
        // pages[currentIndexIs],

        bottomNavigationBar: BottomNavigationBar(
            selectedFontSize: 0,
            unselectedFontSize: 0,
            currentIndex: dashboardProvider.getIndex,
            onTap: dashboardProvider.changeIndex,
            type: BottomNavigationBarType.shifting,
            backgroundColor: Colors.red,
            elevation: 0,
            selectedItemColor: colorDarkPink,
            unselectedItemColor: Colors.blueGrey,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_max),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'shop',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.payment_rounded),
                label: 'Order',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.more),
                label: 'More',
              ),
            ]),
      ),
    );
  }
}
