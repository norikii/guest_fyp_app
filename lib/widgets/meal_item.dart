import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:guest_fyp_app/models/item.dart';
import 'package:guest_fyp_app/providers/order_provider.dart';
import 'package:guest_fyp_app/screens/item_detail_screen.dart';
import 'package:provider/provider.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String itemName;
  final String itemImg;
  final double itemPrice;
  final int duration;

  MealItem({
    @required this.id,
    @required this.itemName,
    @required this.itemImg,
    @required this.itemPrice,
    @required this.duration});

  void selectMeal(BuildContext context) {
    Navigator.of(context).pushNamed(
        ItemDetailScreen.itemDetailRoute, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    // we are not interested in changes in the order to we wont' listen for changes
    // hence this widget will not change if the cart rebuild
    final order = Provider.of<OrderProvider>(context, listen: false);

    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(10),
        // changing the overall look of the card
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: <Widget>[
            // allow adding items on a top of each other in a three dimensional space
            Stack(
              children: <Widget>[
                // to force a widget into a certain form
                // .only() specifies which corners should be rounded
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  // resize and crops the image
                  child: Image.memory(
                    base64.decode(itemImg.split(',').last),
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // allow us to position the child widget in an absolute coordinate space
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 20
                    ),
                    child: Text(
                      itemName,
                      style: TextStyle(fontSize: 26, color: Colors.white),
                      softWrap: true,
                      // if it does not fit into the box it will be faded
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(children: <Widget>[
                    Icon(Icons.schedule),
                    SizedBox(width: 6,),
                    Text('$duration min'),
                  ],),
                  Row(children: <Widget>[
                    Icon(Icons.attach_money),
                    Text('Price: £' + itemPrice.toString()),
                  ],),
                  Row(children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.add_shopping_cart),
                      color: Colors.green,
                      onPressed: () {
                        order.addItemToOrder(id, itemPrice, itemName);
                      },
                    ),
                    SizedBox(width: 6,),
                  ],)
                ],
              ),)
          ],
        ),
      ),
    );
  }
}
