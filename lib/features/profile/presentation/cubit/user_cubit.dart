import 'package:shopping_app/core/error/failure.dart';
import 'package:shopping_app/core/usecases/usecase.dart';
import 'package:cubit/cubit.dart';
import 'package:shopping_app/features/profile/domain/usecases/add_cart.dart';
import 'package:shopping_app/features/profile/domain/usecases/add_favorite.dart';
import 'package:shopping_app/features/profile/domain/usecases/get_userinfo.dart';
import 'package:shopping_app/features/profile/presentation/cubit/user_state.dart';

class UserCubit extends Cubit<UserState> {
  final AddCart _addCart;
  final AddFavorite _addFavorite;
  final GetUserInfo _getUserInfo;

  UserCubit(this._addCart, this._addFavorite, this._getUserInfo) : super(UserInitial());

  Future<void> addCart(int productId) async {
    emit(UserLoading());
    final response = await _addCart(Params.id(productId));
    response.fold((failure) {
      emit(UserError(failure is ServerFailure ? "Check your internet connection" : "An error occured"));
    }, (isAdded) {
      emit(CartAdded(isAdded));
    });
  }

  Future<void> addFavorite(int productId) async {
    emit(UserLoading());
    final response = await _addFavorite(Params.id(productId));
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

}
