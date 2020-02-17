class Item {
  int id;
  String name;
  int price;
  String urlImage;

  Item({
    this.id,
    this.name,
    this.price,
    this.urlImage,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        urlImage: json["urlImage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "urlImage": urlImage,
      };
}
