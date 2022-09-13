import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:provider/provider.dart';
import 'package:secure_hops/Components/constants.dart';
import 'package:secure_hops/Provider/MyProvider.dart';
import 'package:secure_hops/Screens/Home%20Page/home.dart';
import 'package:secure_hops/Shared%20Preferences/share_preferences.dart';
import 'package:secure_hops/Widgets/navigator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Screens/Home Page/Empty Home/EmptyHome.dart';
import '../../Screens/Home/home.dart';

class MyGoogleMaps extends StatefulWidget {
  final String? buttonText;   
  final Function()? onPressed;
  final LatLng? currentPosition;
  const MyGoogleMaps(
      {@required this.onPressed,
      @required this.currentPosition,
      @required this.buttonText});

  @override
  _MyGoogleMapsState createState() => _MyGoogleMapsState();
}

class _MyGoogleMapsState extends State<MyGoogleMaps> {
  PickResult? selectedPlace;
  Position? position;
  GoogleMapController? _controller;
  @override
  Widget build(BuildContext context) {
    return PlacePicker(
      apiKey: mapsAPIKey,
      initialPosition: widget.currentPosition!,
      useCurrentLocation: true,
      selectInitialPosition: true,
      onMapCreated: _onMapCreated,
      enableMyLocationButton: true,
      usePlaceDetailSearch: true,
      onPlacePicked: (result) {
        selectedPlace = result;
        // print(selectedPlace!.geometry!.location.lat);
        // print(selectedPlace!.geometry!.location.lng);
        pop(context);
        // pushAndRemoveUntil(context, Home());
        setState(() {});
      },
      forceSearchOnZoomChanged: true,
      automaticallyImplyAppBarLeading: false,
      selectedPlaceWidgetBuilder:
          (_, selectedPlace1, state, isSearchBarFocused) {
        print("state: $state, isSearchBarFocused: $isSearchBarFocused");        

        return isSearchBarFocused
            ? Container()
            : FloatingCard(
                bottomPosition:
                    10.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                leftPosition: 10.0,
                rightPosition: 10.0,
                width: 500,
                borderRadius: BorderRadius.circular(12.0),
                child: state == SearchingState.Searching
                    ? Center(child: CircularProgressIndicator())
                    : pickHereButton(selectedPlace1),
              );
      },
      pinBuilder: (context, state) {
        if (state == PinState.Idle) {
          return Icon(
            Icons.location_pin,
            color: Colors.red,
          );
        } else {
          return Icon(
            Icons.location_pin,
            color: Colors.red,
          );
        }
      },
    );
  }
       getLocationInDB()async{
      MyProvider provider = Provider.of(context, listen: false);
      var lat = await SavedSharePreference().getPositionLat();
      var lon = await SavedSharePreference().getPositionLon();
      // provider.savedCurrentPosition
      provider.savedCurrentPosition = LatLng(lat, lon);
      provider.savedCurrentAddress = await SavedSharePreference().getAddressLocation();
  }


  pickHereButton(PickResult? selectedPlace) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      MyProvider provider = Provider.of(context, listen: false);
      provider.saveSelectedPlace(selectedPlace);
      getLocationInDB();
    });


  


    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("${selectedPlace!.formattedAddress!}"),
          SizedBox(
            height: 5,
          ),
          ElevatedButton(
            child: Text(widget.buttonText!),
            onPressed: (){
              MyProvider provider = Provider.of<MyProvider>(context, listen: false);
              screenIndex = 0;
              provider.loginResponse != null ? pushAndRemoveUntil(context, MyHomePage()) :  pushAndRemoveUntil(context, AppHomePage());
              setState(() {
                
              });
                // pushAndRemoveUntil(context, Home());

            },
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _controller!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position!.latitude, position!.longitude), zoom: 8),
      ),
    );
  }
}
