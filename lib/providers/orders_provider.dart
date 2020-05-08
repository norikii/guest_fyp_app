import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:guest_fyp_app/providers/order_provider.dart';
import 'package:http/http.dart' as http;

class OrdersItem {
  final String id;
  final double amount;
  final List<dynamic> items;
  final DateTime createdAt;

  OrdersItem({this.id, this.amount, this.items, this.createdAt});
}

class OrdersProvider with ChangeNotifier {
  final String authToken;
  List<OrdersItem> _orders = [];


  List<OrdersItem> get getOrders {
    // copy of the list
    return [..._orders];
  }

  OrdersProvider(this.authToken, this._orders);


  // converts unix timestamp to DateTime object
  DateTime convertUnix(int unixTimestamp) {
    var ts = new DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);

    return ts;
  }

  Future<void> fetchAndSetOrders() async {
    const url = 'http://192.168.0.55:12345/auth/orders';
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $authToken',
    };
    try {
      final response = await http.get(url, headers: headers);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      List<dynamic> ordersPayloadList = extractedData['payload'];
      if (extractedData == null) {
        return;
      }

      final List<OrdersItem> loadedOrders = [];
        for (final order in ordersPayloadList) {
          loadedOrders.add(
            OrdersItem(
              id: order['_id'],
              amount: order['total_price'].toDouble(),
              items: order['items'],
              createdAt: convertUnix(order['created_at'])
            )
          );
        }

        _orders = loadedOrders.reversed.toList();
        notifyListeners();

    } catch(error) {
      throw(error);
    }





  }

  Future<void> addOrder(List<CartItem> cartItems, double total) async {
    const url = 'http://192.168.0.55:12345/auth/order';
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $authToken',
    };
    final response = await http.post(url,
        body: json.encode({
          'table_id': 5,
          'items': cartItems
              .map((cp) => {
                    '_id': cp.id,
                    'item_name': cp.name,
                    'item_price': cp.price,
                  })
              .toList(),
          'total_price': total,
        }),
        headers: headers
    );

//    _orders.insert(0, OrdersItem());
    notifyListeners();
  }
}
