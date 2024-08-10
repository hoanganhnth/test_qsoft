part of 'all_product_cubit.dart';

class AllProductState extends Equatable {
  final LoadingStatus? status;
  final dynamic error;
  final List<ProductModel>? listProducts;

  const AllProductState({
    this.status,
    this.error,
    this.listProducts,
  });

  factory AllProductState.initial() {
    return const AllProductState(status: LoadingStatus.initial);
  }

  AllProductState copyWith({
    LoadingStatus? status,
    dynamic error,
    List<ProductModel>? listProducts,
  }) {
    return AllProductState(
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
