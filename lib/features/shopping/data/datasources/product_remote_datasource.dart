import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopping_app/core/error/exceptions.dart';
import 'package:shopping_app/constants/endpoints.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();

  Future<ProductModel> getProduct(int productId);

  Future<List<String>> getCategories();

  Future<List<ProductModel>> getProductsByCategory(String categoryName);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  static const Map<String, String> _headers = {"Content-Type": "application/json"};

  ProductRemoteDataSourceImpl(this.client);

  @override
  Future<ProductModel> getProduct(int productId) async {
    final response = await client.get(Uri.parse(Endpoints.product + '$productId'), headers: _headers);
    if (response.statusCode == 200)
      return ProductModel.fromJson(jsonDecode(response.body));
    else
      throw ServerException();
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await client.get(Uri.parse(Endpoints.products), headers: _headers);
    if (response.statusCode == 200) {
      final Iterable decoded = jsonDecode(response.body);
      List<ProductModel> products = decoded.map((product) => ProductModel.fromJson(product)).toList();
      return products;
    } else
      throw ServerException();
  }

  @override
  Future<List<String>> getCategories() async {
    final response = await client.get(Uri.parse(Endpoints.categories), headers: _headers);
    if (response.statusCode == 200) {
      final Iterable decoded = jsonDecode(response.body);
      List<String> categories = decoded.map((string) => string.toString()).toList();
      return categories;
    } else
      throw ServerException();
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String categoryName) async {
    final response = await client.get(Uri.parse(Endpoints.category + '$categoryName'), headers: _headers);
    if (response.statusCode == 200) {
      final Iterable decoded = jsonDecode(response.body);
      List<ProductModel> products = decoded.map((product) => ProductModel.fromJson(product)).toList();
      return products;
    } else
      throw ServerException();
  }
}
