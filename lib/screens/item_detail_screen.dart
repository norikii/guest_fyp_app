import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guest_fyp_app/dummy_data.dart';
import 'package:guest_fyp_app/providers/items_provider.dart';
import 'package:provider/provider.dart';

class ItemDetailScreen extends StatelessWidget {
  static const itemDetailRoute = '/item/detail';

  @override
  Widget build(BuildContext context) {
    final itemId = ModalRoute.of(context).settings.arguments as String;
//    final selectedItem = DUMMY_MEALS.firstWhere((item) => item.id == itemId);
    final selectedItem = Provider.of<ItemsProvider>(context).findById(itemId);
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedItem.itemName}'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
            width: double.infinity,
            child: Image.memory(
              base64.decode(selectedItem.itemImage.split(',').last),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              'Item Description: \n' +
              selectedItem.itemDescription,
              style: Theme.of(context).textTheme.title,
              textAlign: TextAlign.center,
            ),
          ),
//          Container(
//            height: 150,
//            width: double.infinity,
//            decoration: BoxDecoration(
//                color: Colors.white,
//                border: Border.all(color: Colors.grey),
//                borderRadius: BorderRadius.circular(10)),
//            margin: EdgeInsets.all(10),
//            padding: EdgeInsets.all(10),
//            child: ListView.builder(
//              itemBuilder: (ctx, index) => Card(
//                color: Theme.of(context).accentColor,
//                child: Padding(
//                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                    child: Text(selectedItem.ingredients[index])),
//              ),
//              itemCount: selectedItem.ingredients.length,
//            ),
//          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Price: £' + selectedItem.itemPrice.toString(),
              style: Theme.of(context).textTheme.title,
            ),
          ),
          FlatButton(
            onPressed: () {},
            color: Colors.blue,
            child: Text(
                'ADD TO BASKET',
              style: Theme.of(context).textTheme.title,
            ),
          )
        ],
      ),
    );
  }
}
