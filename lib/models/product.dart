import 'variant.dart';

///Model class for the products that you get calling the API.
class Product {
  int id;
  String handle;
  String title;
  List<Variant> variants;

  Product(
      {required this.id,
      required this.handle,
      required this.title,
      required this.variants});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json["id"],
        handle: json["handle"],
        title: json["title"],
        variants: List<Variant>.from(
            json["variants"].map((v) => Variant.fromJson(v))));
  }
}
