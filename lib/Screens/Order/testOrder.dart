import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:secure_hops/Components/constants.dart';
import 'package:secure_hops/Shared%20Preferences/share_preferences.dart';

class MyCartPageTest extends StatefulWidget {
  const MyCartPageTest({Key? key}) : super(key: key);

  @override
  State<MyCartPageTest> createState() => _MyCartPageTestState();
}

class _MyCartPageTestState extends State<MyCartPageTest> {
  int value = 0;

  @override
  void initState() {
    super.initState();
    fetchAddToCart();
  }


  List addToCartList = [];


  fetchAddToCart()async{
   addToCartList =  await SavedSharePreference().getAddToCart();
   setState(() {
     
   });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("MY CART",style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: addToCartList.isEmpty ? Center(child: Text("NO Item Added into Cart"),) : Container(
        child: ListView.builder(
            itemCount: addToCartList.length,
            itemBuilder: (context, i) {
              return Card(
                child: Container(
                  
                  margin: EdgeInsets.all(5),
                  height: 100,
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width * 0.30,
                        child: Container(
                          height: 80,
                          color: Colors.red[100],
                        ),
                      ),
                      Container(
                        
                        padding: EdgeInsets.all(3),
                        height: 80,
                        alignment: Alignment.topLeft,
                        width: size.width * 0.40,
                        child: Text("This Item is Added into Cart",maxLines: 3,overflow: TextOverflow.ellipsis,),
                      ),
                      Container(
                        height: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                            width: size.width * 0.20,
                              height: 35,
                              decoration: BoxDecoration(
                                
                                  color: Color(0xFFEEF3FC),
                                  borderRadius: BorderRadius.circular(5)
                                  ),
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: (){
                                       setState(() {
                                            if (value > 0) {
                                              value--;
                                            }
                                          });
                                    },
                                    child: FaIcon(FontAwesomeIcons.minus,
                                       size: 10),
                                  ),
                                  Text('$value'),
                                  InkWell(
                                    splashColor: Colors.red,
                                    onTap: (){
                                       setState(() {
                                            value++;
                                          });
                                    },
                                    child: FaIcon(FontAwesomeIcons.plus, size: 10),
                                  ),
                                ],
                              ),
                            ),

                            Text("\$233",style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold,fontSize: 17),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
