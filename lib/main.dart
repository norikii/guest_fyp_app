import 'package:flutter/material.dart';
import 'package:guest_fyp_app/dummy_data.dart';
import 'package:guest_fyp_app/providers/auth.dart';
import 'package:guest_fyp_app/providers/items_provider.dart';
import 'package:guest_fyp_app/providers/order_provider.dart';
import 'package:guest_fyp_app/providers/orders_provider.dart';
import 'package:guest_fyp_app/screens/categories_screen.dart';
import 'package:guest_fyp_app/screens/item_detail_screen.dart';
import 'package:guest_fyp_app/screens/item_screen.dart';
import 'package:guest_fyp_app/screens/login_screen.dart';
import 'package:guest_fyp_app/screens/order_screen.dart';
import 'package:guest_fyp_app/screens/orders_screen.dart';
import 'package:guest_fyp_app/screens/settings_screen.dart';
import 'package:guest_fyp_app/screens/tabs_screen.dart';
import 'package:provider/provider.dart';

import 'models/item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrderProvider(),
        ),
        ChangeNotifierProxyProvider<Auth, OrdersProvider>(
          update: (ctx, auth, previousOrder) => OrdersProvider(auth.token, previousOrder == null ? [] : previousOrder.getOrders),
        ),
        ChangeNotifierProxyProvider<Auth, ItemsProvider>(
          update: (ctx, auth, previousItem) => ItemsProvider(auth.token, previousItem == null ? [] : previousItem.items),
        )
      ],
      child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
                title: 'Tap Menu',
                theme: ThemeData(
                    primarySwatch: Colors.red,
                    accentColor: Colors.orange,
                    canvasColor: Color.fromRGBO(255, 254, 229, 1),
                    fontFamily: 'Releway',
                    textTheme: ThemeData.light().textTheme.copyWith(
                        body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                        body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                        title: TextStyle(
                            fontSize: 20,
                            fontFamily: 'RobotoCondensed',
                            fontWeight: FontWeight.bold))),

                /// home route '/' route
      home: auth.isAuth ? TabsScreen() : LoginScreen(),
                // specifying route which will be loaded first instead of home
//                initialRoute: '/',
                // setting up the routes table for named routes
                routes: {
                  TabsScreen.tabScreenRoute: (ctx) => TabsScreen(),
                  ItemScreen.itemScreenRoute: (ctx) => ItemScreen(),
                  ItemDetailScreen.itemDetailRoute: (ctx) => ItemDetailScreen(),
                  OrderScreen.orderRouteName: (ctx) => OrderScreen(),
                  OrdersScreen.ordersScreenRoute: (ctx) => OrdersScreen(),
//            SettingsScreen.settingsScreenRoute: (ctx) => SettingsScreen(null, null),
                  LoginScreen.loginRouteName: (ctx) => LoginScreen(),
                },
                // this route is reached if a flutter failed to reach a screen
                // which is registered its like 404 page

              )),
    );
  }
}

