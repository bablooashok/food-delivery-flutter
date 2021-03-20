import 'package:flutter/material.dart';
import 'custom_text.dart';

class BottomNavIcon extends StatelessWidget {
  final String image;
  final String name;

  const BottomNavIcon({Key key, this.image, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {},
        child: Column(
          children: <Widget>[
            Image.asset(
              "images/$image",
              width: 23,
              height: 23,
            ),
            SizedBox(
              height: 2,
            ),
            CustomText(
              text: name,
            )
          ],
        ),
      ),
    );
  }
}
