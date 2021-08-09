import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/features/profile/data/models/user_model/user_model.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';

abstract class UserLocalDataSource {
  Future<User> getUserInfo();

  Future<bool> addFavorite(ProductModel product);

  Future<bool> addCart(ProductModel product);

  List<ProductModel> getCart();

  List<ProductModel> getFavorites();
}

const CACHED_USER = 'CACHED_USER';
const CACHED_FAVORITES = "CACHED_FAVORITES";
const CACHED_CART = "CACHED_CART";

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<User> getUserInfo() {
    return Future.delayed(Duration(seconds: 1),
        () => User("Tayyip", "ozrtayyip@gmail.com", 21, DateTime.now(), getFavorites(), getCart()));
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
  Future<bool> addFavorite(ProductModel product) {
    final List<String> favorite = sharedPreferences.getStringList(CACHED_FAVORITES);
    if (favorite == null) {
      List<String> newList = [jsonEncode(product.toJson())];
      return sharedPreferences.setStringList(CACHED_FAVORITES, newList);
    } else {
      if (!favorite.any((element) => ProductModel.fromJson(jsonDecode(element)) == product)) {
        favorite.add(jsonEncode(product.toJson()));
        return sharedPreferences.setStringList(CACHED_FAVORITES, favorite);
      } else {
        return Future.value(false);
      }
    }
  }

  @override
  List<ProductModel> getCart() {
    List<ProductModel> cart = List<ProductModel>();
    final List<String> tempCart = sharedPreferences.getStringList(CACHED_CART);
    if (tempCart != null) {
      cart = tempCart.map((product) => ProductModel.fromJson(jsonDecode(product))).toList();
    }
    return cart;
  }

  @override
  List<ProductModel> getFavorites() {
    List<ProductModel> favorites = List<ProductModel>();
    final List<String> tempFav = sharedPreferences.getStringList(CACHED_FAVORITES);

    if (tempFav != null) {
      favorites = tempFav.map((product) => ProductModel.fromJson(jsonDecode(product))).toList();
    }
    return favorites;
  }
}
