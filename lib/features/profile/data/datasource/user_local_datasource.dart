import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/core/error/exceptions.dart';
import 'package:shopping_app/features/profile/data/models/user_model/user_model.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';

abstract class UserLocalDataSource {
  Future<User> getUserInfo();

  Future<bool> addCart(ProductModel product);

  Future<bool> deleteCart(ProductModel product);

  Future<List<ProductModel>> getCart();

}

const CACHED_USER = 'CACHED_USER';
const CACHED_FAVORITES = "CACHED_FAVORITES";
const CACHED_CART = "CACHED_CART";

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<User> getUserInfo() async {
    List<ProductModel> cart = await getCart();
    return Future.delayed(Duration(seconds: 1),
        () => User("Tayyip", "ozrtayyip@gmail.com", 21, DateTime.now(), cart));
  }

  @override
  Future<bool> addCart(ProductModel product) {
    final List<String> cart = sharedPreferences.getStringList(CACHED_CART);
    if (cart == null) {
      List<String> newList = [jsonEncode(product.toJson())];
      return sharedPreferences.setStringList(CACHED_CART, newList);
    } else {
      if (!cart.any((element) => ProductModel.fromJson(jsonDecode(element)) == product)) {
        cart.add(jsonEncode(product.toJson()));
        return sharedPreferences.setStringList(CACHED_CART, cart);
      } else {
        return Future.value(false);
      }
    }
  }

  @override
  Future<bool> deleteCart(ProductModel product) {
    List<String> cart = sharedPreferences.getStringList(CACHED_CART);
    if (cart != null) {
      final List<ProductModel> products = cart.map((product) => ProductModel.fromJson(jsonDecode(product))).toList();
      int index = products.indexWhere((element) => element.id == product.id);
      products.removeAt(index);
      cart = products.map((product) => jsonEncode(product.toJson())).toList();
      return sharedPreferences.setStringList(CACHED_CART, cart);
    }
    return Future.value(false);
  }


  @override
  Future<List<ProductModel>> getCart() async {
    List<ProductModel> cart = List<ProductModel>();
    final List<String> tempCart = sharedPreferences.getStringList(CACHED_CART);
    print(tempCart);
    if (tempCart != null) {
      cart = tempCart.map((product) => ProductModel.fromJson(jsonDecode(product))).toList();
      return Future.delayed(Duration(milliseconds: 700), () => cart);
    } else {
      throw CacheException();
    }
  }

}
