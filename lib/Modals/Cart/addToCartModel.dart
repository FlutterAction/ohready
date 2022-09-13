// To parse this JSON data, do
//
//     final addToCartModel = addToCartModelFromJson(jsonString);

import 'dart:convert';

AddToCartModel addToCartModelFromJson(String? str) => AddToCartModel.fromJson(json.decode(str!));

String? addToCartModelToJson(AddToCartModel data) => json.encode(data.toJson());

class AddToCartModel {
    AddToCartModel({
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

    dynamic restaurantCode;
    List<LstItem>? lstItems;
    dynamic subTotal;
    dynamic saleTaxPer;
    dynamic saleTax;
    dynamic shippingCharges;
    dynamic discount;
    String? voucherCode;
    String? voucherName;
    String? currencySymbol;
    String? currencySymbolHtmlCode;
    dynamic total;

    factory AddToCartModel.fromJson(Map<String?, dynamic> json) => AddToCartModel(
        restaurantCode: json["restaurantCode"],
        lstItems: List<LstItem>.from(json["lstItems"].map((x) => LstItem.fromJson(x))),
        subTotal: json["subTotal"],
        saleTaxPer: json["saleTaxPer"],
        saleTax: json["saleTax"],
        shippingCharges: json["shippingCharges"],
        discount: json["discount"],
        voucherCode: json["voucherCode"],
        voucherName: json["voucherName"],
        currencySymbol: json["currencySymbol"],
        currencySymbolHtmlCode: json["currencySymbolHtmlCode"],
        total: json["total"],
    );

    Map<String?, dynamic> toJson() => {
        "restaurantCode": restaurantCode,
        "lstItems": List<dynamic>.from(lstItems!.map((x) => x.toJson())),
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

class LstItem {
    LstItem({
        this.indx,
        this.restaurantCode,
        this.branchCode,
        this.itemCode,
        this.name,
        this.image,
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

    dynamic indx;
    dynamic restaurantCode;
    dynamic branchCode;
    dynamic itemCode;
    String? name;
    String? image;
    String? whatToDo;
    String? instructions;
    dynamic selectedVariationCode;
    String? selectedVariationName;
    bool? isOneVariation;
    dynamic price;
    dynamic discountedPrice;
    dynamic qnty;
    dynamic rowTotal;
    List<LstChoiceGroup>? lstChoiceGroups;

    factory LstItem.fromJson(Map<String?, dynamic> json) => LstItem(
        indx: json["indx"],
        restaurantCode: json["restaurantCode"],
        branchCode: json["branchCode"],
        itemCode: json["itemCode"],
        name: json["name"],
        image: json["image"],
        whatToDo: json["whatToDo"],
        instructions: json["instructions"],
        selectedVariationCode: json["selectedVariationCode"],
        selectedVariationName: json["selectedVariationName"],
        isOneVariation: json["isOneVariation"],
        price: json["price"],
        discountedPrice: json["discountedPrice"],
        qnty: json["qnty"],
        rowTotal: json["rowTotal"],
        lstChoiceGroups: List<LstChoiceGroup>.from(json["lstChoiceGroups"].map((x) => LstChoiceGroup.fromJson(x))),
    );

    Map<String?, dynamic> toJson() => {
        "indx": indx,
        "restaurantCode": restaurantCode,
        "branchCode": branchCode,
        "itemCode": itemCode,
        "name": name,
        "image": image,
        "whatToDo": whatToDo,
        "instructions": instructions,
        "selectedVariationCode": selectedVariationCode,
        "selectedVariationName": selectedVariationName,
        "isOneVariation": isOneVariation,
        "price": price,
        "discountedPrice": discountedPrice,
        "qnty": qnty,
        "rowTotal": rowTotal,
        "lstChoiceGroups": List<dynamic>.from(lstChoiceGroups!.map((x) => x.toJson())),
    };
}

class LstChoiceGroup {
    LstChoiceGroup({
        this.groupCode,
        this.groupName,
        this.lstOptions,
    });

    dynamic groupCode;
    String? groupName;
    List<LstOption>? lstOptions;

    factory LstChoiceGroup.fromJson(Map<String?, dynamic> json) => LstChoiceGroup(
        groupCode: json["groupCode"],
        groupName: json["groupName"],
        lstOptions: List<LstOption>.from(json["lstOptions"].map((x) => LstOption.fromJson(x))),
    );

    Map<String?, dynamic> toJson() => {
        "groupCode": groupCode,
        "groupName": groupName,
        "lstOptions": List<dynamic>.from(lstOptions!.map((x) => x.toJson())),
    };
}

class LstOption {
    LstOption({
        this.groupCode,
        this.optionCode,
        this.optionName,
        this.price,
        this.discountedPrice,
        this.discountFromDate,
        this.discountToDate,
    });

    dynamic groupCode;
    dynamic optionCode;
    String? optionName;
    dynamic price;
    dynamic discountedPrice;
    dynamic discountFromDate;
    dynamic discountToDate;

    factory LstOption.fromJson(Map<String?, dynamic> json) => LstOption(
        groupCode: json["groupCode"],
        optionCode: json["optionCode"],
        optionName: json["optionName"],
        price: json["price"],
        discountedPrice: json["discountedPrice"],
        discountFromDate: json["discountFromDate"],
        discountToDate: json["discountToDate"],
    );

    Map<String?, dynamic> toJson() => {
        "groupCode": groupCode,
        "optionCode": optionCode,
        "optionName": optionName,
        "price": price,
        "discountedPrice": discountedPrice,
        "discountFromDate": discountFromDate,
        "discountToDate": discountToDate,
    };
}
