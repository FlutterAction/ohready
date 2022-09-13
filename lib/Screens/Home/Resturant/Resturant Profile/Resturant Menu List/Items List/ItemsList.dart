// import 'dart:convert';

// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:secure_hops/Components/constants.dart';
// import 'package:secure_hops/Modals/Resturants/ResturantProfile.dart';
// import 'package:secure_hops/Provider/MyProvider.dart';
// import 'ItemCard.dart';







// class ItemsList extends StatefulWidget {
//   final ResturantProfileModel? resturantProfile;
//   final List? menuList;
//   final int? selectedIndex;
//   ItemsList({@required this.resturantProfile, @required this.menuList, this.selectedIndex});

//   @override
//   State<ItemsList> createState() => _ItemsListState();
// }

// class _ItemsListState extends State<ItemsList> {
//   // final ItemPositionsListener itemPositionsListener =
//   //     ItemPositionsListener.create();
//   // int selectedIndex = 0;



// // final ItemScrollController itemScrollController =  ItemScrollController();
//   @override
//   void initState() {
//     print("Arham : ${widget.selectedIndex}");
//     MyProvider provider = Provider.of<MyProvider>(context, listen: false);
//     provider.itemList = null;



//   //   itemScrollController.scrollTo(
//   // index: widget.selectedIndex!,
//   // duration: Duration(seconds: 2),
//   // curve: Curves.easeInOutCubic);
//     // itemScrollController.scrollTo(index: 3, duration: Duration(seconds:1));
//     // itemScrollController =  ItemScrollController();
//   //   itemScrollController.scrollTo(
//   // index: widget.selectedIndex!,
//   // duration: Duration(seconds: 2),
//   // curve: Curves.easeInOutCubic);
//     // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
//     //   if (widget.menuList!.isNotEmpty) {
//         // provider.saveItemList(widget.menuList![0].itemsList);
//     //   }
//     // });

//     // itemScrollController = ItemScrollController();

//     WidgetsBinding.instance!.addPostFrameCallback((_) => scrollToSpecificIndex(0));
//     // print(widget.menuList);
//     super.initState();
//   }



//   scrollToSpecificIndex(index){
//     print("Not Jumping till Now ");
//     itemScrollController.jumpTo(index: index);
//       // if (widget.menuList!.isNotEmpty) {
//       //   MyProvider provider = Provider.of<MyProvider>(context, listen: false);
//       //   provider.saveItemList(widget.menuList![0].itemsList);
//       // }
//   }

  
//   // ItemScrollController _scrollController = ItemScrollController();

//   dynamic indexSaved ;

//   @override
//   Widget build(BuildContext context) {
//     // print(itemPositionsListener.itemPositions.value.toList()[0].index);
//     return
//     //  Consumer<MyProvider>(builder: (context, provider, child) {
//     //   return provider.itemList == null || provider.itemList!.isEmpty
//     //       ? Container(
//     //         height: 200,
//     //         child: Center(
//     //             child: Text('No Item in this menu'),
//     //           ),
//     //       )
//     //       : 
//           Container(
//             margin: EdgeInsets.only(top: 0),
//             // height: MediaQuery.of(context).size.height / 2 + 53,
//             child: ScrollablePositionedList.builder(
//               physics: ClampingScrollPhysics(),
//               shrinkWrap: true,
//               itemScrollController: itemScrollController,
//               // itemPositionsListener: itemPositionsListener,                      
//               // itemCount: 3,
//               itemCount: widget.menuList!.length,
//               itemBuilder: (context, index) {
//                 // itemPositionsListener.itemPositions.addListener(() {
//                 //   setState(() {
//                 //     indexSaved = itemPositionsListener.itemPositions.value.toList()[0].index;
//                 //   });
//                 // _scrollController.scrollTo(index: itemPositionsListener.itemPositions.value.toList()[0].index, duration: Duration(milliseconds: 100));
//                 // });
//                 /// Not My...
//                 // scrollController.animateTo(
//                 //   // scrollController.position.
//                 //   curve: Curves.easeOut,
//                 //   duration: const Duration(milliseconds: 300),
//                 // );
//                 var newitemlist =
//                     widget.menuList![index].itemsList!.toList();
//                 return ListTile( 
                                                   
//                   title: Container(
//                     margin: EdgeInsets.symmetric(vertical: 10),
//                     child: Text(
//                       widget.menuList![index].name.toString() + "${widget.selectedIndex}",
//                       style: customStyle,
//                     ),
//                   ),
//                   subtitle: GridView.builder(
//                     // physics: NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     gridDelegate:
//                         SliverGridDelegateWithFixedCrossAxisCount(
//                       childAspectRatio: 0.67,
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10,
//                     ),
//                     itemCount: newitemlist.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return ItemCard(
//                         item: newitemlist[index],
//                         resturantProfile: widget.resturantProfile,
//                       );
//                     },
//                   ),
               
//                 );
              
//               },
//             ),
//           );
//     // });
//   }
// }

// class MenuCard extends StatefulWidget {
//   final Menu? menu;
//   final int? currentIndex;
//   final int? selectedIndex;
//   final Function()? onPressed;
//   const MenuCard(
//       {@required this.menu,
//       @required this.currentIndex,
//       @required this.selectedIndex,
//       @required this.onPressed});

//   @override
//   State<MenuCard> createState() => _MenuCardState();
// }

// class _MenuCardState extends State<MenuCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<MyProvider>(builder: (context, provider, child) {
//       return InkWell(
//         onTap: widget.onPressed,
//         child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 10),
//             decoration: BoxDecoration(
//                 color: widget.selectedIndex == widget.currentIndex
//                     ? primaryColor
//                     : Colors.white,
//                 borderRadius: BorderRadius.circular(5)),
//             margin: EdgeInsets.only(right: 10),
//             height: 20,
//             child: Center(
//               child: Text(
                
//                 widget.menu!.name.toString(),
//                 style: TextStyle(                  
//                     color: widget.selectedIndex == widget.currentIndex
//                         ? Colors.white
//                         : Colors.black54),
//               ),
//             )),
//       );
//     });
//   }
// }
