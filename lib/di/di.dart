import 'package:get_it/get_it.dart';
import 'package:shopping_cart/data/datasourse/app_local_datasourse.dart';
import 'package:shopping_cart/data/repositories/app_reposotory_impl.dart';
import 'package:shopping_cart/presentation/cubit/all_product/all_product_cubit.dart';
import 'package:shopping_cart/presentation/cubit/cart/cart_cubit.dart';
import 'package:shopping_cart/presentation/cubit/hot_prouduct/hot_product_cubit.dart';
import 'package:shopping_cart/repository/app_repository.dart';
import 'package:shopping_cart/usecase/app_usecase.dart';

Future<void> setupDi() async {
  final getIt = GetIt.I;

  getIt.registerLazySingleton<AppLocalDatasourse>(() => AppLocalDatasourse());
  getIt.registerLazySingleton<AppRepository>(() => AppRepositoryImpl(getIt()));
  getIt.registerLazySingleton<AppUsecase>(() => AppUsecase(getIt()));

  getIt.registerFactory<AllProductCubit>(() => AllProductCubit(getIt()));
  getIt.registerFactory<HotProductCubit>(() => HotProductCubit(getIt()));
  getIt.registerLazySingleton<CartCubit>(() => CartCubit(getIt()));
}
