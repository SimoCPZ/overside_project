///Model class to decode the 'variants' list in the Product model.

class Variant {
  int? id;
  num price;
  int? compareAtPrice;
  String? option1;
  String? option2;
  String sku;

  Variant(
      {required this.id,
      required this.price,
      required this.compareAtPrice,
      required this.option1,
      required this.option2,
      required this.sku});

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
        id: json["id"],
        price: json["price"],
        compareAtPrice: json["compare_at_price"],
        option1: json["option1"],
        option2: json["option2"],
        sku: json["sku"]);
  }
}
