import 'package:flutter/material.dart';
import 'package:guest_fyp_app/providers/auth.dart';
import 'package:guest_fyp_app/providers/orders_provider.dart' show OrdersProvider;
import 'package:guest_fyp_app/widgets/main_drawer.dart';
import 'package:provider/provider.dart';
import '../widgets/orders_item.dart';

class OrdersScreen extends StatefulWidget {
  static const ordersScreenRoute = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<OrdersProvider>(context, listen: false).fetchAndSetOrders();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context, listen: false).userID;
    final ordersData = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: MainDrawer(),
      body: _isLoading ? Center(child: CircularProgressIndicator(),) : ListView.builder(
        itemBuilder: (ctx, i) => OrdersItem(ordersData.ordersByUserID(user)[i]),
        itemCount: ordersData.ordersByUserID(user).length,
      ),
    );
  }
}
