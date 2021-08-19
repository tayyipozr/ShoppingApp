import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/features/shopping/data/datasources/product_local_datasource.dart';

import 'product_local_datasource_test.mocks.dart';


@GenerateMocks([SharedPreferences])
void main() {
  MockSharedPreferences mockSharedPreferences = MockSharedPreferences();
  ProductLocalDataSource dataSource = ProductLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);

}
