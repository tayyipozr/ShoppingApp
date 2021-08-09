import 'package:meta/meta.dart';
import 'package:shopping_app/features/profile/data/models/user_model/user_model.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';


@immutable
abstract class UserState {
  const UserState();
}

class UserInitial extends UserState {
  const UserInitial();

}

class UserLoading extends UserState {
  const UserLoading();
}

class UserLoaded extends UserState {
  final User user;

  const UserLoaded(this.user);
}

class CartAdded extends UserState {
  final bool isAdded;

  const CartAdded(this.isAdded);
}

class FavoriteAdded extends UserState {
  final bool isAdded;

  const FavoriteAdded(this.isAdded);
}

class UserGetCart extends UserState {
  final List<ProductModel> cart;

  const UserGetCart(this.cart);
}

class UserGetFavorites extends UserState {
  final List<ProductModel> favorites;

  const UserGetFavorites(this.favorites);
}


class UserError extends UserState {
  final String message;

  const UserError(this.message);
}
