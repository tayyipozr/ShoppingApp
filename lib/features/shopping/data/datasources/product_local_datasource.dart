import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';
import 'package:shopping_app/features/shopping/domain/entities/product.dart';
import 'package:meta/meta.dart';

abstract class ProductLocalDataSource {
  Future<ProductModel> getLastProduct();
  Future<void> cacheProduct(ProductModel product);
}

const CACHED_PRODUCT = 'CACHED_PRODUCT';

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<void> cacheProduct(ProductModel product) {
    // TODO: implement cacheProduct
    throw UnimplementedError();
  }

  @override
  Future<ProductModel> getLastProduct() {
    final jsonString = sharedPreferences.getString(CACHED_PRODUCT);
    return Future.value(ProductModel.fromJson(jsonDecode(jsonString)));
  }
}
