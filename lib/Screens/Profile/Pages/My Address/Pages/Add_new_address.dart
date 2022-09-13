import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:provider/provider.dart';
import 'package:secure_hops/API/API_Manager.dart';
import 'package:secure_hops/Components/constants.dart';
import 'package:secure_hops/Modals/Address/City/City.dart';
import 'package:secure_hops/Modals/Address/State/State.dart';
import 'package:secure_hops/Provider/MyProvider.dart';
import 'package:secure_hops/Widgets/AppBar.dart';
import 'package:secure_hops/Widgets/Google%20Maps/Google%20Maps.dart';
import 'package:secure_hops/Widgets/SnackBar.dart';
import 'package:secure_hops/Widgets/button.dart';
import 'package:secure_hops/Widgets/loading.dart';
import 'package:secure_hops/Widgets/navigator.dart';

class AddNewAddress extends StatefulWidget {
  @override
  _AddNewAddressState createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  final TextEditingController placeName = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController zip = TextEditingController();
  final TextEditingController address = TextEditingController();

  PickResult? selectedPlace;
  LatLng? currentPosition;

  List<StateModel> stateMenu = [];
  List<City> cityMenu = [];

  bool isLoad = true;
  String? city, state;

  @override
  void initState() {
    getState();
    _getCurrentLocation();
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: appBar(context, title: 'Add New Address'),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  box,
                  placeField(),
                  box,
                  mobileField(),
                  box,
                  stateFormField(),
                  box,
                  cityFormField(),
                  box,
                  zipField(),
                  box,
                  addressField(),
                  box,
                  Row(
                    children: [
                      TextButton.icon(
                          onPressed: isLoad == false
                              ? () {
                                  MyProvider provider = Provider.of<MyProvider>(
                                      context,
                                      listen: false);
                                  //
                                  push(
                                      context,
                                      MyGoogleMaps(
                                        onPressed: () {
                                          //close screen
                                          Navigator.of(context).pop();
                                          setState(() {
                                            selectedPlace =
                                                provider.selectedPlace;
                                            address.text = selectedPlace!
                                                .formattedAddress!;
                                          });
                                        },
                                        currentPosition: currentPosition,
                                        buttonText: 'Pick Here',
                                      ));
                                }
                              : null,
                          icon: Icon(Icons.location_on),
                          label: Text(
                            'Use Currrent Location',
                            style: TextStyle(color: Colors.black87),
                          )),
                    ],
                  ),
                  for (int i = 0; i < 2; i++) box,
                  isLoad
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                              Text('Fecthing your location...'),
                              SizedBox(width: 20),
                              Center(
                                child: CircularProgressIndicator(),
                              )
                            ])
                      : Container(),
                  for (int i = 0; i < 3; i++) box,
                  MyButton(
                      text: 'SAVE',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          saveNewAddress();
                        }
                      })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget box = SizedBox(
    height: 10,
  );

  placeField() {
    return TextFormField(
        controller: placeName,
        decoration: InputDecoration(
          hintText: "Enter place",
          hintStyle: TextStyle(color: Colors.grey),
          labelText: "Place",
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your place name';
          }
        });
  }

  mobileField() {
    return TextFormField(
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          hintText: "Enter mobile number",
          hintStyle: TextStyle(color: Colors.grey),
          labelText: "Mobile",
        ),
        controller: phoneNo,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter mobile number';
          }
        });
  }

  Widget stateFormField() {
    return DropdownButtonFormField(
      onChanged: (value) {
        state = value.toString();
        getCity(state!);
      },
      validator: (value) {
        if (value == null) {
          return "Please select a State";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "State",
        hintText: "Select State",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      items: stateMenu.map((state) {
        return DropdownMenuItem(
          child: Text(state.stateName.toString()),
          value: state.stateCode,
        );
      }).toList(),
    );
  }

  Widget cityFormField() {
    return DropdownButtonFormField(
      onChanged: (value) {
        setState(() {
          city = value.toString();
        });
      },
      validator: (value) {
        if (value == null) {
          return "Please select a City";
        }
      },
      decoration: InputDecoration(
        labelText: "City",
        hintText: "Select city",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      items: cityMenu.map((city) {
        return DropdownMenuItem(
          child: Text(city.cityName.toString()),
          value: city.cityCode,
        );
      }).toList(),
    );
  }

  zipField() {
    return TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "Enter zip-code",
          hintStyle: TextStyle(color: Colors.grey),
          labelText: "Zip-Code",
        ),
        controller: zip,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter zip-code';
          }
        });
  }

  addressField() {
    return TextFormField(
        decoration: InputDecoration(
          hintText: "Enter address",
          hintStyle: TextStyle(color: Colors.grey),
          labelText: "New Address",
        ),
        controller: address,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter new Address';
          }
        });
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        LatLng pos = LatLng(position.latitude, position.longitude);
        currentPosition = pos;
        isLoad = false;
      });
    });
  }

  getState() {
    return APIManager().getstate(context).then((value) {
      setState(() {
        stateMenu = value;
      });
    });
  }

  getCity(String stateCode) {
    return APIManager().getcity(context, stateCode: stateCode).then((value) {
      setState(() {
        cityMenu = value;
      });
    });
  }

  saveNewAddress() {
    showLoadingDialog(context);
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);

    return APIManager()
        .addAddress(context,
            userName: provider.loginResponse!.user!.email,
            userPassword: provider.loginResponse!.password,
            placeName: placeName.text,
            phoneNo: phoneNo.text,
            country: '1',
            state: state,
            city: city,
            area: '',
            zip: zip.text,
            newAddress: address.text,
            lat: currentPosition!.latitude.toString(),
            long: currentPosition!.longitude.toString(),
            update: 'false',
            addressCode: '1')
        .then((response) async {
      pop(context); // close loading diaog

      // decode result from response
      var jspmMap = json.decode(response.body);
      print(jspmMap);

      // result is true than Address Registered
      if (jspmMap['result'] == 'true') {
        // get address
        APIManager().getAddress(context,
            userName: provider.loginResponse!.user!.userName,
            userPassword: provider.loginResponse!.password);

        //show snackBar
        CustomSnackBar.show(context, 'Address Registered!');
      }

      // else show errpr
      else {
        CustomSnackBar.show(context, 'User not exits!');
      }
    });
  }
}
