import 'package:flutter/material.dart';

class CategoryItemCard extends StatelessWidget {
  const CategoryItemCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/pizza/pizza_1.jpg"),
                fit: BoxFit.cover),
          ),
        ),
        Container(
          color: Colors.black.withOpacity(.4),
        ),
        Align(
          alignment: Alignment.center,
          child: Text("South Indian ",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: Colors.white)),
        ),
      ],
    );
  }
}
