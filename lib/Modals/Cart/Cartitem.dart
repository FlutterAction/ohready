import 'package:flutter/widgets.dart';
import 'package:secure_hops/Modals/Item%20Details/ItemDetails.dart';

class CartItem {
  CartItem(
      {@required this.item, @required this.options, @required this.variation});

  ItemDetailsModel? item;
  List? options;
  Variations? variation;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        item: ItemDetailsModel.fromJson(json["item"]),
        options: json["options"],
        variation: json["variations"],
      );

  Map<String, dynamic> toJson() => {
        "item": item,
        "options": List<dynamic>.from(options!.map((x) => x.toJson())),
        "variations": List<dynamic>.from(options!.map((x) => x.toJson())),
      };
}
