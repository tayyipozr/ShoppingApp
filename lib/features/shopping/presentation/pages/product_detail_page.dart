import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel productModel;

  ProductDetailPage({Key key, @required this.productModel}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: widget.productModel != null ? Card(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    child: Hero(tag: widget.productModel.image ,child: Image.network(widget.productModel.image, fit: BoxFit.fill)),
                  ),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: CircleAvatar(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.favorite),
                        color: Colors.orange,
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.productModel.title),
                  Text(
                    widget.productModel.price.toString(),
                  ),
                  Text(widget.productModel.description)
                ],
              ),
            ],
          ),
        ),
      ) : SizedBox.shrink(),
    );
  }
}
