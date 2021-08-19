import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

abstract class ProductLocalDataSource {}

const CACHED_PRODUCT = 'CACHED_PRODUCT';

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({@required this.sharedPreferences});
}
