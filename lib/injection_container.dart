import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/features/profile/domain/repositories/user_repository.dart';
import 'package:shopping_app/features/profile/domain/usecases/add_favorite.dart';
import 'package:shopping_app/features/profile/domain/usecases/get_userinfo.dart';
import 'package:shopping_app/features/profile/presentation/cubit/user_cubit.dart';
import 'package:shopping_app/features/shopping/data/datasources/product_remote_datasource.dart';
import 'package:shopping_app/features/shopping/data/repositories/product_repository_impl.dart';
import 'package:shopping_app/features/shopping/domain/repositories/product_repository.dart';
import 'package:shopping_app/features/shopping/domain/usecases/get_categories.dart';
import 'package:shopping_app/features/shopping/domain/usecases/get_product.dart';
import 'package:shopping_app/features/shopping/domain/usecases/get_products_by_categories.dart';
import 'package:shopping_app/features/shopping/presentation/cubit/category_cubit.dart';
import 'package:shopping_app/features/shopping/presentation/cubit/product_cubit.dart';

import 'features/profile/data/datasource/user_local_datasource.dart';
import 'features/profile/data/repositories/user_repository_impl.dart';
import 'features/profile/domain/usecases/add_cart.dart';
import 'features/shopping/data/datasources/product_local_datasource.dart';
import 'features/shopping/domain/usecases/get_products.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  // Features
  serviceLocator.registerFactory(() => ProductCubit(serviceLocator(), serviceLocator(), serviceLocator()));
  serviceLocator.registerFactory(() => CategoryCubit(serviceLocator()));
  serviceLocator.registerFactory(() => UserCubit(serviceLocator(), serviceLocator(), serviceLocator()));

  // UseCases
  serviceLocator.registerLazySingleton(() => GetProduct(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetProducts(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetProductsByCategories(serviceLocator()));

  serviceLocator.registerLazySingleton(() => AddCart(serviceLocator()));
  serviceLocator.registerLazySingleton(() => AddFavorite(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetUserInfo(serviceLocator()));

  serviceLocator.registerLazySingleton(() => GetCategories(serviceLocator()));

  // Repositories
  serviceLocator.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(localDataSource: serviceLocator(), remoteDataSource: serviceLocator()));

  serviceLocator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(localDataSource: serviceLocator()));

  // DataSources
  serviceLocator.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sharedPreferences: serviceLocator()));
  serviceLocator.registerLazySingleton<ProductRemoteDataSource>(() => ProductRemoteDataSourceImpl(serviceLocator()));

  serviceLocator.registerLazySingleton<UserLocalDataSource>(
          () => UserLocalDataSourceImpl(sharedPreferences: serviceLocator()));

  // Core

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => http.Client());
}
