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

class UserCartLoading extends UserState {
  const UserCartLoading();
}

class UserCartAdded extends UserState {
  final bool isAdded;

  const UserCartAdded(this.isAdded);
}

class UserCartDeleted extends UserState {
  final bool isDeleted;

  const UserCartDeleted(this.isDeleted);
}

class UserGetCart extends UserState {
  final List<ProductModel> cart;

  const UserGetCart(this.cart);
}

class UserError extends UserState {
  final String message;

  const UserError(this.message);
}




