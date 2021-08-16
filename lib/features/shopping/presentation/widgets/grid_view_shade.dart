import 'package:flutter/material.dart';

class GridViewShade extends StatelessWidget {
  const GridViewShade({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 0.5),
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return Opacity(
            opacity: 0.2,
            child: Container(
              height: 250,
              width: 200,
              color: Colors.grey,
            ),
          );
        },
      ),
    );
  }
}
