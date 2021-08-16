import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:shopping_app/constants/navigation_constants.dart';
import 'package:shopping_app/enums/cubit_enums.dart';
import 'package:shopping_app/features/profile/presentation/cubit/user_cubit.dart';
import 'package:shopping_app/features/profile/presentation/pages/user_cart_page.dart';
import 'package:shopping_app/features/profile/presentation/pages/user_profile_page.dart';
import 'package:shopping_app/features/shopping/presentation/cubit/category_cubit.dart';
import 'package:shopping_app/features/shopping/presentation/cubit/product_cubit.dart';
import 'package:shopping_app/features/shopping/presentation/pages/product_detail_page.dart';
import 'package:shopping_app/features/shopping/presentation/pages/product_overview_page.dart';
import 'package:shopping_app/injection_container.dart' as injector;

class NavigationRoute {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigationConstants.PRODUCT_OVERVIEW:
        return navigate(ProductOverviewPage(), CubitEnum.None);
      case NavigationConstants.USER_CART:
        return navigate(UserCartPage(), CubitEnum.UserCubit);
        case NavigationConstants.USER_PROFILE:
      return navigate(UserProfilePage(), CubitEnum.UserCubit);
      case NavigationConstants.PRODUCT_DETAIL:
        return navigate(ProductDetailPage(productModel: settings.arguments), CubitEnum.UserCubit);
    }
    return navigate(Scaffold(body: Center(child: Text("Not Found"))), CubitEnum.None);
  }

  MaterialPageRoute navigate(Widget widget, CubitEnum cubitEnum) {
    return MaterialPageRoute(
      builder: (context) {
        switch (cubitEnum) {
          case CubitEnum.UserCubit:
            return CubitProvider.value(
              value: injector.serviceLocator<UserCubit>(),
              child: widget,
            );
            break;
          case CubitEnum.ProductCubit:
            return CubitProvider.value(
              value: injector.serviceLocator<ProductCubit>(),
              child: widget,
            );
            break;
          case CubitEnum.CategoryCubit:
            return CubitProvider.value(
              value: injector.serviceLocator<CategoryCubit>(),
              child: widget,
            );
          case CubitEnum.None:
            return widget;
            break;
          default:
            return widget;
        }
      }
    );
  }
}
