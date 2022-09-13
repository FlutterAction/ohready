import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_hops/API/API_Manager.dart';
import 'package:secure_hops/Components/Components.dart';
import 'package:secure_hops/Modals/OrderHistory/order_history_model.dart';
import 'package:secure_hops/Provider/MyProvider.dart';
import '../../../../Components/constants.dart';
import 'OrderHistoryCard.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  void initState() {
    fetchOrderHistory();
    super.initState();
  }

  OrderHistoryModel? orderHistory;

  fetchOrderHistory() async {
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);

     APIManager()
        .orderHistory(context,
            email: provider.loginResponse!.user!.email,
            password: provider.loginResponse!.password)
        .then((value) {
          orderHistory = OrderHistoryModel.fromJson(jsonDecode(value));
    setState(() {});      
    });

  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(  
          backgroundColor: kBackgroundColor,
          // appBar: appBar(context, title: 'Order History'),
          appBar: AppBar(
            leading: customPOP(context),
            title: Text("Order History"),
            bottom: TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 2,
              tabs: [
                Tab(
                  text: "Current Orders",
                ),
                Tab(
                  text: "Past Orders",
                ),
              ],
            ),
          ),
          body: orderHistory == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : TabBarView(
                  children: [
                    orderHistory!.lstActiveOrders!.isEmpty ? Center(child: Text("No Order"),): ListView.builder(
                        itemCount: orderHistory!.lstActiveOrders!.length,
                        itemBuilder: (context, index) {
                          return OrderHistoryActiveCard(
                              orderHistory!.lstActiveOrders![index]);
                        }),
                  orderHistory!.lstPastOrders!.isEmpty ? Center(child: Text("No Order"),):  ListView.builder(
                        itemCount: orderHistory!.lstPastOrders!.length,
                        itemBuilder: (context, index) {
                          return OrderHistoryPastCard(
                              orderHistory!.lstPastOrders![index]);
                        }),
                  ],
                )),
    );
  }
}
