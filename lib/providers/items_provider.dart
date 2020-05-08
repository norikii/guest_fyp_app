import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guest_fyp_app/providers/item.dart';
import 'package:http/http.dart' as http;

import './item.dart';


class ItemsProvider with ChangeNotifier {
  List<Item> _items = [];
  final String token;

  ItemsProvider(this.token, this._items);

  List<Item> get items {
    return [..._items];
  }

  Item findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  List<Item> findByType(String type) {

    return _items.where((item) => item.itemType == type).toList();
  }

  Future<void> getAllItems() async {
    final url = 'http://192.168.0.55:12345/auth/items';
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.get(url, headers: headers);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      List<dynamic> itemPayloadList = extractedData['payload'];
      final List<Item> loadedItems = [];

//      var duration = Duration(minutes: itemPayloadList[0]['estimate_prepare_time']);
//      print(duration);
      for(final item in itemPayloadList) {
        loadedItems.add(
          Item(
            id: item['_id'],
            itemName: item['item_name'],
            itemDescription: item['item_description'],
            itemType: item['item_type'],
            itemImage: item['item_img'],
            itemPrice: item['item_price'].toDouble(),
            estimatePrepareTime: item['estimate_prepare_time'],
            createdAt: item['created_at'],
            updatedAt: item['updated_at'],
            deletedAt: item['deleted_at'],
          )
        );
      }
      _items = loadedItems;
      notifyListeners();
      } catch(error) {
        throw(error);
    }
  }
}