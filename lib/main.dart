import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:shopping_app/constants/navigation_route.dart';
import 'package:shopping_app/features/profile/presentation/pages/user_profile_page.dart';
import 'package:shopping_app/features/shopping/presentation/cubit/product_cubit.dart';
import 'package:shopping_app/features/shopping/presentation/pages/product_overview_page.dart';
import 'features/profile/presentation/cubit/user_cubit.dart';
import 'features/shopping/presentation/cubit/category_cubit.dart';
import 'injection_container.dart' as injection;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injection.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: injection.serviceLocator<NavigationRoute>().generateRoute,
      home: MultiCubitProvider(
        providers: [
          CubitProvider<ProductCubit>(
            create: (BuildContext context) => injection.serviceLocator<ProductCubit>(),
            lazy: false,
          ),
          CubitProvider<CategoryCubit>(
            create: (BuildContext context) => injection.serviceLocator<CategoryCubit>(),
            lazy: false,
          ),
          CubitProvider<UserCubit>(
            create: (BuildContext context) => injection.serviceLocator<UserCubit>(),
            lazy: false,
          ),
        ],
        child: ProductOverviewPage(),
      ),
    );
  }
}

