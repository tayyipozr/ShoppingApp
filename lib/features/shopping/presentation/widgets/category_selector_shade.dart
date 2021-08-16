import 'package:flutter/material.dart';

class CategorySelectorShade extends StatelessWidget {
  const CategorySelectorShade({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          5,
              (index) =>
              Opacity(
                opacity: 0.2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 70,
                    height: 30,
                    color: Colors.grey,
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
