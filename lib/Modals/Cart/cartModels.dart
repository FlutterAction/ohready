class mdlCart {
  final dynamic restaurantCode;
  final List<mdlCartItem>? lstItems;
  final dynamic subTotal;
  final dynamic saleTaxPer;
  final dynamic saleTax;
  final dynamic shippingCharges;
  final dynamic discount;
  final dynamic voucherCode;
  final dynamic voucherName;
  final dynamic currencySymbol;
  final dynamic currencySymbolHtmlCode;
   dynamic total;

  mdlCart(
      {this.restaurantCode,
      this.lstItems,
      this.subTotal,
      this.saleTaxPer,
      this.saleTax,
      this.shippingCharges,
      this.discount,
      this.voucherCode,
      this.voucherName,
      this.currencySymbol,
      this.currencySymbolHtmlCode,
      this.total});

  factory mdlCart.fromJson(Map<String, dynamic> json) => mdlCart(
        restaurantCode: json["restaurantCode"],
        lstItems: List<mdlCartItem>.from(
            json["lstItems"].map((x) => mdlCartItem.fromJson(x.toJson()))),
        subTotal: json["subTotal"] != null ? json["subTotal"].toDouble() : null,
        saleTaxPer:
            json["saleTaxPer"] != null ? json["saleTaxPer"].toDouble() : null,
        saleTax: json["saleTax"] != null ? json["saleTax"].toDouble() : null,
        shippingCharges: json["shippingCharges"] != null
            ? json["shippingCharges"].toDouble()
            : null,
        discount: json["discount"] != null ? json["discount"].toDouble() : null,
        voucherCode: json["voucherCode"],
        voucherName: json["voucherName"],
        currencySymbol: json["currencySymbol"],
        currencySymbolHtmlCode: json["currencySymbolHtmlCode"],
        total: json["total"] != null ? json["total"].toDouble() : null,
      );

  Map<String, dynamic> toJson() => {
        "restaurantCode": restaurantCode,
        "lstItems": List<dynamic>.from(lstItems!.map((x) => x)),
        "subTotal": subTotal,
        "saleTaxPer": saleTaxPer,
        "saleTax": saleTax,
        "shippingCharges": shippingCharges,
        "discount": discount,
        "voucherCode": voucherCode,
        "voucherName": voucherName,
        "currencySymbol": currencySymbol,
        "currencySymbolHtmlCode": currencySymbolHtmlCode,
        "total": total,
      };
}

class mdlCartItem {
   int? indx;
   int? restaurantCode;
   int? branchCode;
   int? itemCode;
   String? itemName;
   String? itemImage;
   String? whatToDo;
   String? instructions;
   int? selectedVariationCode;
   String? selectedVariationName;
   bool? isOneVariation;
   double? price;
   double? discountedPrice;
   int? qnty;
   double? rowTotal;
   List<mdlCartChoiceGroup>? lstChoiceGroups;

  mdlCartItem(
      {this.indx,
      this.restaurantCode,
      this.branchCode,
      this.itemCode,
      this.itemName,
      this.itemImage,
      this.whatToDo,
      this.instructions,
      this.selectedVariationCode,
      this.selectedVariationName,
      this.isOneVariation,
      this.price,
      this.discountedPrice,
      this.qnty,
      this.rowTotal,
      this.lstChoiceGroups});

  factory mdlCartItem.fromJson(Map<String, dynamic> json) => mdlCartItem(
        indx: json["indx"],
        restaurantCode: json["restaurantCode"],
        branchCode: json["branchCode"],
        itemCode: json["itemCode"],
        itemName: json["itemName"],
        itemImage: json["itemImage"],
        whatToDo: json["whatToDo"],
        instructions: json["instructions"],
        selectedVariationCode: json["selectedVariationCode"],
        selectedVariationName: json["selectedVariationName"],
        isOneVariation: json["isOneVariation"],
        price: json["price"] != null ? json["price"].toDouble() : null,
        discountedPrice: json["discountedPrice"] != null
            ? json["discountedPrice"].toDouble()
            : null,
        qnty: json["qnty"],
        rowTotal: json["rowTotal"] != null ? json["rowTotal"].toDouble() : null,
        lstChoiceGroups: List<mdlCartChoiceGroup>.from(
            json["lstChoiceGroups"].map((x) => mdlCartChoiceGroup.fromJson(x.toJson()))),
      );

  Map<String, dynamic> toJson() => {
        "indx": indx,
        "restaurantCode": restaurantCode,
        "branchCode": branchCode,
        "itemCode": itemCode,
        "name": itemName,
        "image": itemImage,
        "whatToDo": whatToDo,
        "instructions": instructions,
        "selectedVariationCode": selectedVariationCode,
        "selectedVariationName": selectedVariationName,
        "isOneVariation": isOneVariation,
        "price": price,
        "discountedPrice": discountedPrice,
        "qnty": qnty,
        "rowTotal": rowTotal,
        "lstChoiceGroups":
            List<mdlCartChoiceGroup>.from(lstChoiceGroups!.map((x) => x)),
      };
}

class mdlCartChoiceGroup {
  //  mdlCartChoiceGroup()
  // {
  //     lstSelectedOptions =  List<mdlChoiceGroupOption>();
  // }
  final int? groupCode;
  final String? groupName;
  final List<mdlChoiceGroupOption>? lstSelectedOptions;
  mdlCartChoiceGroup({this.groupCode, this.groupName, this.lstSelectedOptions});

  factory mdlCartChoiceGroup.fromJson(Map<String, dynamic> json) =>
      mdlCartChoiceGroup(
        groupCode: json["groupCode"],
        groupName: json["groupName"],
        lstSelectedOptions: List<mdlChoiceGroupOption>.from(
            json["lstOptions"].map((x) => mdlChoiceGroupOption.fromJson(x.toJson()))),
      );

  Map<String, dynamic> toJson() => {
        "groupCode": groupCode,
        "groupName": groupName,
        "lstOptions":
            List<dynamic>.from(lstSelectedOptions!.map((x) => x)),
      };
}

class mdlChoiceGroupOption {
  final int? groupCode;
  final int? optionCode;
  final String? optionName;
  final double? price;
  final double? discountedPrice;
  final DateTime? discountFromDate;
  final DateTime? discountToDate;

  mdlChoiceGroupOption(
      {this.groupCode,
      this.optionCode,
      this.optionName,
      this.price,
      this.discountedPrice,
      this.discountFromDate,
      this.discountToDate});

  factory mdlChoiceGroupOption.fromJson(Map<String, dynamic> json) =>
      mdlChoiceGroupOption(
        groupCode: json["groupCode"],
        optionCode: json["optionCode"],
        optionName: json["optionName"],
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
        "optionName": optionName,
        "price": price,
        "discountedPrice": discountedPrice,
        "discountFromDate": discountFromDate,
        "discountToDate": discountToDate,
      };
}
