import 'package:flutter/material.dart';
import 'package:secure_hops/Components/Components.dart';
import 'package:secure_hops/Modals/OrderHistory/order_history_model.dart';

class OrderHistoryPastCard extends StatefulWidget {
  final LstPastOrder? orderHistoryPastData;

  OrderHistoryPastCard(this.orderHistoryPastData);

  @override
  _OrderHistoryPastCardState createState() => _OrderHistoryPastCardState();
}

class _OrderHistoryPastCardState extends State<OrderHistoryPastCard> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return
      SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: InkWell(
              child:

              Container(

                decoration: BoxDecoration(color: Colors.white,
                ),
                height: 100.0,
                width: width,
                child:
                Row(
                  children: [
                    // Container(
                    //   child: widget.orderHistoryPastData!.restaurantLogo! == null ? Container() : 
                    // Image.asset(widget.orderHistoryPastData!.restaurantLogo!,width: 100.0,height: 100.0,),
                    // ),
                    SizedBox(width: 4.0,),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(top: 12.0,left: 20,bottom: 8),
                          child: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(child: Text(widget.orderHistoryPastData!.restaurantName!,style: TextStyle(color: Colors.black,fontSize: 14.0),)),

                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(child: Text("May 26,2021",style: TextStyle(color: Colors.black54,fontSize: 12.0),)),

                                // Expanded(child: Text(DateFormat('MMDDYY').format(DateTime.parse(widget.orderHistoryPastData!.orderDate!)),style: TextStyle(color: Colors.black54,fontSize: 12.0),)),
                              ],
                            ),
                          ),
                        ),

                        Row(children: [

                          SizedBox(width: 5.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 0.0,right: 5.0),

                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15.0),
                                      child: Text(widget.orderHistoryPastData!.orderStatus!,
                                        style: TextStyle(fontSize: 14.0,
                                            color: widget.orderHistoryPastData!.orderStatus! == 'Delivered' ? Colors.green  : Colors.orange),),
                                    ),
                                widget.orderHistoryPastData!.orderStatus! == 'Delivered' ? Icon(Icons.check,color: Colors.green,) : Icon(Icons.timelapse ,color: Colors.orange,),    
                                    Padding(
                                      padding: const EdgeInsets.only(left: 40.0),                                    
                                    ),
                                    Text((convertPrice(context, widget.orderHistoryPastData!.orderTotal)).toString(),
                                      style: TextStyle(fontSize: 15.0,
                                          color: Colors.black),),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],),
                        Flexible(child: Container(
                          //remove cart item
                        )),


                      ],
                    ))
                  ],
                ),
              ),
            ),
          ),

        ],
      ));
  }
}







class OrderHistoryActiveCard extends StatefulWidget {
  final LstActiveOrder? orderHistoryActiveData;

  OrderHistoryActiveCard(this.orderHistoryActiveData);

  @override
  _OrderHistoryActiveCardState createState() => _OrderHistoryActiveCardState();
}

class _OrderHistoryActiveCardState extends State<OrderHistoryActiveCard> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return
      SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: InkWell(
              child:

              Container(

                decoration: BoxDecoration(color: Colors.white,
                ),
                height: 100.0,
                width: width,
                child:
                Row(
                  children: [
                    Image.asset(widget.orderHistoryActiveData!.cart.toString(),width: 100.0,height: 100.0,),
                    SizedBox(width: 4.0,),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(top: 12.0,left: 20,bottom: 8),
                          child: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(child: Text("Filada Family Bar",style: TextStyle(color: Colors.black,fontSize: 14.0),)),

                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(child: Text("May 26,2021",style: TextStyle(color: Colors.black54,fontSize: 12.0),)),
                              ],
                            ),
                          ),
                        ),

                        Row(children: [

                          SizedBox(width: 5.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 0.0,right: 5.0),

                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15.0),
                                      child: Text("Delivered ",
                                        style: TextStyle(fontSize: 14.0,
                                            color: Colors.green),),
                                    ),
                                    Icon(Icons.check,color: Colors.green,),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 40.0),
                                      child: Text("\$",style: TextStyle(color: Colors.black,fontSize: 16.0),),
                                    ),
                                    Text(("16").toString(),
                                      style: TextStyle(fontSize: 15.0,
                                          color: Colors.black),),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],),
                        Flexible(child: Container(
                          //remove cart item
                        )),


                      ],
                    ))
                  ],
                ),
              ),
            ),
          ),

        ],
      ));
  }
}


