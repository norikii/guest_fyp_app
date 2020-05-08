import 'package:flutter/material.dart';
import 'package:guest_fyp_app/providers/order_provider.dart';
import 'package:provider/provider.dart';

class OrderItem extends StatelessWidget {
  final String id;
  final String productID;
  final double price;
  final int quantity;
  final String name;

  OrderItem({this.id, this.productID, this.price, this.quantity, this.name});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Colors.redAccent,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<OrderProvider>(context, listen: false).removeItemFromOrder(id);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            title: Text(name),
            leading: CircleAvatar(
              child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      '£$price',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            subtitle: Text('Total: £${(price * quantity)}'),
            trailing: Text('Quatity: $quantity'),
          ),
        ),
      ),
    );
  }
}
