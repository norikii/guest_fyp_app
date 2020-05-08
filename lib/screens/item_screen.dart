import 'package:flutter/material.dart';
import 'package:guest_fyp_app/models/item.dart';
import 'package:guest_fyp_app/providers/item.dart';
import 'package:guest_fyp_app/providers/items_provider.dart';
import 'package:guest_fyp_app/providers/order_provider.dart';
import 'package:guest_fyp_app/widgets/badge.dart';
import 'package:guest_fyp_app/widgets/meal_item.dart';
import 'package:provider/provider.dart';

import 'order_screen.dart';


class ItemScreen extends StatefulWidget {
  static const itemScreenRoute = '/item';

  ItemScreen();

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  // checks if the widget has been initialized
  bool _isInit = true;

  @override
  void initState() {

    super.initState();
  }

  // this runs after the widget has been fully initialized
  // it fetches the data once the widget loads for the first time
  @override
  void didChangeDependencies() {
    // to fetch data only once
    if(_isInit) {
      Provider.of<ItemsProvider>(context).getAllItems();
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // extracts data from the route
    final categoryArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryTitle = categoryArgs['title'];
    final categoryId = categoryArgs['id'];
    final availItems = Provider.of<ItemsProvider>(context).findByType(categoryId);

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
          actions: <Widget>[
            Consumer<OrderProvider>(
              builder: (_, cartData, ch) => Badge(
                child: ch,
                value: cartData.itemCount.toString(),
              ),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(OrderScreen.orderRouteName);
                },
              ),
            )
          ]
      ),

      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: availItems[index].id,
            itemName: availItems[index].itemName,
            itemImg: availItems[index].itemImage,
            itemPrice: availItems[index].itemPrice,
            duration: availItems[index].estimatePrepareTime,
          );
        },
        itemCount: availItems.length,
      ),
    );
  }
}
