// To parse this JSON data, do
//
//     final orderHistoryModel = orderHistoryModelFromJson(jsonString);

import 'dart:convert';

OrderHistoryModel orderHistoryModelFromJson(String str) => OrderHistoryModel.fromJson(json.decode(str));

String orderHistoryModelToJson(OrderHistoryModel data) => json.encode(data.toJson());

class OrderHistoryModel {
    OrderHistoryModel({
        this.lstActiveOrders,
        this.lstPastOrders,
    });

    List<dynamic>? lstActiveOrders;
    List<LstPastOrder>? lstPastOrders;

    factory OrderHistoryModel.fromJson(Map<String, dynamic> json) => OrderHistoryModel(
        lstActiveOrders: List<LstActiveOrder>.from(json["lstActiveOrders"].map((x) =>  LstActiveOrder.fromJson(x))),
        lstPastOrders: List<LstPastOrder>.from(json["lstPastOrders"].map((x) => LstPastOrder.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "lstActiveOrders": List<dynamic>.from(lstActiveOrders!.map((x) => x.toJson())),
        "lstPastOrders": List<dynamic>.from(lstPastOrders!.map((x) => x.toJson())),
    };
}

class LstActiveOrder {
    LstActiveOrder({
        this.restaurantCode,
        this.branchCode,
        this.restaurantName,
        this.restaurantLogo,
        this.restaurantBanner,
        this.currencySymbol,
        this.orderCode,
        this.customerCode,
        this.orderDate,
        this.orderStatus,
        this.itemCount,
        this.orderSubTotal,
        this.shipingCharges,
        this.saleTax,
        this.saleTaxPer,
        this.orderTotal,
        this.cartJsonString,
        this.instructions,
        this.addressCode,
        this.cart,
    });

    int? restaurantCode;
    int? branchCode;
    String? restaurantName;
    dynamic restaurantLogo;
    dynamic restaurantBanner;
    String? currencySymbol;
    int? orderCode;
    int? customerCode;
    String? orderDate;
    String? orderStatus;
    int? itemCount;
    int? orderSubTotal;
    int? shipingCharges;
    int? saleTax;
    int? saleTaxPer;
    int? orderTotal;
    dynamic cartJsonString;
    dynamic instructions;
    int? addressCode;
    Cart? cart;

    factory LstActiveOrder.fromJson(Map<String, dynamic> json) => LstActiveOrder(
        restaurantCode: json["restaurantCode"],
        branchCode: json["branchCode"],
        restaurantName: json["restaurantName"],
        restaurantLogo: json["restaurantLogo"],
        restaurantBanner: json["restaurantBanner"],
        currencySymbol: json["currencySymbol"],
        orderCode: json["orderCode"],
        customerCode: json["customerCode"],
        orderDate: json["orderDate"],
        orderStatus: json["orderStatus"],
        itemCount: json["itemCount"],
        orderSubTotal: json["orderSubTotal"],
        shipingCharges: json["shipingCharges"],
        saleTax: json["saleTax"],
        saleTaxPer: json["saleTaxPer"],
        orderTotal: json["orderTotal"],
        cartJsonString: json["cartJsonString"],
        instructions: json["instructions"],
        addressCode: json["addressCode"],
        cart: Cart.fromJson(json["cart"]),
    );

    Map<String, dynamic> toJson() => {
        "restaurantCode": restaurantCode,
        "branchCode": branchCode,
        "restaurantName": restaurantName,
        "restaurantLogo": restaurantLogo,
        "restaurantBanner": restaurantBanner,
        "currencySymbol": currencySymbol,
        "orderCode": orderCode,
        "customerCode": customerCode,
        "orderDate": orderDate,
        "orderStatus": orderStatus,
        "itemCount": itemCount,
        "orderSubTotal": orderSubTotal,
        "shipingCharges": shipingCharges,
        "saleTax": saleTax,
        "saleTaxPer": saleTaxPer,
        "orderTotal": orderTotal,
        "cartJsonString": cartJsonString,
        "instructions": instructions,
        "addressCode": addressCode,
        "cart": cart!.toJson(),
    };
}



class LstPastOrder {
    LstPastOrder({
        this.restaurantCode,
        this.branchCode,
        this.restaurantName,
        this.restaurantLogo,
        this.restaurantBanner,
        this.currencySymbol,
        this.orderCode,
        this.customerCode,
        this.orderDate,
        this.orderStatus,
        this.itemCount,
        this.orderSubTotal,
        this.shipingCharges,
        this.saleTax,
        this.saleTaxPer,
        this.orderTotal,
        this.cartJsonString,
        this.instructions,
        this.addressCode,
        this.cart,
    });

    int? restaurantCode;
    int? branchCode;
    String? restaurantName;
    dynamic restaurantLogo;
    dynamic restaurantBanner;
    String? currencySymbol;
    int? orderCode;
    int? customerCode;
    String? orderDate;
    String? orderStatus;
    int? itemCount;
    int? orderSubTotal;
    int? shipingCharges;
    int? saleTax;
    int? saleTaxPer;
    int? orderTotal;
    dynamic cartJsonString;
    dynamic instructions;
    int? addressCode;
    Cart? cart;

    factory LstPastOrder.fromJson(Map<String, dynamic> json) => LstPastOrder(
        restaurantCode: json["restaurantCode"],
        branchCode: json["branchCode"],
        restaurantName: json["restaurantName"],
        restaurantLogo: json["restaurantLogo"],
        restaurantBanner: json["restaurantBanner"],
        currencySymbol: json["currencySymbol"],
        orderCode: json["orderCode"],
        customerCode: json["customerCode"],
        orderDate: json["orderDate"],
        orderStatus: json["orderStatus"],
        itemCount: json["itemCount"],
        orderSubTotal: json["orderSubTotal"],
        shipingCharges: json["shipingCharges"],
        saleTax: json["saleTax"],
        saleTaxPer: json["saleTaxPer"],
        orderTotal: json["orderTotal"],
        cartJsonString: json["cartJsonString"],
        instructions: json["instructions"],
        addressCode: json["addressCode"],
        cart: Cart.fromJson(json["cart"]),
    );

    Map<String, dynamic> toJson() => {
        "restaurantCode": restaurantCode,
        "branchCode": branchCode,
        "restaurantName": restaurantName,
        "restaurantLogo": restaurantLogo,
        "restaurantBanner": restaurantBanner,
        "currencySymbol": currencySymbol,
        "orderCode": orderCode,
        "customerCode": customerCode,
        "orderDate": orderDate,
        "orderStatus": orderStatus,
        "itemCount": itemCount,
        "orderSubTotal": orderSubTotal,
        "shipingCharges": shipingCharges,
        "saleTax": saleTax,
        "saleTaxPer": saleTaxPer,
        "orderTotal": orderTotal,
        "cartJsonString": cartJsonString,
        "instructions": instructions,
        "addressCode": addressCode,
        "cart": cart!.toJson(),
    };
}


class Cart {
    Cart({
        this.restaurantCode,
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
        this.total,
    });

    int? restaurantCode;
    List<LstItem>? lstItems;
    int? subTotal;
    int? saleTaxPer;
    int? saleTax;
    int? shippingCharges;
    int? discount;
    int? voucherCode;
    dynamic voucherName;
    String? currencySymbol;
    dynamic currencySymbolHtmlCode;
    int? total;

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        restaurantCode: json["restaurantCode"],
        lstItems: List<LstItem>.from(json["lstItems"].map((x) => LstItem.fromJson(x))),
        subTotal: json["subTotal"],
        saleTaxPer: json["saleTaxPer"],
        saleTax: json["saleTax"],
        shippingCharges: json["shippingCharges"],
        discount: json["discount"],
        voucherCode: json["voucherCode"],
        voucherName: json["voucherName"],
        currencySymbol: json["currencySymbol"] == null ? null : json["currencySymbol"],
        currencySymbolHtmlCode: json["currencySymbolHtmlCode"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "restaurantCode": restaurantCode,
        "lstItems": List<dynamic>.from(lstItems!.map((x) => x.toJson())),
        "subTotal": subTotal,
        "saleTaxPer": saleTaxPer,
        "saleTax": saleTax,
        "shippingCharges": shippingCharges,
        "discount": discount,
        "voucherCode": voucherCode,
        "voucherName": voucherName,
        "currencySymbol": currencySymbol == null ? null : currencySymbol,
        "currencySymbolHtmlCode": currencySymbolHtmlCode,
        "total": total,
    };
}

class LstItem {
    LstItem({
        this.indx,
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
        this.lstChoiceGroups,
    });

    int? indx;
    int? restaurantCode;
    int? branchCode;
    int? itemCode;
    ItemName? itemName;
    String? itemImage;
    WhatToDo? whatToDo;
    String? instructions;
    int? selectedVariationCode;
    SelectedVariationName? selectedVariationName;
    bool? isOneVariation;
    int? price;
    int? discountedPrice;
    int? qnty;
    int? rowTotal;
    List<LstChoiceGroup>? lstChoiceGroups;

    factory LstItem.fromJson(Map<String, dynamic> json) => LstItem(
        indx: json["indx"],
        restaurantCode: json["restaurantCode"],
        branchCode: json["branchCode"],
        itemCode: json["itemCode"],
        itemName: itemNameValues.map![json["itemName"]],
        itemImage: json["itemImage"],
        whatToDo: whatToDoValues.map![json["whatToDo"]],
        instructions: json["instructions"] == null ? null : json["instructions"],
        selectedVariationCode: json["selectedVariationCode"],
        selectedVariationName: selectedVariationNameValues.map![json["selectedVariationName"]],
        isOneVariation: json["isOneVariation"],
        price: json["price"],
        discountedPrice: json["discountedPrice"],
        qnty: json["qnty"],
        rowTotal: json["rowTotal"],
        lstChoiceGroups: List<LstChoiceGroup>.from(json["lstChoiceGroups"].map((x) => LstChoiceGroup.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "indx": indx,
        "restaurantCode": restaurantCode,
        "branchCode": branchCode,
        "itemCode": itemCode,
        "itemName": itemNameValues.reverse[itemName],
        "itemImage": itemImage,
        "whatToDo": whatToDoValues.reverse[whatToDo],
        "instructions": instructions == null ? null : instructions,
        "selectedVariationCode": selectedVariationCode,
        "selectedVariationName": selectedVariationNameValues.reverse[selectedVariationName],
        "isOneVariation": isOneVariation,
        "price": price,
        "discountedPrice": discountedPrice,
        "qnty": qnty,
        "rowTotal": rowTotal,
        "lstChoiceGroups": List<dynamic>.from(lstChoiceGroups!.map((x) => x.toJson())),
    };
}

enum ItemName { TEST_ITEM, FIX_FOR_SIX }

final itemNameValues = EnumValues({
    "Fix For Six": ItemName.FIX_FOR_SIX,
    "testItem": ItemName.TEST_ITEM
});

class LstChoiceGroup {
    LstChoiceGroup({
        this.groupCode,
        this.groupName,
        this.lstSelectedOptions,
    });

    int? groupCode;
    String? groupName;
    List<LstSelectedOption>? lstSelectedOptions;

    factory LstChoiceGroup.fromJson(Map<String, dynamic> json) => LstChoiceGroup(
        groupCode: json["groupCode"],
        groupName: json["groupName"],
        lstSelectedOptions: List<LstSelectedOption>.from(json["lstSelectedOptions"].map((x) => LstSelectedOption.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "groupCode": groupCode,
        "groupName": groupName,
        "lstSelectedOptions": List<dynamic>.from(lstSelectedOptions!.map((x) => x.toJson())),
    };
}

class LstSelectedOption {
    LstSelectedOption({
        this.groupCode,
        this.optionCode,
        this.optionName,
        this.price,
        this.discountedPrice,
        this.discountFromDate,
        this.discountToDate,
    });

    int? groupCode;
    int? optionCode;
    String? optionName;
    int? price;
    dynamic discountedPrice;
    dynamic discountFromDate;
    dynamic discountToDate;

    factory LstSelectedOption.fromJson(Map<String, dynamic> json) => LstSelectedOption(
        groupCode: json["groupCode"],
        optionCode: json["optionCode"],
        optionName: json["optionName"],
        price: json["price"],
        discountedPrice: json["discountedPrice"],
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

enum SelectedVariationName { ONLY, MEDIUM }

final selectedVariationNameValues = EnumValues({
    "Medium": SelectedVariationName.MEDIUM,
    "Only": SelectedVariationName.ONLY
});

enum WhatToDo { REMOVE_IT_FROM_ORDER, CANCEL_THE_ENTIRE_ORDER }

 final whatToDoValues = EnumValues({
    "Cancel the entire order": WhatToDo.CANCEL_THE_ENTIRE_ORDER,
    "Remove it from order": WhatToDo.REMOVE_IT_FROM_ORDER
});

class EnumValues<T> {
    Map<String, T>? map;
    Map<T, String>? reverseMap;

     EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map!.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap!;
    }
}
