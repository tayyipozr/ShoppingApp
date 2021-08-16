import 'package:shopping_app/core/error/failure.dart';
import 'package:shopping_app/core/usecases/usecase.dart';
import 'package:cubit/cubit.dart';
import 'package:shopping_app/features/profile/data/models/user_model/user_model.dart';
import 'package:shopping_app/features/profile/domain/usecases/add_cart.dart';
import 'package:shopping_app/features/profile/domain/usecases/delete_cart.dart';
import 'package:shopping_app/features/profile/domain/usecases/get_cart.dart';
import 'package:shopping_app/features/profile/domain/usecases/get_userinfo.dart';
import 'package:shopping_app/features/profile/presentation/cubit/user_state.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';

class UserCubit extends Cubit<UserState> {
  final AddCart _addCart;
  final GetUserInfo _getUserInfo;
  final GetCart _getCart;
  final DeleteCart _deleteCart;

  UserCubit(this._addCart, this._getUserInfo, this._getCart, this._deleteCart) : super(UserInitial());

  Future<void> addCart(ProductModel product) async {
    emit(UserLoading());
    final response = await _addCart(Params.product(product));
    response.fold((failure) {
      emit(UserError(failure is CacheFailure ? "Check your internet connection" : "An error occurred"));
    }, (isAdded) {
      emit(UserCartAdded(isAdded));
    });
    getCart();
  }

  Future<bool> deleteCart(ProductModel product) async {
    final response = await _deleteCart(Params.product(product));
    bool _isDeleted = false;
    response.fold((failure) {
      emit(UserError(failure is CacheFailure ? "Check your internet connection" : "An error occurred"));
      return false;
    }, (isDeleted) {
      emit(UserCartDeleted(isDeleted));
      _isDeleted = isDeleted;
    });
    getCart();
    return _isDeleted;
  }

  Future<void> getUserInfo() async {
    emit(UserLoading());
    final response = await _getUserInfo(NoParams());
    response.fold((failure) {
      emit(UserError(failure is ServerFailure ? "Check your internet connection" : "An error occurred"));
    }, (user) {
      emit(UserLoaded(user));
    });
  }

  Future<void> getCart() async {
    emit(UserCartLoading());
    final response = await _getCart(NoParams());
    response.fold((failure) {
      emit(UserError(failure is ServerFailure ? "Check your internet connection" : "An error occurred"));
    }, (cart) {
      emit(UserGetCart(cart));
    });
  }
}
