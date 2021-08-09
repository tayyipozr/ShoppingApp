import 'package:shopping_app/core/error/failure.dart';
import 'package:shopping_app/core/usecases/usecase.dart';
import 'package:cubit/cubit.dart';
import 'package:shopping_app/features/profile/domain/usecases/add_cart.dart';
import 'package:shopping_app/features/profile/domain/usecases/add_favorite.dart';
import 'package:shopping_app/features/profile/domain/usecases/get_cart.dart';
import 'package:shopping_app/features/profile/domain/usecases/get_favorites.dart';
import 'package:shopping_app/features/profile/domain/usecases/get_userinfo.dart';
import 'package:shopping_app/features/profile/presentation/cubit/user_state.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';

class UserCubit extends Cubit<UserState> {
  final AddCart _addCart;
  final AddFavorite _addFavorite;
  final GetUserInfo _getUserInfo;
  final GetCart _getCart;
  final GetFavorites _getFavorites;

  UserCubit(this._addCart, this._addFavorite, this._getUserInfo, this._getCart, this._getFavorites) : super(UserInitial());

  Future<void> addCart(ProductModel product) async {
    emit(UserLoading());
    final response = await _addCart(Params.product(product));
    response.fold((failure) {
      emit(UserError(failure is ServerFailure ? "Check your internet connection" : "An error occured"));
    }, (isAdded) {
      emit(CartAdded(isAdded));
    });
  }

  Future<void> addFavorite(ProductModel product) async {
    emit(UserLoading());
    final response = await _addFavorite(Params.product(product));
    response.fold((failure) {
      emit(UserError(failure is ServerFailure ? "Check your internet connection" : "An error occured"));
    }, (isAdded) {
      emit(FavoriteAdded(isAdded));
    });
  }

  Future<void> getUserInfo() async {
    emit(UserLoading());
    final response = await _getUserInfo(NoParams());
    response.fold((failure) {
      emit(UserError(failure is ServerFailure ? "Check your internet connection" : "An error occured"));
    }, (user) {
      emit(UserLoaded(user));
    });
  }

  Future<void> getFavorites() async {
    final response = await _getFavorites(NoParams());
    response.fold((failure) {
      emit(UserError(failure is ServerFailure ? "Check your internet connection" : "An error occured"));
    }, (favorites) {
      emit(UserGetFavorites(favorites));
    });
  }

  Future<void> getCart() async {
    final response = await _getCart(NoParams());
    response.fold((failure) {
      emit(UserError(failure is ServerFailure ? "Check your internet connection" : "An error occured"));
    }, (cart) {
      emit(UserGetCart(cart));
    });
  }
}
