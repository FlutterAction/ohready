// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:secure_hops/Components/constants.dart';
// import 'package:secure_hops/Widgets/Material%20Color.dart';

// class CartPageNew extends StatefulWidget {
//   const CartPageNew({Key? key}) : super(key: key);

//   @override
//   _CardPage2State createState() => _CardPage2State();
// }

// class _CardPage2State extends State<CartPageNew> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: kBackgroundColor,
//       appBar: AppBar(
//         iconTheme: IconThemeData.fallback(),
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         centerTitle: true,
//         title: Text(
//           'My order',
//           style: TextStyle(color: appBarText),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Container(
//                 // color: Colors.green,
//                 height: size.height / 5 * 0.6,
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: Image.asset("assets/itembackground.png"),
//                       flex: 1,
//                     ),
//                     Expanded(
//                       flex: 3,
//                       child: Container(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "croissant cafe",
//                                 style: customStyle,
//                               ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 5),
//                                 child: Text(
//                                   "Bakery",
//                                   style: TextStyle(color: textColor),
//                                 ),
//                               ),
//                               Row(
//                                 children: [
//                                   Icon(
//                                     Icons.star_outline,
//                                     size: 17,
//                                   ),
//                                   Text("5.0 -"),
//                                   Icon(
//                                     Icons.location_on_outlined,
//                                     size: 17,
//                                   ),
//                                   Text("0.2 km - "),
//                                   Text("\$\$"),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                         flex: 0,
//                         child: Center(
//                           child: Icon(
//                             Icons.arrow_forward_ios,
//                             color: textColor,
//                           ),
//                         ))
//                   ],
//                 )),
//             Divider(
//               height: 0,
//               thickness: 1,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
