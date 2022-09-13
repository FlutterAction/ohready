import 'dart:convert';

import 'package:secure_hops/Screens/Profile/Pages/My%20Favorite/Tabs/Resturants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedSharePreference{

  SharedPreferences? pref;

  // sharePreferenced()async{
  //   pref =await SharedPreferences.getInstance();  
  // }

  clearShareprefrence()async{
    pref =await SharedPreferences.getInstance();
    pref!.clear();
  }


  /// Position Saved with Lat and Lon 
  savePositionLat(positionLat)async{
    pref =await SharedPreferences.getInstance();  
    pref!.setDouble('positionLat', positionLat);
    
  }

    savePositionLon(positionLon)async{
    pref =await SharedPreferences.getInstance();  
    pref!.setDouble('positionLon', positionLon);
  }
 Future getPositionLat()async{
    pref =await SharedPreferences.getInstance();      
  return pref!.getDouble('positionLat');
  // print(pref!.getDouble('positionLat'));
  }

 Future getPositionLon()async{
    pref =await SharedPreferences.getInstance();      
    return pref!.getDouble('positionLon');
  }

  /// Saving Address Location with formated Position
  saveAddressLocation(address)async{
    pref = await SharedPreferences.getInstance();  
    pref!.setString('address', address);
  }

   getAddressLocation()async{
     pref = await SharedPreferences.getInstance();  
    return pref!.getString('address');
  }


  setResturantName(String? name)async{
    pref = await SharedPreferences.getInstance();
    pref!.setString("resturantName", '$name');
  }
    getResturantName()async{
    pref = await SharedPreferences.getInstance();
    return  pref!.getString("resturantName");
  }


saveResturantProfile(resturantProfile)async{
    pref = await SharedPreferences.getInstance();
    pref!.setString("resturantProfile", jsonEncode(resturantProfile));
  }



getResturantProfile()async{
    pref = await SharedPreferences.getInstance();
    return jsonDecode(pref!.getString("resturantProfile")!);
  }

  addToCart(items)async{
    pref = await SharedPreferences.getInstance();
    pref!.setString("addToCart", jsonEncode(items));
  }

  updateToCart(cartData)async{
    var pref = await SharedPreferences.getInstance();
  //  var cartData =  await jsonDecode(pref.getString('addToCart')!);
          pref.setString("addToCart", jsonEncode(cartData));
  //  for (var i = 0; i < cartData.length; i++) {
  //       if(cartData[i]['name'] == item.name){      
  //         cartData[i] = item;
  //       print(cartData[i].qnty);
  //       }
  //  }    
  }


  getAddToCart()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
   var cartData = pref.getString('addToCart');
   if(cartData == null){
     return null;
   }else{
     return jsonDecode(cartData);
   }
  //  print(cartData.runtimeType);
    // return cartData ?? null;
  }

}