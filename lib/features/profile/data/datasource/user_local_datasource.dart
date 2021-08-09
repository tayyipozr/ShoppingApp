import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/features/profile/data/models/user_model/user_model.dart';

abstract class UserLocalDataSource {
  Future<User> getUserInfo();

  Future<bool> addFavorite(int id);

  Future<bool> addCart(int id);
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
        () => User("Tayyip", "ozrtayyip@gmail.com", 21, DateTime.now(), List<int>(), List<int>()));
  }

  @override
  Future<bool> addCart(int id) {
    final List<String> cart = sharedPreferences.getStringList(CACHED_CART);
    if (cart == null) {
      List<String> newList = [id.toString()];
      return sharedPreferences.setStringList(CACHED_CART, newList);
    } else {
      cart.add(id.toString());
      return sharedPreferences.setStringList(CACHED_CART, cart);
    }
  }

  @override
  Future<bool> addFavorite(int id) {
    final List<String> favorite = sharedPreferences.getStringList(CACHED_FAVORITES);
    if (favorite == null) {
      List<String> newList = [id.toString()];
      return sharedPreferences.setStringList(CACHED_FAVORITES, newList);
    } else {
      favorite.add(id.toString());
      return sharedPreferences.setStringList(CACHED_FAVORITES, favorite);
    }
  }
}
