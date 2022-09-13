import 'dart:convert';

ResturantList resturantListFromJson(String str) =>
    ResturantList.fromJson(json.decode(str));

String resturantListToJson(ResturantList data) => json.encode(data.toJson());

class ResturantList {
  ResturantList({
    this.resturantList,
    this.pageSize,
    this.pageIndex,
    this.totalPages,
    this.searchText,
  });

  List<Resturant>? resturantList;
  dynamic pageSize;
  dynamic pageIndex;
  dynamic totalPages;
  dynamic searchText;

  factory ResturantList.fromJson(Map<String, dynamic> json) => ResturantList(
        resturantList:
            List<Resturant>.from(json["lst"].map((x) => Resturant.fromJson(x))),
        pageSize: json["pageSize"],
        pageIndex: json["pageIndex"],
        totalPages: json["totalPages"],
        searchText: json["searchText"],
      );

  Map<String, dynamic> toJson() => {
        "lst": List<dynamic>.from(resturantList!.map((x) => x.toJson())),
        "pageSize": pageSize,
        "pageIndex": pageIndex,
        "totalPages": totalPages,
        "searchText": searchText,
      };
}

class Resturant {
  Resturant({
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

  dynamic restaurantCode;
  dynamic branchCode;
  String? name;
  String? foodTypes;
  String? bannerImage;
  String? logo;
  dynamic rating;
  dynamic reviewCount;
  bool? isAddedToWishlist;

  factory Resturant.fromJson(Map<String, dynamic> json) => Resturant(
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
