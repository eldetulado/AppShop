import 'dart:convert';

import 'package:your_shop/models/item.dart';
export 'package:your_shop/models/item.dart';

ListItems itemsShopFromJson(String str) => ListItems.fromJson(json.decode(str));

String itemsShopToJson(ListItems data) => json.encode(data.toJson());

class ListItems {
  List<Item> items;

  ListItems({
    this.items,
  });

  factory ListItems.fromJson(Map<String, dynamic> json) => ListItems(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

