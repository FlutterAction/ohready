import 'dart:convert';

ResturantProfileModel resturantProfileModelFromJson(String str) =>
    ResturantProfileModel.fromJson(json.decode(str));

String resturantProfileModelToJson(ResturantProfileModel data) =>
    json.encode(data.toJson());

class ResturantProfileModel {
  ResturantProfileModel({
    this.restaurantCode,
    this.name,
    this.address,
    this.mobile,
    this.banner,
    this.logo,
    this.rating,
    this.totalRating,
    this.locLat,
    this.locLng,
    this.deliveryCharges,
    this.freeDeliveryAfter,
    this.currencySymbol,
    this.currencySymbolHtmlCode,
    this.foodTypes,
    this.menuList,
    this.timingList,
    this.isAddedtoWishList,
    this.lstGalleryImages,
  });

  dynamic restaurantCode;
  String? name;
  String? address;
  String? mobile;
  String? banner;
  String? logo;
  dynamic rating;
  dynamic totalRating;
  dynamic locLat;
  dynamic locLng;
  dynamic deliveryCharges;
  dynamic freeDeliveryAfter;
  String? currencySymbol;
  String? currencySymbolHtmlCode;
  String? foodTypes;
  List<Menu>? menuList;
  List<Timing>? timingList;
  bool? isAddedtoWishList;
  List<dynamic>? lstGalleryImages;

  factory ResturantProfileModel.fromJson(Map<String, dynamic> json) =>
      ResturantProfileModel(
        restaurantCode: json["restaurantCode"],
        name: json["name"],
        address: json["address"],
        mobile: json["mobile"],
        banner: json["banner"],
        logo: json["logo"],
        rating: json["rating"].toDouble(),
        totalRating: json["totalRating"],
        locLat: json["locLat"].toDouble(),
        locLng: json["locLng"].toDouble(),
        deliveryCharges: json["deliveryCharges"].toDouble(),
        freeDeliveryAfter: json["freeDeliveryAfter"].toDouble(),
        currencySymbol: json["currencySymbol"],
        currencySymbolHtmlCode: json["currencySymbolHtmlCode"],
        foodTypes: json["foodTypes"],
        menuList: List<Menu>.from(json["lstMenu"].map((x) => Menu.fromJson(x))),
        timingList:
            List<Timing>.from(json["lstTiming"].map((x) => Timing.fromJson(x))),
        isAddedtoWishList: json["isAddedtoWishList"],
        lstGalleryImages:
            List<dynamic>.from(json["lstGalleryImages"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "restaurantCode": restaurantCode,
        "name": name,
        "address": address,
        "mobile": mobile,
        "banner": banner,
        "logo": logo,
        "rating": rating,
        "totalRating": totalRating,
        "locLat": locLat,
        "locLng": locLng,
        "deliveryCharges": deliveryCharges,
        "freeDeliveryAfter": freeDeliveryAfter,
        "currencySymbol": currencySymbol,
        "currencySymbolHtmlCode": currencySymbolHtmlCode,
        "foodTypes": foodTypes,
        "lstMenu": List<dynamic>.from(menuList!.map((x) => x.toJson())),
        "lstTiming": List<dynamic>.from(timingList!.map((x) => x.toJson())),
        "isAddedtoWishList": isAddedtoWishList,
        "lstGalleryImages": List<dynamic>.from(lstGalleryImages!.map((x) => x)),
      };
}

class Menu {
  Menu({
    this.name,
    this.desc,
    this.from,
    this.to,
    this.itemsList,
  });

  String? name;
  String? desc;
  String? from;
  String? to;
  List<Item>? itemsList;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        name: json["name"],
        desc: json["desc"] == null ? null : json["desc"],
        from: json["from"],
        to: json["to"],
        itemsList:
            List<Item>.from(json["lstItems"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "desc": desc == null ? null : desc,
        "from": from,
        "to": to,
        "lstItems": List<dynamic>.from(itemsList!.map((x) => x.toJson())),
      };

  where(bool Function(dynamic element) param0) {}
}

class Item {
  Item({
    this.itemCode,
    this.name,
    this.highLights,
    this.image,
    this.price,
    this.discountedPrice,
    this.discountedPercentage,
    this.isOnDiscount,
    this.variationCount,
    this.priceStr,
    this.currencySymbol,
    this.currencySymbolHtmlCode,
    this.rating,
    this.totalRating,
    this.menuCode,
    this.restaurantCode,
    this.branchCode,
    this.variationsList,
    this.choiceGroups,
    this.deliveryCharges,
    this.freeDeliveryAfter,
    this.saleTaxPercentage,
  });

  dynamic itemCode;
  String? name;
  String? highLights;
  String? image;
  dynamic price;
  dynamic discountedPrice;
  dynamic discountedPercentage;
  bool? isOnDiscount;
  dynamic variationCount;
  String? priceStr;
  dynamic currencySymbol;
  dynamic currencySymbolHtmlCode;
  dynamic rating;
  dynamic totalRating;
  dynamic menuCode;
  dynamic restaurantCode;
  dynamic branchCode;
  List<dynamic>? variationsList;
  List<dynamic>? choiceGroups;
  dynamic deliveryCharges;
  dynamic freeDeliveryAfter;
  dynamic saleTaxPercentage;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        itemCode: json["itemCode"],
        name: json["name"],
        highLights: json["highLights"],
        image: json["image"],
        price: json["price"].toDouble(),
        discountedPrice: json["discountedPrice"].toDouble(),
        discountedPercentage: json["discountedPercentage"],
        isOnDiscount: json["isOnDiscount"],
        variationCount: json["variationCount"],
        priceStr: json["priceStr"],
        currencySymbol: json["currencySymbol"],
        currencySymbolHtmlCode: json["currencySymbolHtmlCode"],
        rating: json["rating"],
        totalRating: json["totalRating"],
        menuCode: json["menuCode"],
        restaurantCode: json["restaurantCode"],
        branchCode: json["branchCode"],
        variationsList: List<dynamic>.from(json["lstVariations"].map((x) => x)),
        choiceGroups: List<dynamic>.from(json["lstChoiceGroups"].map((x) => x)),
        deliveryCharges: json["deliveryCharges"],
        freeDeliveryAfter: json["freeDeliveryAfter"],
        saleTaxPercentage: json["saleTaxPercentage"],
      );

  get length => null;

  Map<String, dynamic> toJson() => {
        "itemCode": itemCode,
        "name": name,
        "highLights": highLights,
        "image": image,
        "price": price,
        "discountedPrice": discountedPrice,
        "discountedPercentage": discountedPercentage,
        "isOnDiscount": isOnDiscount,
        "variationCount": variationCount,
        "priceStr": priceStr,
        "currencySymbol": currencySymbol,
        "currencySymbolHtmlCode": currencySymbolHtmlCode,
        "rating": rating,
        "totalRating": totalRating,
        "menuCode": menuCode,
        "restaurantCode": restaurantCode,
        "branchCode": branchCode,
        "lstVariations": List<dynamic>.from(variationsList!.map((x) => x)),
        "lstChoiceGroups": List<dynamic>.from(choiceGroups!.map((x) => x)),
        "deliveryCharges": deliveryCharges,
        "freeDeliveryAfter": freeDeliveryAfter,
        "saleTaxPercentage": saleTaxPercentage,
      };
}

class Timing {
  Timing({
    this.dayNo,
    this.dayName,
    this.from,
    this.to,
    this.isHoliday,
  });

  dynamic dayNo;
  String? dayName;
  String? from;
  String? to;
  bool? isHoliday;

  factory Timing.fromJson(Map<String, dynamic> json) => Timing(
        dayNo: json["dayNo"],
        dayName: json["dayName"],
        from: json["from"],
        to: json["to"],
        isHoliday: json["isHoliday"],
      );

  Map<String, dynamic> toJson() => {
        "dayNo": dayNo,
        "dayName": dayName,
        "from": from,
        "to": to,
        "isHoliday": isHoliday,
      };
}
