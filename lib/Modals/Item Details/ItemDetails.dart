import 'dart:convert';

ItemDetailsModel itemDetailsFromJson(String str) =>
    ItemDetailsModel.fromJson(json.decode(str));

String itemDetailsToJson(ItemDetailsModel data) => json.encode(data.toJson());

class ItemDetailsModel {
  ItemDetailsModel(
      {this.itemCode,
      this.name,
      this.highLights,
      this.image,
      this.price,
      this.priceStr,
      this.currencySymbol,
      this.currencySymbolHtmlCode,
      this.rating,
      this.totalRating,
      this.menuCode,
      this.restaurantCode,
      this.branchCode,
      this.variations,
      this.choiceGroups,
      this.discountedPercentage,
      this.discountedPrice,
      this.isOnDiscount,
      this.variationCount,
      this.freeDeliveryAfter,
      this.saleTaxPercentage});

  int? itemCode;
  String? name;
  String? highLights;
  String? image;
  double? price;
  double? discountedPrice;
  double? discountedPercentage;
  bool? isOnDiscount;
  int? variationCount;
  String? priceStr;
  dynamic currencySymbol;
  dynamic currencySymbolHtmlCode;
  double? rating;
  int? totalRating;
  int? menuCode;
  int? restaurantCode;
  int? branchCode;
  double? freeDeliveryAfter;
  double? saleTaxPercentage;
  List<Variations>? variations;
  List<ChoiceGroups>? choiceGroups;

  factory ItemDetailsModel.fromJson(Map<String, dynamic> json) =>
      ItemDetailsModel(
        itemCode: json["itemCode"],
        name: json["name"],
        highLights: json["highLights"],
        image: json["image"],
        price: json["price"] != null ? json["price"].toDouble() : null,
        discountedPrice: json["discountedPrice"] != null
            ? json["discountedPrice"].toDouble()
            : null,
        discountedPercentage: json["discountedPercentage"] != null
            ? json["discountedPercentage"].toDouble()
            : null,
        isOnDiscount: json["isOnDiscount"],
        variationCount: json["variationCount"],
        priceStr: json["priceStr"],
        currencySymbol: json["currencySymbol"],
        currencySymbolHtmlCode: json["currencySymbolHtmlCode"],
        rating: json["rating"] != null ? json["rating"].toDouble() : null,
        totalRating: json["totalRating"],
        menuCode: json["menuCode"],
        restaurantCode: json["restaurantCode"],
        branchCode: json["branchCode"],
        freeDeliveryAfter: json["freeDeliveryAfter"] != null
            ? json["freeDeliveryAfter"].toDouble()
            : null,
        saleTaxPercentage: json["saleTaxPercentage"] != null
            ? json["saleTaxPercentage"].toDouble()
            : null,
        variations: List<Variations>.from(
            json["lstVariations"].map((x) => Variations.fromJson(x))),
        choiceGroups: List<ChoiceGroups>.from(
            json["lstChoiceGroups"].map((x) => ChoiceGroups.fromJson(x))),
      );

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
        "freeDeliveryAfter": freeDeliveryAfter,
        "saleTaxPercentage": saleTaxPercentage,
        "lstVariations": List<dynamic>.from(variations!.map((x) => x.toJson())),
        "lstChoiceGroups":
            List<dynamic>.from(choiceGroups!.map((x) => x.toJson())),
      };
}

class ChoiceGroups {
  ChoiceGroups({
    this.groupCode,
    this.groupName,
    this.isSelected,
    this.minimum,
    this.maximum,
    this.variantCode,
    this.options,    
  });

  int? groupCode;
  String? groupName;
  bool? isSelected;
  int? minimum;
  int? maximum;
  int? variantCode;
  List<ChoiceOptions>? options;

  factory ChoiceGroups.fromJson(Map<String, dynamic> json) => ChoiceGroups(
        groupCode: json["groupCode"],
        groupName: json["groupName"],
        isSelected: json["isSelected"],
        minimum: json["minimum"],
        maximum: json["maximum"],
        variantCode: json["variantCode"],
        options: List<ChoiceOptions>.from(
            json["lstOptions"].map((x) => ChoiceOptions.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "groupCode": groupCode,
        "groupName": groupName,
        "isSelected": isSelected,
        "minimum": minimum,
        "maximum": maximum,
        "variantCode": variantCode,
        "lstOptions": List<dynamic>.from(options!.map((x) => x.toJson())),
      };
}

class ChoiceOptions {
  ChoiceOptions({
    this.groupCode,
    this.optionCode,
    this.name,
    this.price,
    this.discountedPrice,
    this.discountFromDate,
    this.discountToDate,

    // this.groupCode,
    //     this.optionCode,
    //     this.optionName,
    //     this.price,
    //     this.discountedPrice,
    //     this.discountFromDate,
    //     this.discountToDate,
  });

  int? groupCode;
  int? optionCode;
  String? name;
  double? price;
  double? discountedPrice;
  dynamic discountFromDate;
  dynamic discountToDate;

  factory ChoiceOptions.fromJson(Map<String, dynamic> json) => ChoiceOptions(
        groupCode: json["groupCode"],
        optionCode: json["optionCode"],
        name: json["optionName"],
        price: json["price"] != null ? json["price"].toDouble() : null,
        discountedPrice: json["discountedPrice"] != null
            ? json["discountedPrice"].toDouble()
            : null,
        discountFromDate: json["discountFromDate"],
        discountToDate: json["discountToDate"],
      );

  Map<String, dynamic> toJson() => {
        "groupCode": groupCode,
        "optionCode": optionCode,
        "optionName": name,
        "price": price,
        "discountedPrice": discountedPrice,
        "discountFromDate": discountFromDate,
        "discountToDate": discountToDate,
      };
}

class Variations {
  Variations(
      {this.variationCode,
      this.name,
      this.price,
      this.discountedPrice,
      this.discountFrom,
      this.discountTo,
      this.servingFor,
      this.preparationTime,
      this.weight,
      this.discountedPercentage,
      this.isOnDiscount});

  int? variationCode;
  String? name;
  double? price;
  bool? isOnDiscount;
  double? discountedPercentage;
  double? discountedPrice;
  dynamic discountFrom;
  dynamic discountTo;
  int? servingFor;
  int? preparationTime;
  double? weight;

  factory Variations.fromJson(Map<String, dynamic> json) => Variations(
        variationCode: json["variationCode"],
        name: json["variationName"],
        price: json["price"] != null ? json["price"].toDouble() : null,
        isOnDiscount: json["isOnDiscount"],
        discountedPercentage: json["discountedPercentage"] != null
            ? json["discountedPercentage"].toDouble()
            : null,
        discountedPrice: json["discountedPrice"] != null
            ? json["discountedPrice"].toDouble()
            : null,
        discountFrom: json["discountFrom"],
        discountTo: json["discountTo"],
        servingFor: json["servingFor"],
        preparationTime: json["preparationTime"],
        weight: json["weight"] != null ? json["weight"].toDouble() : null,
      );

  Map<String, dynamic> toJson() => {
        "variationCode": variationCode,
        "variationName": name,
        "price": price,
        "isOnDiscount": isOnDiscount,
        "discountedPercentage": discountedPercentage,
        "discountedPrice": discountedPrice,
        "discountFrom": discountFrom,
        "discountTo": discountTo,
        "servingFor": servingFor,
        "preparationTime": preparationTime,
        "weight": weight,
      };
}
