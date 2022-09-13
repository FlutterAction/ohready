import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart' as locations;
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:secure_hops/Modals/Favorites/favorites_model.dart';
import 'package:secure_hops/Screens/Home/home.dart';
import 'package:secure_hops/Screens/Profile/profile.dart';
import 'package:secure_hops/Components/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../API/API_Manager.dart';
import '../../Provider/MyProvider.dart';
import '../../Shared Preferences/share_preferences.dart';
import '../../Widgets/Google Maps/Google Maps.dart';
import '../../Widgets/navigator.dart';
import '../Order/order.dart'; 
import 'package:permission_handler/permission_handler.dart';
import '../Search/search.dart';

List<Widget> buildScreens = [Home(), Search(), Order(true), Profile()];

int screenIndex = 0;

class MyHomePage extends StatefulWidget {
  // final index;
  // MyHomePage([this.index]);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    initFun();
    getUser();
    getFavoritesItems();
  }

  
  initFun() async {
    print("Init");
    MyProvider provider = Provider.of(context, listen: false);
    var lat = await SavedSharePreference().getPositionLat();
    var lon = await SavedSharePreference().getPositionLon();
    var address = await SavedSharePreference().getAddressLocation();
    if (lat == null && lon == null && address == null) {
      print("Right");
      if (await Permission.location.isGranted) {
        _getCurrentLocation();
      } else {
        push(
            context,
            MyGoogleMaps(
              onPressed: () async {
                pop(context);
                // await getResturants();
              },
              currentPosition: provider.savedCurrentPosition == null
                  ? LatLng(40.4637, 3.7492)
                  : provider.savedCurrentPosition,
              buttonText: 'Get Resturants',
            ));

        // setState(() {
        //   isLoad = false;
        // });
      }
    } else {
      print("Wrong");
      // var lat = await SavedSharePreference().getPositionLat();
      // var lon = await SavedSharePreference().getPositionLon();
      // provider.savedCurrentPosition
      provider.savedCurrentPosition = LatLng(lat, lon);
      provider.savedCurrentAddress =
          address;
      // setState(() {
      //   isLoad = false;
      // });
    }
  }



  // getResturants() {
  //   setState(() {
      // futureResturantList = APIManager().searchResturant(
  //       context,
  //     );
  //   });
  // }



  var location = locations.Location();
  var _permissionGranted;

  Future<void> _checkPermissions() async {
    final locations.PermissionStatus permissionGrantedResult =
        await location.hasPermission();
    _getCurrentLocation();
    setState(() {
      _permissionGranted = permissionGrantedResult;
    });
  }

  Future _checkGps() async {
    if (!await location.serviceEnabled()) {
      await location.requestService();
    }
    _checkPermissions();
  }

  _getCurrentLocation() async {
    MyProvider provider = Provider.of(context, listen: false);
    if (_permissionGranted == locations.PermissionStatus.granted) {
      var loc = await location.getLocation();
      LatLng pos = LatLng(loc.latitude!, loc.longitude!);
      // currentPosition = pos;
      SavedSharePreference().savePositionLat(pos.latitude);
      SavedSharePreference().savePositionLon(pos.longitude);

      // var lat = await SavedSharePreference().getPositionLat();
      // var lon = await SavedSharePreference().getPositionLon();

      provider.savedCurrentPosition = pos;
      _getAddressFromLatLng(pos);
      // setState(() {
      //   isLoad = false;
      // });
    } else {
      _checkGps();
    }
  }

  _getAddressFromLatLng(LatLng pos) async {
    MyProvider provider = Provider.of(context, listen: false);
    // Geocoder
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(pos.latitude, pos.longitude);

      Placemark place = placemarks[0];

      provider.savedCurrentAddress =
          "${place.locality}, ${place.administrativeArea}, ${place.country}";
      SavedSharePreference().saveAddressLocation(provider.savedCurrentAddress);

      // currentLocation = await SavedSharePreference().getAddressLocation();
      setState(() {});
    } catch (e) {
      print(e);
    }
  }




  

  // List<LstRestaurant>? lstRestaurant = [];
  // List<LstItem>? lstItem = [];

  getFavoritesItems() {
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);
    APIManager()
        .getFavoritesItems(context,
            email: provider.loginResponse!.user!.email,
            password: provider.loginResponse!.password)
        .then((response) {
      List<LstRestaurant>? lstRestaurant = response.lstRestaurant;
      List<LstItem>? lstItem = response.lstItem;

      APIManager.allFavorites['lstRestaurant'] = lstRestaurant;
      APIManager.allFavorites['lstItem'] = lstItem;
      // setState(() {});
    });
  }

Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () {
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else if (Platform.isIOS) {
                    exit(0);
                  }
                },
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }


  @override
  Widget build(BuildContext context) {
    // PersistentTabController _controller =
    //     PersistentTabController(initialIndex: widget.index != null ?widget.index :0);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: buildScreens[screenIndex],
        bottomNavigationBar:screenIndex == 2 ? Container(height: 0,):  BottomAppBar(
          child: new BottomNavigationBar(
              currentIndex: screenIndex,
              onTap: (int index) {
                // Handle for Favourites

                setState(() {
                  screenIndex = index;
                  
                });
              },
              type: BottomNavigationBarType.fixed,
              items: [
                new BottomNavigationBarItem(
                    backgroundColor: Colors.white,
                    icon: screenIndex == 0
                        ? new Icon(
                            Icons.home,
                            color: kPrimaryColor,
                          )
                        : new Icon(
                            Icons.home,
                            color: Colors.black38,
                          ),
                          label: screenIndex == 0  ? "Home" :  "Home",
                    // title: screenIndex == 0
                    //     ? new Text("Home",
                    //         style: TextStyle(color: kPrimaryColor, fontSize: 10))
                    //     : new Text("Home",
                    //         style:
                    //             TextStyle(color: Colors.black38, fontSize: 10)
                    //             )
                                ),
                new BottomNavigationBarItem(
                    icon: screenIndex == 1
                        ? new Icon(
                            Icons.search,
                            color: kPrimaryColor,
                          )
                        : new Icon(
                            Icons.search,
                            color: Colors.black38,
                          ),
                          label: screenIndex == 1  ? "Search" :  "Search",
                    // title: screenIndex == 1
                    //     ? new Text("Search",
                    //         style: TextStyle(color: kPrimaryColor, fontSize: 10))
                    //     : new Text("Search",
                    //         style:
                    //             TextStyle(color: Colors.black38, fontSize: 10))
                                ),
                new BottomNavigationBarItem(
                    icon: screenIndex == 2
                        ? 
                        new Icon(
                            Icons.backpack,
                            color: kPrimaryColor,
                          )
                        :
                         new Icon(
                            Icons.backpack,
                            color: Colors.black38,
                          ),
                          label: screenIndex == 2  ? "Order" :  "Order",
                    // title: screenIndex == 2
                    //     ? new Text("Order",
                    //         style: TextStyle(color: kPrimaryColor))
                    //     : new Text("Order",
                    //         style: TextStyle(color: Colors.black38))
                            ),
                new BottomNavigationBarItem(
                    icon: screenIndex == 3
                        ?
                         Icon(
                            Icons.person,
                            color: kPrimaryColor,
                          )
                        : new Icon(
                            Icons.person,
                            color: Colors.black38,
                          ),
                          label: screenIndex == 3  ? "Profile" :  "Profile",
                    // title: screenIndex == 3
                    //     ? new Text("Profile",
                    //         style: TextStyle(color: kPrimaryColor, fontSize: 10))
                    //     : new Text("Profile",
                    //         style:
                    //             TextStyle(color: Colors.black38, fontSize: 10))
                                ),
              ]),
        
        ),

        // body: PersistentTabView(
        //   context,
        //   controller: _controller,
        //   screens: _buildScreens(),
        //   items: _navBarsItems(),
        //   confineInSafeArea: true,
        //   backgroundColor: Colors.white, // Default is Colors.white.
        //   handleAndroidBackButtonPress: true, // Default is true.
        //   resizeToAvoidBottomInset:
        //       true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        //   stateManagement: true, // Default is true.
        //   hideNavigationBarWhenKeyboardShows:
        //       true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        //   decoration: NavBarDecoration(
        //     borderRadius: BorderRadius.circular(10.0),
        //     colorBehindNavBar: Colors.white,
        //   ),
        //   popAllScreensOnTapOfSelectedTab: true,
        //   popActionScreens: PopActionScreensType.all,
        //   itemAnimationProperties: ItemAnimationProperties(
        //     // Navigation Bar's items animation properties.
        //     duration: Duration(milliseconds: 200),
        //     curve: Curves.ease,
        //   ),
        //   screenTransitionAnimation: ScreenTransitionAnimation(
        //     // Screen transition animation on change of selected tab.
        //     animateTabTransition: true,
        //     curve: Curves.ease,
        //     duration: Duration(milliseconds: 200),
        //   ),
        //   navBarStyle:
        //       NavBarStyle.style6, // Choose the nav bar style with this property.
        // ),
      ),
    );
  }

  // List<PersistentBottomNavBarItem> _navBarsItems() {
  //   return [
  //     PersistentBottomNavBarItem(
  //       icon: Icon(Icons.home),
  //       title: ("Home"),
  //       activeColorPrimary: kkPrimaryColor,
  //       inactiveColorPrimary: CupertinoColors.systemGrey,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(Icons.search),
  //       title: ("Search"),
  //       activeColorPrimary: kkPrimaryColor,
  //       inactiveColorPrimary: CupertinoColors.systemGrey,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(Icons.backpack),
  //       title: ("Order"),
  //       activeColorPrimary: kkPrimaryColor,
  //       inactiveColorPrimary: CupertinoColors.systemGrey,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(Icons.person),
  //       title: ("Profile"),
  //       activeColorPrimary: kkPrimaryColor,
  //       inactiveColorPrimary: CupertinoColors.systemGrey,
  //     ),
  //   ];
  // }

  getUser() {
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);    
    // get user
    APIManager().getUserprofile(context,
        email: provider.loginResponse!.user!.email,
        pass: provider.loginResponse!.password);
    // get address
    APIManager().getAddress(context,
        userName: provider.loginResponse!.user!.userName,
        userPassword: provider.loginResponse!.password);
  }
}
