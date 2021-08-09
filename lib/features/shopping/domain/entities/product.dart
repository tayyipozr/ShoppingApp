import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  Product({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.description,
    @required this.category,
    @required this.image,
  });

}
