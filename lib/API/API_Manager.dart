import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:secure_hops/Modals/Address/AddAddressModel.dart';
import 'package:secure_hops/Modals/Address/Address.dart';
import 'package:secure_hops/Modals/Address/City/City.dart';
import 'package:secure_hops/Modals/Address/DeleteAddress.dart';
import 'package:secure_hops/Modals/Address/State/State.dart';
import 'package:secure_hops/Modals/Cuisine/Cuisine.dart';
import 'package:secure_hops/Modals/Cuisine/Food%20Type/food_type_model.dart';
import 'package:secure_hops/Modals/Customer%20Profile/CustomerProfile.dart';
import 'package:secure_hops/Modals/Customer%20Profile/SaveProfile.dart';
import 'package:secure_hops/Modals/Favorites/favorites_model.dart';
import 'package:secure_hops/Modals/Item%20Details/ItemDetails.dart';
import 'package:secure_hops/Modals/Login/Login.dart';
import 'package:secure_hops/Modals/Password/ChangePassword.dart';
import 'package:secure_hops/Modals/Resturants/ResturantProfile.dart';
import 'package:secure_hops/Modals/Resturants/Search%20Resturant.dart';
import 'package:secure_hops/Modals/Signup/signup.dart';
import 'package:secure_hops/Provider/MyProvider.dart';
import 'package:secure_hops/Shared%20Preferences/share_preferences.dart';
import 'package:secure_hops/Widgets/SnackBar.dart';
import 'package:secure_hops/Widgets/loading.dart';
import 'package:secure_hops/Widgets/navigator.dart';

class APIManager {
  Dio dio = Dio();
  String domain = "https://www.ohready.app";
  http.Client client = http.Client();




  ////////// Cusine List //////////////
  static Future<List<Cuisine>>? cuisineList;
  static Future<List<FoodTypeModel>>? foodTypeList;

  

  ////////////////////////// API FUNCTIONS //////////////////////

  /////////////////// SIGN UP ////////////////////

  Future<http.Response> signup(BuildContext context,
      {@required String? email,
      @required String? password,
      @required String? username}) async {
    return await client
        .post(Uri.parse('$domain/api/CustomersApi/signup'),
            body: Signup(
              email: email,
              userName: username,
              pass: password,
              firstName: '',
              lastName: '',
              accountType: 'email',
              mobile: '',
              from: 'App',
              facebookId: '',
              googleId: '',
            ).toJson())
        .timeout(Duration(seconds: 15));
  }

  Future<http.Response> singin(
    BuildContext context, {
    @required String? userName,
    @required String? password,
  }) async {
    return await client
        .post(Uri.parse('$domain/api/CustomersApi/Login'),
            body: LoginModel(username: userName, password: password).toJson())
        .timeout(Duration(seconds: 15));
  }

  getUserprofile(
    BuildContext context, {
    email,
    pass,
  }) async {
    return await client
        .post(Uri.parse('$domain/api/CustomersApi/getCustomerProfile'),
            body: {'email': email, 'pass': pass})
        .timeout(Duration(seconds: 15))
        .then((response) async {
          print(response.body);
          //
          var jsonMap = json.decode(response.body);
          CustomerProfile customerProfile = CustomerProfile.fromJson(jsonMap);

          // save profile to shared preferences
          MyProvider provider = Provider.of<MyProvider>(context, listen: false);
          provider.saveCustomerProfile(customerProfile);

          //return customer profile
          return customerProfile;
        });
  }

  ///////////////////SAVE PROFILE///////////////////////
  Future<Response> saveprofile(BuildContext context,
      {@required String? email,
      @required String? pass,
      @required String? mobileno,
      @required String? firstName,
      @required String? lastname,
      @required String? gender,
      @required String? dob,
      @required File? img}) async {
    var multiPart; //declare varible for multipartfile

    //image
    if (img != null) {
      multiPart = await MultipartFile.fromFile(img.path,
          filename: img.path.split('/').last);
    }

    //initialize form data
    FormData formData = FormData.fromMap(SaveProfile(
            email: email,
            pass: pass,
            firstName: firstName,
            lastname: lastname,
            gender: gender,
            // ignore: unnecessary_null_comparison
            img: img == null ? "" : multiPart,
            dob: dob,
            mobileno: mobileno)
        .toJson());

    // call save customer profile api
    return dio
        .post('$domain/api/CustomersApi/saveCustomerProfile', data: formData)
        .timeout(Duration(seconds: 15));
  }

  ////////////////////Change Password//////////////////////

  Future<http.Response> changepass(BuildContext context,
      {@required String? oldpass,
      @required String? newpass,
      @required int? usercode}) async {
    return await client
        .post(Uri.parse('$domain/api/CustomersApi/changePassword'),
            body: ChangePassword(
                    oldpass: oldpass,
                    newpass: newpass,
                    usercode: usercode.toString())
                .toJson())
        .timeout(Duration(seconds: 15));
  }

  ////////////////////SHOW ADDRESS//////////////////

  getAddress(BuildContext context,
      {@required String? userName, @required String? userPassword}) async {
    return await client
        .post(Uri.parse('$domain/api/CustomersApi/getCustomerAddresses'),
            body: {"userName": userName, "userPass": userPassword})
        .timeout(Duration(seconds: 15))
        .then((response) {
          print(response.body);
          List<Address> addressList = (json.decode(response.body) as List)
              .map((e) => Address.fromJson(e))
              .toList();
          MyProvider provider = Provider.of<MyProvider>(context, listen: false);
          provider.saveAddressList(addressList);
        });
  }

  /////////////////////////////ADD ADDRESS////////////////////////

  Future<http.Response> addAddress(BuildContext context,
      {@required String? userName,
      @required String? userPassword,
      @required String? placeName,
      @required String? phoneNo,
      @required String? country,
      @required String? state,
      @required String? city,
      @required String? area,
      @required String? zip,
      @required String? newAddress,
      @required String? lat,
      @required String? long,
      @required String? update,
      @required String? addressCode}) async {
    return await client
        .post(Uri.parse('$domain/api/CustomersApi/saveCustomerAddress'),
            body: AddAdressModel(
                    userName: userName,
                    userPassword: userPassword,
                    newAddress: newAddress,
                    addressCode: addressCode,
                    area: area,
                    city: city,
                    country: country,
                    placeName: placeName,
                    lat: lat,
                    long: long,
                    phoneNo: phoneNo,
                    state: state,
                    update: update,
                    zip: zip)
                .toJson())
        .timeout(Duration(seconds: 15))
        .catchError((e) {
      return CustomSnackBar.show(context, '${e.message}');
    });
  }

  //////////////////////DELETE ADDRESS////////////

  deleteAddress(BuildContext context,
      {@required String? username,
      @required String? userpass,
      @required String? addresscode}) async {
    showLoadingDialog(context);
    return await client
        .post(Uri.parse('$domain/api/CustomersApi/deleteCustomerAddress'),
            body: DeleteAddress(
                    userName: username,
                    userPass: userpass,
                    addressCode: addresscode)
                .toJson())
        .then((response) {
      pop(context);
      var result = json.decode(response.body);
      if (result['result'] == 'true') {
        getAddress(context, userName: username, userPassword: userpass);
        CustomSnackBar.show(context, 'Address deleted successfully.');
      }
    }).catchError((e) {
      pop(context);
      CustomSnackBar.show(context, 'Address not found.');
    });
  }

  //////////////////////Get state////////////

  Future<List<StateModel>> getstate(BuildContext context) async {
    return await client.post(
        Uri.parse('$domain/general/getStatesListByCountryCode'),
        body: {'countryCode': '1'}).then((response) async {
      print("State List:  ${response.body}");
      List<StateModel> stateList = (json.decode(response.body) as List)
          .map((e) => StateModel.fromJson(e))
          .toList();
      return stateList;
    });
  }

  //////////////////////Get City////////////

  Future<List<City>> getcity(BuildContext context,
      {@required String? stateCode}) async {
    return await client.post(
        Uri.parse('$domain/general/getCitiesListByStateCode'),
        body: {'stateCode': stateCode}).then((response) async {
      print("City List:  ${response.body}");
      List<City> cityList = (json.decode(response.body) as List)
          .map((e) => City.fromJson(e))
          .toList();
      return cityList;
    });
  }

  ////////////////////// Search Resturent ////////////

  Future<ResturantList> searchResturant(BuildContext context,
      {int cusineCode = -1, int foodtypeCode = -1}) async {
    var latitude = await SavedSharePreference().getPositionLat();
    var longitude = await SavedSharePreference().getPositionLon();
    MyProvider provider = Provider.of(context, listen: false);
    double lat, lng;

    if (provider.selectedPlace != null) {
      lat = provider.selectedPlace!.geometry!.location.lat;
      lng = provider.selectedPlace!.geometry!.location.lng;
    } else {
      lat = latitude;
      lng = longitude;
      // lat = 32.16617666209516;
      // lng = 74.19265068354981;
    }
    
    if (foodtypeCode == -1)
      return await client
          .get(
            Uri.parse(
                '$domain/api/CustomersApi/searchRestaurant?lat=$lat&lng=$lng&cuisineCode=$cusineCode'),
          )
          
          .then((response) async {
        print("Restureant List:  ${response.body}");
        ResturantList resturantList = resturantListFromJson(response.body);
        return resturantList;
      }).catchError((e) {
        print("${e}");
      });


      else if (cusineCode == -1)
      return await client
          .get(
            Uri.parse(
                '$domain/api/CustomersApi/searchRestaurant?lat=$lat&lng=$lng&foodTypeCode=$foodtypeCode'),
          )
          
          .then((response) async {
        print("Restureant List:  ${response.body}");
        ResturantList resturantList = resturantListFromJson(response.body);
        return resturantList;
      }).catchError((e) {
        print("${e}");
      });


        else
      return await client
          .get(
            Uri.parse(
                '$domain/api/CustomersApi/searchRestaurant?lat=$lat&lng=$lng&foodTypeCode=$foodtypeCode&cuisineCode=$cusineCode'),
          )
          
          .then((response) async {
        print("Restureant List:  ${response.body}");
        ResturantList resturantList = resturantListFromJson(response.body);
        return resturantList;
      }).catchError((e) {
        print("${e}");
      });
  }

  Future<ResturantProfileModel> getResturantProfile(BuildContext context,
      {@required String? resturantId}) async {
    return await client
        .get(
          Uri.parse(
              '$domain/api/CustomersApi/Restaurantprofile?id=$resturantId'),
        )
        
        .then((response) async {
      print("Resturant Profile:  ${response.body}");
      ResturantProfileModel resturantProfile =
          ResturantProfileModel.fromJson(json.decode(response.body));
      return resturantProfile;
    }).catchError((e) {
      print("$e");
    });
  }

  Future<ItemDetailsModel> getItemDetails(BuildContext context,
      {@required String? itemId}) async {
    return await client
        .get(
          Uri.parse('$domain/api/CustomersApi/getItemDetails?id=$itemId'),
        )
        
        .then((response) async {
      // print("ITEM DETAILS:  ${response.body}");
      log(response.body);
      ItemDetailsModel itemDetailsList =
          ItemDetailsModel.fromJson(json.decode(response.body));
      return itemDetailsList;
    }).catchError((Object e) {
      print("$e");
    });
  }

  //////////////////// Saving Favorites /////////////
  ///
  static Map<String, dynamic> allFavorites = {
    "lstRestaurant": [],
    "lstItem": []
  };

  //// Selected Cusine and FoodType CODE
  ///
  static int? cusineCode = -1;
  static int? foodTypeCode = -1;

  //////////////////// Get Favorites /////////////
  ///
  Future<GetFavorites> getFavoritesItems(BuildContext context,
      {@required String? email, @required String? password}) async {
    return await client
        .get(
          Uri.parse(
              '$domain/api/customersApi/getFavorite?email=$email&pass=$password'),
        )
        
        .then((response) async {
      print("Favorites DETAILS:  ${response.body}");
      GetFavorites getFavoritesList =
          GetFavorites.fromJson(json.decode(response.body));
      return getFavoritesList;
    }).catchError((Object e) {
      print("$e");
    });
  }

  //////////////////// Add Favorites Item /////////////
  ///
  Future addFavorites(BuildContext context,
      {@required String? email,
      @required String? password,
      @required int? itemCode}) async {
    return await client
        .post(
          Uri.parse(
              '$domain/api/customersApi/addToFavorite?email=$email&pass=$password&itemCode=$itemCode'),
        )
        
        .then((response) async {
      print("Favorites ADDED :  ${response.body}");
      return response.body;
    }).catchError((Object e) {
      print("$e");
    });
  }

  //////////////////// Remove Favorites Item /////////////
  ///
  Future removeFavorites(BuildContext context,
      {@required String? email,
      @required String? password,
      @required int? itemCode}) async {
    return await client
        .post(
          Uri.parse(
              '$domain/api/customersApi/removeFromFavorite?email=$email&pass=$password&itemCode=$itemCode'),
        )
        
        .then((response) async {
      print("Favorites Removed :  ${response.body}");
      return response.body;
    }).catchError((Object e) {
      print("$e");
    });
  }

  //////////////////// Add Favorites Restaurant /////////////
  ///
  Future addFavoritesRestaurant(BuildContext context,
      {@required String? email,
      @required String? password,
      @required int? restaurantCode}) async {
    return await client
        .post(
          Uri.parse(
              '$domain/api/customersApi/addToFavorite?email=$email&pass=$password&restaurantCode=$restaurantCode'),
        )
        
        .then((response) async {
      print("Favorites ADDED :  ${response.body}");
      return response.body;
    }).catchError((Object e) {
      print("$e");
    });
  }

  //////////////////// Remove Favorites Restaurant /////////////
  ///
  Future removeFavoritesRestaurant(BuildContext context,
      {@required String? email,
      @required String? password,
      @required int? restaurantCode}) async {
    return await client
        .post(
          Uri.parse(
              '$domain/api/customersApi/removeFromFavorite?email=$email&pass=$password&restaurantCode=$restaurantCode'),
        )
        
        .then((response) async {
      print("Favorites Removed :  ${response.body}");
      return response.body;
    }).catchError((Object e) {
      print("$e");
    });
  }

  //////////////////// GET Cuisine //////////////////

  Future<List<Cuisine>> getCuisine(
    BuildContext context,
  ) async {
    return await client
        .post(
          Uri.parse('$domain/general/getCuisinesList'),
        )
        .timeout(Duration(seconds: 15))
        .then((response) {
      print(response.body);
      List<Cuisine> cuisineList = (json.decode(response.body) as List)
          .map((e) => Cuisine.fromJson(e))
          .toList();
      return cuisineList;
    });
  }

  //////////////////// GET Food Type //////////////////

  Future<List<FoodTypeModel>> getFoodType(
    BuildContext context,
  ) async {
    return await client
        .post(
          Uri.parse('$domain/general/getFoodTypeList'),
        )
        .timeout(Duration(seconds: 15))
        .then((response) {
      print(response.body);
      List<FoodTypeModel> foodTypeList = (json.decode(response.body) as List)
          .map((e) => FoodTypeModel.fromJson(e))
          .toList();
      return foodTypeList;
    });
  }


    //////////////////// Add Favorites Item /////////////
  ///
  Future orderHistory(BuildContext context,
      {@required String? email,
      @required String? password,}) async {
    return await client
        .get(
          Uri.parse(
              '$domain/api/CustomersApi/getUserOrders?email=$email&pass=$password'),
        )
        .timeout(Duration(seconds: 15))
        .then((response) async {
      print("Order History : ${response.body}");
      return response.body;
    }).catchError((Object e) {
      print("$e");
    });
  }
}
