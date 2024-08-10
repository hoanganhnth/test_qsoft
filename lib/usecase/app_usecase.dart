import 'package:shopping_cart/data/model/product_model.dart';
import 'package:shopping_cart/repository/app_repository.dart';

class AppUsecase {
  final AppRepository _appRepository;
  AppUsecase(this._appRepository);
  Future<List<ProductModel>> getHotProduct() {
    return _appRepository.getHotProduct();
  }

  Future<List<ProductModel>> getAllProduct() {
    return _appRepository.getAllProduct();
  }

  Future<bool> addToCart(int productId) {
    return _appRepository.addToCart(productId);
  }

  Future<bool> updateToCart(int productId, int quantity) {
    return _appRepository.updateToCart(productId, quantity);
  }

  Future<bool> removeToCart(int productId) {
    return _appRepository.removeToCart(productId);
  }

  Future<List<ProductModel>> fetchCart() {
    return _appRepository.fetchCart();
  }

  Future<bool> order() {
    return _appRepository.order();
  }
}
