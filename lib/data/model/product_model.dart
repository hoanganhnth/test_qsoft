import 'package:shopping_cart/utils/helper/helper.dart';

class ProductModel {
  int? id;
  String? name;
  double? price;
  int? limit;
  String? currency;
  String? image;
  int? number;
  ProductModel(
      {this.id,
      this.name,
      this.price,
      this.limit,
      this.currency,
      this.image,
      this.number});
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["title"];
    price = json["price"];
    limit = json["limit"];
    currency = json["currency"];
    image = json["image"];
    number = json["number"];
  }

  String getTextPrice({int number = 1}) {
    return Helper.formatPrice((price ?? 0) * number, currency ?? "");
  }

  double getTotalPrice() {
    if (number != null) {
      return number! * (price ?? 0);
    }
    return price ?? 0;
  }

  ProductModel copyWith({
    int? id,
    String? name,
    double? price,
    int? limit,
    String? currency,
    String? image,
    int? number,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      limit: limit ?? this.limit,
      currency: currency ?? this.currency,
      image: image ?? this.image,
      number: number ?? this.number,
    );
  }
}
