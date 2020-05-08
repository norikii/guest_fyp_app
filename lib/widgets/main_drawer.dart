import 'package:flutter/material.dart';
import 'package:guest_fyp_app/providers/auth.dart';
import 'package:guest_fyp_app/screens/categories_screen.dart';
import 'package:guest_fyp_app/screens/orders_screen.dart';
import 'package:guest_fyp_app/screens/settings_screen.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  @override
  // builds a list tile
  Widget build(BuildContext context) {
    Widget buildListTile(String title, IconData icon, Function onTapController) {
      return ListTile(
        leading: Icon(icon, size: 26,),
        title: Text(title, style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold
        ),),
        onTap: onTapController,
      );
    }

    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Icon(Icons.person_pin),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.restaurant_menu),
            title: Text('Your Menu'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Your Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrdersScreen.ordersScreenRoute);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<Auth>(context, listen: false).logout();
//              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
//          Container(
//            height: 120,
//            width: double.infinity,
//            padding: EdgeInsets.all(20),
//            alignment: Alignment.centerLeft,
//            color: Theme.of(context).accentColor,
//            child: Text('Navigation', style: TextStyle(
//              fontWeight: FontWeight.w900,
//              fontSize: 30,
//              color: Theme.of(context).primaryColor
//            ),),
//          ),
//          Divider(),
//          SizedBox(
//            height: 20,
//          ),
//          // pushing the page and replacing it to avoid the stack
//          // getting bigger and bigger
//          buildListTile('Menu', Icons.restaurant, () {
//            Navigator.of(context).pushReplacementNamed('/');
//          }),
//          buildListTile('Settings', Icons.settings, () {
//            Navigator.of(context).pushReplacementNamed(SettingsScreen.settingsScreenRoute);
//          })
        ],
      ),
    );
  }
}
