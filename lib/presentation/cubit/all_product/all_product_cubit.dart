import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_cart/data/model/product_model.dart';
import 'package:shopping_cart/usecase/app_usecase.dart';
import 'package:shopping_cart/utils/enum/loading_status.dart';
import 'package:shopping_cart/utils/exception/base_error.dart';

part 'all_product_state.dart';

class AllProductCubit extends Cubit<AllProductState> {
  final AppUsecase _appUsecase;
  AllProductCubit(this._appUsecase) : super(AllProductState.initial());

  Future<void> fetchHotProducts() async {
    try {
      emit(state.copyWith(status: LoadingStatus.loading));
      final listProduct = await _appUsecase.getAllProduct();
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
}
