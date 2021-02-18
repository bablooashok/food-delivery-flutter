import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/src/helpers/screen_navigation.dart';
import 'package:flutter_food_delivery/src/helpers/style.dart';
import 'package:flutter_food_delivery/src/models/products.dart';
import 'package:flutter_food_delivery/src/screens/details.dart';

import 'custom_text.dart';

List<Product> productList = [
  Product(
      name: "Cereals",
      price: 50,
      rating: 4.2,
      vendor: "GoodFoos",
      wishList: true,
      image: "1.jpg"),
  Product(
      name: "Taccos",
      price: 99,
      rating: 4.7,
      vendor: "GoodFoos",
      wishList: false,
      image: "5.jpg"),
  Product(
      name: "Cereals",
      price: 50,
      rating: 4.2,
      vendor: "GoodFoos",
      wishList: true,
      image: "1.jpg"),
  Product(
      name: "Taccos",
      price: 99,
      rating: 4.7,
      vendor: "GoodFoos",
      wishList: false,
      image: "5.jpg"),
];

class Featured extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productList.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(5, 14, 5, 12),
            child: GestureDetector(
              onTap: () {
                changeScreen(context, Details(product: productList[index],));
              },
              child: Container(
                height: 240,
                width: 195,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(15), 
                  boxShadow: [BoxShadow(
                      color: red[50], offset: Offset(15, 5), blurRadius: 30),
                ]),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      "images/${productList[index].image}",
                      height: 140,
                      width: 140,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomText(
                            text: productList[index].name,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: white,
                                boxShadow: [
                                  BoxShadow(
                                      color: grey[300],
                                      offset: Offset(1, 1),
                                      blurRadius: 4),
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: productList[index].wishList
                                  ? Icon(Icons.favorite, color: red, size: 18)
                                  : Icon(Icons.favorite_border,
                                      color: red, size: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: CustomText(
                                text: productList[index].rating.toString(),
                                color: grey,
                                size: 14,
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Icon(Icons.star, color: red, size: 16),
                            Icon(Icons.star, color: red, size: 16),
                            Icon(Icons.star, color: red, size: 16),
                            Icon(Icons.star, color: grey, size: 16)
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: CustomText(
                            text: "\₹${productList[index].price}",
                            weight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
