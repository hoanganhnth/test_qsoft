import 'package:shopping_cart/data/model/product_model.dart';
import 'package:shopping_cart/utils/dummy/dummy_data.dart';

class AppLocalDatasourse {
  Future<List<ProductModel>> getHotProduct() async {
    await Future.delayed(const Duration(seconds: 3));
    return [];
  }

  Future<List<ProductModel>> getAllProduct() async {
    await Future.delayed(const Duration(seconds: 3));

    return [];
  }

  Future<List<ProductModel>> fetchCart() async {
    await Future.delayed(const Duration(seconds: 3));

    return DummyData.cartProducts;
  }

  Future<bool> addToCart(int id) async {
    await Future.delayed(const Duration(seconds: 1));

    return true;
  }

  Future<bool> updateToCart(int id, int quantity) async {
    await Future.delayed(const Duration(seconds: 1));

    return true;
  }

  Future<bool> removeToCart(int id) async {
    await Future.delayed(const Duration(seconds: 1));

    return true;
  }

  Future<bool> order() async {
    await Future.delayed(const Duration(seconds: 1));

    return true;
  }
}
