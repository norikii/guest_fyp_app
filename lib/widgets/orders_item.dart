import 'dart:math';

import 'package:flutter/material.dart';
import '../providers/orders_provider.dart' as ord;
import 'package:intl/intl.dart';

class OrdersItem extends StatefulWidget {
  final ord.OrdersItem orders;

  OrdersItem(this.orders);

  @override
  _OrdersItemState createState() => _OrdersItemState();
}

class _OrdersItemState extends State<OrdersItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('Total: £${widget.orders.amount}'),
            subtitle: Text(
                DateFormat('dd/MM/yyyy HH:mm').format(widget.orders.createdAt)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              height: min(widget.orders.items.length * 20.0 + 15, 100),
              child: ListView(
                children: widget.orders.items.map((item) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(item['item_name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                      Text('£${item['item_price']}', style: TextStyle(fontSize: 18, color: Colors.grey),)
                    ],
                  ),
                )).toList(),
              ),
            )
        ],
      ),
    );
  }
}
