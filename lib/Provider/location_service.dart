// import 'package:flutter/src/widgets/framework.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:secure_hops/Shared%20Preferences/share_preferences.dart';
// import 'package:secure_hops/Widgets/Google%20Maps/Google%20Maps.dart';
// import 'package:secure_hops/Widgets/navigator.dart';

// class LocationServices{
//   BuildContext get context => null;


//   initFun() async {
//     var lat = await SavedSharePreference().getPositionLat();
//     var lon = await SavedSharePreference().getPositionLon();
//     var address = await SavedSharePreference().getAddressLocation();
//     if (lat == null && lon == null && address == null) {
//       if (await Permission.location.isGranted) {
//         _getCurrentLocation();
//       } else if (await Permission.location.status.isDenied) {
//         // await Permission.location.request().then((val){
//         //   if(val.isGranted){
//         //   }
//         //   else{

//         // if(val.isDenied)
//         push(
//             context,
//             MyGoogleMaps(
//               onPressed: () async {
//                 pop(context);
//                 await getResturants();
//               },
//               currentPosition: currentPosition == null
//                   ? LatLng(40.4637, 3.7492)
//                   : currentPosition,
//               buttonText: 'Get Resturants',
//             ));

//         setState(() {
//           isLoad = false;
//         });
//         // }
//         // });
//       }
//       // else {
//       //   await Permission.location.request();
//       //   _getCurrentLocation();
//       // }
//     } else {
//       var lat = await SavedSharePreference().getPositionLat();
//       var lon = await SavedSharePreference().getPositionLon();

//       currentPosition = LatLng(lat, lon);
//       currentLocation = await SavedSharePreference().getAddressLocation();
//       setState(() {
//         isLoad = false;
//       });
//     }
//   }

//   var location = locations.Location();
//   var _permissionGranted;


//   Future<void> _checkPermissions() async {
//     final locations.PermissionStatus permissionGrantedResult =
//         await location.hasPermission();
//     _getCurrentLocation();
//     setState(() {
//       _permissionGranted = permissionGrantedResult;
//     });
//   }

//   Future _checkGps() async {
//     if (!await location.serviceEnabled()) {
//       await location.requestService();
//     }
//     _checkPermissions();
//   }

//   _getCurrentLocation() async {
//     if (_permissionGranted == locations.PermissionStatus.granted) {
//       var loc = await location.getLocation();
//       LatLng pos = LatLng(loc.latitude!, loc.longitude!);
//       // currentPosition = pos;
//       SavedSharePreference().savePositionLat(pos.latitude);
//       SavedSharePreference().savePositionLon(pos.longitude);

//       // var lat = await SavedSharePreference().getPositionLat();
//       // var lon = await SavedSharePreference().getPositionLon();

//       currentPosition = pos;
//       _getAddressFromLatLng(pos);
//       setState(() {
//         isLoad = false;
//       });
//     } else {
//       _checkGps();
//     }
//   }

//   _getAddressFromLatLng(LatLng pos) async {
//     // Geocoder
//     try {
//       List<Placemark> placemarks =
//           await placemarkFromCoordinates(pos.latitude, pos.longitude);

//       Placemark place = placemarks[0];

//       currentLocation =
//           "${place.locality}, ${place.administrativeArea}, ${place.country}";
//       SavedSharePreference().saveAddressLocation(currentLocation);

//       // currentLocation = await SavedSharePreference().getAddressLocation();
//       setState(() {});
//     } catch (e) {
//       print(e);
//     }
//   }

// }