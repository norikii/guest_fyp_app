import 'package:flutter/material.dart';
import 'package:guest_fyp_app/providers/auth.dart';
import 'package:guest_fyp_app/providers/order_provider.dart' show OrderProvider;
import 'package:guest_fyp_app/providers/orders_provider.dart';
import 'package:guest_fyp_app/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  static const orderRouteName = '/order';

  @override
  Widget build(BuildContext context) {
    final orderCart = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Order'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '£${orderCart.totalAmount}',
                      style: TextStyle(
                          color:
                              Theme.of(context).primaryTextTheme.title.color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  OrderButton(orderCart: orderCart)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, i) => OrderItem(
                id: orderCart.getOrderItems.values.toList()[i].id,
                productID: orderCart.getOrderItems.keys.toList()[i],
                name: orderCart.getOrderItems.values.toList()[i].name,
                price: orderCart.getOrderItems.values.toList()[i].price,
                quantity: orderCart.getOrderItems.values.toList()[i].quantity,
              ),
              itemCount: orderCart.itemCount,
            ),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.orderCart,
  }) : super(key: key);

  final OrderProvider orderCart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading ? CircularProgressIndicator() : Text('PLACE ORDER'),
      textColor: Theme.of(context).accentColor,
      onPressed: (widget.orderCart.totalAmount <= 0 || _isLoading) ? null : () async {
        setState(() {
          _isLoading = true;
        });
        final userID = Provider.of<Auth>(context, listen: false).userID;
        await Provider.of<OrdersProvider>(context, listen: false)
            .addOrder(widget.orderCart.getOrderItems.values.toList(),
                widget.orderCart.totalAmount, userID);
        widget.orderCart.clear();
        setState(() {
          _isLoading = false;
        });
        // redirection should happen here
      },

    );
  }
}


