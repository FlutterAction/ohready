import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:secure_hops/Modals/Address/Address.dart';
import 'package:secure_hops/Modals/Cart/Cartitem.dart';
import 'package:secure_hops/Modals/Cart/cartModels.dart';
import 'package:secure_hops/Modals/Customer%20Profile/CustomerProfile.dart';
import 'package:secure_hops/Modals/Resturants/ResturantProfile.dart';
import 'package:secure_hops/Modals/User/user.dart';
import 'package:secure_hops/Shared%20Preferences/share_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyProvider extends ChangeNotifier {


  ///////////////// Saving Location Values ////////////////////
  var savedCurrentPosition ;
  var savedCurrentAddress ;

  ///////////////// APP LANGUAGE ////////////////

  Locale appLocale = Locale('en', '');

  Locale get appLocal => appLocale;

  fetchLocale() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? lang;
    lang = pref.getString('language_code');
    if (lang == null) {
      appLocale = Locale('en', '');
    }
    appLocale = Locale('$lang', '');
  }

  void changeLanguage(Locale local) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (appLocale == local) {
      //If changed language is equal to current language
      print('Do Nothing');
    }
    if (local == Locale('es', '')) {
      appLocale = Locale('es', '');
      await pref.setString('language_code', 'es');
    } else {
      appLocale = Locale('en', '');
      await pref.setString('language_code', 'en');
    }
    notifyListeners();
  }

  ///////////////// ////////////////

  bool? isFirstTime;

  SharedPreferences? pref;
  LoginResponse? loginResponse;
  CustomerProfile? customerProfile;
  List<Address>? addressList;

  List<Item>? itemList;
  List<mdlCartItem> myCart = [];
  ResturantProfileModel? resturantProfile;

  PickResult? selectedPlace;

  saveFirstTime() async {
    pref = await SharedPreferences.getInstance();
    await pref!.setBool('seen', true);
    notifyListeners();
  }

  getFirstTime() async {
    pref = await SharedPreferences.getInstance();
    isFirstTime = pref!.getBool('seen');
    print("$isFirstTime");
    return isFirstTime;
  }

  saveLoginResponse(LoginResponse _loginResponse) async {
    loginResponse = _loginResponse;
    pref = await SharedPreferences.getInstance();
    await pref!.setString('loginResponse', jsonEncode(loginResponse));
    notifyListeners();
  }

  getLoginResponse() async {
    LoginResponse? _loginResponse;
    pref = await SharedPreferences.getInstance();
    String res = pref!.getString('loginResponse').toString();
    var jsonMap = json.decode(res);
    if (jsonMap != null) {
      _loginResponse =
          LoginResponse.fromJson(jsonMap["user"], jsonMap["password"]);
      loginResponse = _loginResponse;
      return loginResponse;
    }
    return _loginResponse;
  }

  saveCustomerProfile(CustomerProfile _customerProfile) {
    customerProfile = _customerProfile;
    notifyListeners();
  }

  saveAddressList(List<Address>? _addressList) async {
    addressList = _addressList;
    pref = await SharedPreferences.getInstance();
    await pref!.setString('addresslist', jsonEncode(addressList));
    notifyListeners();
  }

  getAddressList() async {
    pref = await SharedPreferences.getInstance();
    String res = pref!.getString('addresslist').toString();
    var jsonMap = json.decode(res);
    print(jsonMap);
    // ignore: unnecessary_null_comparison
    if (jsonMap != null) {
      addressList = jsonMap.map((e) => Address.fromJson(e)).toList();
      return addressList;
    }
    return addressList;
  }

  saveItemList(List<Item>? _itemList) {
    itemList = _itemList;
    notifyListeners();
  }

  saveMyCart(
      {required mdlCartItem cartItem,
      required ResturantProfileModel resturantProfilee}) async {
    // if (resturantProfilee.name != resturantProfile!.name) {
    //   myCart.clear();
    // }
    myCart.add(cartItem);
    print("CART LENGTH : ${myCart.length}");
    SavedSharePreference().addToCart(cartItem);
    //   pref = await SharedPreferences.getInstance();
    // await pref!.setString('myCart', jsonEncode(myCart));
    // savingMemory(resturantProfilee);   
    notifyListeners();
  }

  savingMemory(resturantProfile)async{
    //    var myFinalCart = mdlCart.fromJson({      
    //   "restaurantCode":resturantProfile!.restaurantCode,
    //   "lstItems": myCart,
    //   // "subTotal": resturantProfile!.de
    //   // "saleTaxPer": resturantProfile!.saleTaxPercentage,
    //   "shippingCharges":resturantProfile!.freeDeliveryAfter,
    //   // "discount": resturantProfile!.discountedPrice,
    //   // "voucherCode": resturantProfile!.voucherCode,
    //   // "voucherName": resturantProfile!.voucherName,
    //   "currencySymbol": resturantProfile!.currencySymbol,
    //   "currencySymbolHtmlCode": resturantProfile!.currencySymbolHtmlCode,
    //   // "currencySymbol": resturantProfile!.total,
    // });


   
  }

  // getMyCard() async {
  //   List<CartItem>? _mycart;
  //   pref = await SharedPreferences.getInstance();
  //   String res = pref!.getString('myCart').toString();
  //   var jsonMap = json.decode(res);
  //   if (jsonMap != null) {
  //     _mycart = jsonMap;
  //     myCart = _mycart!;
  //     return myCart;
  //   }
  //   return _mycart;
  // }

  saveResturantProfile(ResturantProfileModel _resturantProfile) async {
    resturantProfile = _resturantProfile;
    pref = await SharedPreferences.getInstance();
    await pref!.setString('ResturantProfile', jsonEncode(myCart));
    notifyListeners();
  }

  getResturantProfile() async {
    ResturantProfileModel? _resturantProfile;
    pref = await SharedPreferences.getInstance();
    String res = pref!.getString('ResturantProfile').toString();
    var jsonMap = json.decode(res);
    if (jsonMap != null) {
      _resturantProfile = ResturantProfileModel.fromJson(jsonMap);
      resturantProfile = _resturantProfile;
      return resturantProfile;
    }
    return _resturantProfile;
  }

  saveSelectedPlace(PickResult? _selectedPlace) {
    selectedPlace = _selectedPlace;
    saveLocationInDB(selectedPlace);
    notifyListeners();
  }

  saveLocationInDB(PickResult? pos) async {
    SavedSharePreference().savePositionLat(pos!.geometry!.location.lat);
    SavedSharePreference().savePositionLon(pos.geometry!.location.lng);
    SavedSharePreference().saveAddressLocation(pos.formattedAddress);


  }





  clearValues() async {
    pref = await SharedPreferences.getInstance();
    pref!.clear();
    loginResponse = null;
    customerProfile = null;
    addressList = null;
    itemList = null;
    myCart.clear();
    resturantProfile = null;
    selectedPlace = null;
    notifyListeners();
  }
}
