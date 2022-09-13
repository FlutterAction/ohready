import 'package:flutter/material.dart';
import 'package:secure_hops/Screens/Order/CartPage.dart';


class Order extends StatefulWidget {
  final isRoot;
  Order([this.isRoot]);
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
       CartPage(widget.isRoot), //change CartPageNew to EmptyCart when work done
    );
  }
}
