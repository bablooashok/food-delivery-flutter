import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/scr/helpers/screen_navigation.dart';
import 'package:flutter_food_delivery/scr/helpers/style.dart';
import 'package:flutter_food_delivery/scr/models/product.dart';
import 'package:flutter_food_delivery/scr/providers/product.dart';
import 'package:flutter_food_delivery/scr/screens/details.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'custom_text.dart';
import 'loading.dart';

class Featured extends StatelessWidget {
  final ProductModel product;

  const Featured({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Container(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productProvider.products.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(5, 14, 5, 12),
            child: GestureDetector(
              onTap: () {
                changeScreen(
                    context,
                    Details(
                      product: productProvider.products[index],
                    ));
              },
              child: Container(
                height: 220,
                width: 195,
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: red[50],
                          offset: Offset(15, 5),
                          blurRadius: 30),
                    ]),
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                              child: Align(
                            alignment: Alignment.center,
                            child: Loading(),
                          )),
                          Center(
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: productProvider.products[index].image,
                              height: 120,
                              width: 195,
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomText(
                            text: productProvider.products[index].name,
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
                              child: productProvider.products[index].featured
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
                                text: productProvider.products[index].rating
                                    .toString(),
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
                            text: "\₹${productProvider.products[index].price}",
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
