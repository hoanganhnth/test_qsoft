part of 'hot_product_cubit.dart';

class HotProductState extends Equatable {
  final LoadingStatus? status;
  final dynamic error;
  final List<ProductModel>? listProducts;

  const HotProductState({
    this.status,
    this.error,
    this.listProducts,
  });

  factory HotProductState.initial() {
    return const HotProductState(status: LoadingStatus.initial);
  }

  HotProductState copyWith({
    LoadingStatus? status,
    dynamic error,
    List<ProductModel>? listProducts,
  }) {
    return HotProductState(
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
