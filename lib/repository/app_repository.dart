import 'package:shopping_cart/data/model/product_model.dart';

abstract class AppRepository {
  Future<List<ProductModel>> getHotProduct();
  Future<List<ProductModel>> getAllProduct();
  Future<List<ProductModel>> fetchCart();
  Future<bool> addToCart(int productId);
  Future<bool> removeToCart(int productId);
  Future<bool> updateToCart(int productId, int quantity);
  Future<bool> order();
}
