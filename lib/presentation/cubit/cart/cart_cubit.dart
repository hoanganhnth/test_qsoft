import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_cart/data/model/product_model.dart';
import 'package:shopping_cart/usecase/app_usecase.dart';
import 'package:shopping_cart/utils/enum/loading_status.dart';
import 'package:shopping_cart/utils/exception/base_error.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final AppUsecase _appUsecase;
  CartCubit(this._appUsecase) : super(CartState.initial());

  Future<void> fetchCart() async {
    try {
      emit(state.copyWith(status: LoadingStatus.loading));
      final listProduct = await _appUsecase.fetchCart();
      // List<ProductModel> listProduct = [];

      emit(state.copyWith(
        status: LoadingStatus.success,
        listProducts: listProduct,
      ));
    } catch (e) {
      emit(
        state.copyWith(
            status: LoadingStatus.failure,
            error: BaseError.fromObjectErr(e).errMsgToastToUser),
      );
    }
  }

  Future<void> removeToCart(int id) async {
    try {
      emit(state.copyWith(status: LoadingStatus.loadingMore));
      final result = await _appUsecase.removeToCart(id);
      // List<ProductModel> listProduct = [];
      if (result) {
        emit(state.copyWith(
            status: LoadingStatus.success,
            listProducts: (state.listProducts ?? [])
              ..removeWhere((e) => e.id == id)));
      } else {
        emit(state.copyWith(
          status: LoadingStatus.failure,
        ));
      }
    } catch (e) {
      emit(
        state.copyWith(
            status: LoadingStatus.failure,
            error: BaseError.fromObjectErr(e).errMsgToastToUser),
      );
    }
  }

  Future<void> addProductToCart(ProductModel product) async {
    try {
      emit(state.copyWith(status: LoadingStatus.loading));
      final result = await _appUsecase.addToCart(product.id ?? 0);
      // List<ProductModel> listProduct = [];
      if (result) {
        emit(state.copyWith(
            status: LoadingStatus.success,
            listProducts: (state.listProducts ?? [])..add(product)));
      } else {
        emit(state.copyWith(
          status: LoadingStatus.failure,
        ));
      }
    } catch (e) {
      emit(
        state.copyWith(
            status: LoadingStatus.failure,
            error: BaseError.fromObjectErr(e).errMsgToastToUser),
      );
    }
  }

  Future<void> updateProductToCart(ProductModel product, int quantity) async {
    try {
      emit(state.copyWith(status: LoadingStatus.loadingMore));
      final result = await _appUsecase.updateToCart(product.id ?? 0, quantity);
      // List<ProductModel> listProduct = [];
      List<ProductModel> products = List.from((state.listProducts ?? []));

      products.firstWhere((element) => element.id == product.id).number =
          quantity;
      if (result) {
        emit(state.copyWith(
            status: LoadingStatus.success, listProducts: products));
      } else {
        emit(state.copyWith(
          status: LoadingStatus.failure,
        ));
      }
    } catch (e) {
      emit(
        state.copyWith(
            status: LoadingStatus.failure,
            error: BaseError.fromObjectErr(e).errMsgToastToUser),
      );
    }
  }

  Future<void> order() async {
    try {
      emit(state.copyWith(status: LoadingStatus.loading));
      final result = await _appUsecase.order();

      if (result) {
        emit(state.copyWith(status: LoadingStatus.success, listProducts: []));
      } else {
        emit(state.copyWith(
          status: LoadingStatus.failure,
        ));
      }
    } catch (e) {
      emit(
        state.copyWith(
            status: LoadingStatus.failure,
            error: BaseError.fromObjectErr(e).errMsgToastToUser),
      );
    }
  }
}
