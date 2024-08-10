import 'package:shopping_cart/data/datasourse/app_local_datasourse.dart';
import 'package:shopping_cart/data/model/product_model.dart';
import 'package:shopping_cart/repository/app_repository.dart';

class AppRepositoryImpl implements AppRepository {
  final AppLocalDatasourse _appLocalDatasourse;
  AppRepositoryImpl(this._appLocalDatasourse);
  @override
  Future<List<ProductModel>> getHotProduct() async {
    return _appLocalDatasourse.getHotProduct();
  }

  @override
  Future<List<ProductModel>> getAllProduct() {
    return _appLocalDatasourse.getAllProduct();
  }

  @override
  Future<List<ProductModel>> fetchCart() {
    return _appLocalDatasourse.fetchCart();
  }

  @override
  Future<bool> addToCart(int productId) {
    return _appLocalDatasourse.addToCart(productId);
  }

  @override
  Future<bool> updateToCart(int productId, int quantity) {
    return _appLocalDatasourse.updateToCart(productId, quantity);
  }

  @override
  Future<bool> removeToCart(int productId) {
    return _appLocalDatasourse.removeToCart(productId);
  }

  @override
  Future<bool> order() {
    return _appLocalDatasourse.order();
  }
}
