// To parse this JSON data, do
//
//     final getFavorites = getFavoritesFromJson(jsonString);

import 'dart:convert';

GetFavorites getFavoritesFromJson(String str) => GetFavorites.fromJson(json.decode(str));

String getFavoritesToJson(GetFavorites data) => json.encode(data.toJson());

class GetFavorites {
    GetFavorites({
        this.lstRestaurant,
        this.lstItem,
    });

    List<LstRestaurant>? lstRestaurant;
    List<LstItem>? lstItem;

    factory GetFavorites.fromJson(Map<String, dynamic> json) => GetFavorites(
        lstRestaurant: List<LstRestaurant>.from(json["lstRestaurant"].map((x) => LstRestaurant.fromJson(x))),
        lstItem: List<LstItem>.from(json["lstItem"].map((x) => LstItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "lstRestaurant": List<dynamic>.from(lstRestaurant!.map((x) => x.toJson())),
        "lstItem": List<dynamic>.from(lstItem!.map((x) => x.toJson())),
    };
}

class LstItem {
    LstItem({
        this.isAddedToWishlist,
        this.itemCode,
        this.name,
        this.restaurantName,
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
        this.lstVariations,
        this.lstChoiceGroups,
        this.deliveryCharges,
        this.freeDeliveryAfter,
        this.saleTaxPercentage,
    });

    bool? isAddedToWishlist;
    int? itemCode;
    String? name;
    String? restaurantName;
    String? highLights;
    String? image;
    double? price;
    int? discountedPrice;
    double? discountedPercentage;
    bool? isOnDiscount;
    int? variationCount;
    String? priceStr;
    dynamic currencySymbol;
    dynamic currencySymbolHtmlCode;
    int? rating;
    int? totalRating;
    int? menuCode;
    int? restaurantCode;
    int? branchCode;
    List<dynamic>? lstVariations;
    List<dynamic>? lstChoiceGroups;
    int? deliveryCharges;
    int? freeDeliveryAfter;
    int? saleTaxPercentage;

    factory LstItem.fromJson(Map<String, dynamic> json) => LstItem(
        isAddedToWishlist: json["isAddedToWishlist"],
        itemCode: json["itemCode"],
        name: json["name"],
        restaurantName: json["restaurantName"],
        highLights: json["highLights"],
        image: json["image"],
        price: json["price"].toDouble(),
        discountedPrice: json["discountedPrice"],
        discountedPercentage: json["discountedPercentage"].toDouble(),
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
        lstVariations: List<dynamic>.from(json["lstVariations"].map((x) => x)),
        lstChoiceGroups: List<dynamic>.from(json["lstChoiceGroups"].map((x) => x)),
        deliveryCharges: json["deliveryCharges"],
        freeDeliveryAfter: json["freeDeliveryAfter"],
        saleTaxPercentage: json["saleTaxPercentage"],
    );

    Map<String, dynamic> toJson() => {
        "isAddedToWishlist": isAddedToWishlist,
        "itemCode": itemCode,
        "name": name,
        "restaurantName": restaurantName,
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
        "lstVariations": List<dynamic>.from(lstVariations!.map((x) => x)),
        "lstChoiceGroups": List<dynamic>.from(lstChoiceGroups!.map((x) => x)),
        "deliveryCharges": deliveryCharges,
        "freeDeliveryAfter": freeDeliveryAfter,
        "saleTaxPercentage": saleTaxPercentage,
    };
}

class LstRestaurant {
    LstRestaurant({
        this.restaurantCode,
        this.branchCode,
        this.name,
        this.foodTypes,
        this.bannerImage,
        this.logo,
        this.rating,
        this.reviewCount,
        this.isAddedToWishlist,
    });

    int? restaurantCode;
    int? branchCode;
    String? name;
    String? foodTypes;
    String? bannerImage;
    String? logo;
    int? rating;
    int? reviewCount;
    bool? isAddedToWishlist;

    factory LstRestaurant.fromJson(Map<String, dynamic> json) => LstRestaurant(
        restaurantCode: json["restaurantCode"],
        branchCode: json["branchCode"],
        name: json["name"],
        foodTypes: json["foodTypes"],
        bannerImage: json["bannerImage"],
        logo: json["logo"],
        rating: json["rating"],
        reviewCount: json["reviewCount"],
        isAddedToWishlist: json["isAddedToWishlist"],
    );

    Map<String, dynamic> toJson() => {
        "restaurantCode": restaurantCode,
        "branchCode": branchCode,
        "name": name,
        "foodTypes": foodTypes,
        "bannerImage": bannerImage,
        "logo": logo,
        "rating": rating,
        "reviewCount": reviewCount,
        "isAddedToWishlist": isAddedToWishlist,
    };
}
