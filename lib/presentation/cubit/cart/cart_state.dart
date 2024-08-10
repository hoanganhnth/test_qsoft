part of 'cart_cubit.dart';


class CartState extends Equatable {
  final LoadingStatus? status;
  final dynamic error;
  final List<ProductModel>? listProducts;

  const CartState({
    this.status,
    this.error,
    this.listProducts,
  });

  factory CartState.initial() {
    return const CartState(status: LoadingStatus.initial);
  }

  CartState copyWith({
    LoadingStatus? status,
    dynamic error,
    List<ProductModel>? listProducts,
  }) {
    return CartState(
      status: status ?? LoadingStatus.initial,
      error: error ?? this.error,
      listProducts: listProducts ?? this.listProducts,
    );
  }

  @override
  List<Object?> get props => [
        status,
        error,
        listProducts,
      ];
}
