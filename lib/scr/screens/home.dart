import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_food_delivery/scr/helpers/screen_navigation.dart';
import 'package:flutter_food_delivery/scr/helpers/style.dart';
import 'package:flutter_food_delivery/scr/providers/app.dart';
import 'package:flutter_food_delivery/scr/providers/category.dart';
import 'package:flutter_food_delivery/scr/providers/product.dart';
import 'package:flutter_food_delivery/scr/providers/restaurant.dart';
import 'package:flutter_food_delivery/scr/providers/user.dart';
import 'package:flutter_food_delivery/scr/screens/camera.dart';
import 'package:flutter_food_delivery/scr/screens/cart.dart';
import 'package:flutter_food_delivery/scr/screens/category.dart';
import 'package:flutter_food_delivery/scr/screens/login.dart';
import 'package:flutter_food_delivery/scr/screens/product_search.dart';
import 'package:flutter_food_delivery/scr/screens/restaurant.dart';
import 'package:flutter_food_delivery/scr/screens/restaurant_search.dart';
import 'package:flutter_food_delivery/scr/widgets/categories.dart';
import 'package:flutter_food_delivery/scr/widgets/custom_text.dart';
import 'package:flutter_food_delivery/scr/widgets/featured_products.dart';
import 'package:flutter_food_delivery/scr/widgets/loading.dart';
import 'package:flutter_food_delivery/scr/widgets/restaurant.dart';
import 'package:provider/provider.dart';

import 'order.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        elevation: 0.5,
        backgroundColor: primary,
        title: CustomText(
          text: "FoodApp",
          color: white,
        ),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.camera_alt_outlined),
                onPressed: () {
                  changeScreen(context, CameraScreen());
                },
              ),
            ],
          ),
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  changeScreen(context, CartScreen());
                },
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                      color: green, borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: primary),
              accountName: CustomText(
                text: user.userModel?.name,
                color: white,
                weight: FontWeight.bold,
                size: 18,
              ),
              accountEmail: CustomText(
                text: user.userModel?.email,
                color: white,
              ),
            ),
            ListTile(
              onTap: () async{
                await user.getOrders();

               changeScreen(context, OrderScreen());
              },
              leading: Icon(Icons.bookmark_border),
              title: CustomText(text: "My orders"),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, CartScreen());
               },
              leading: Icon(Icons.shopping_cart),
              title: CustomText(text: "Cart"),
            ),
            ListTile(
              onTap: () {
                user.signOut();
                changeScreenReplacement(context, LoginScreen());
              },
              leading: Icon(Icons.exit_to_app),
              title: CustomText(text: "Log Out"),
            ),
          ],
        ),
      ),
      backgroundColor: white,
      body: app.isLoading
          ? Container(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Loading(),
                  ],
                )
              ],
            ))
          : SafeArea(
              child: ListView(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8, left: 8, right: 8, bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.search,
                            color: red,
                          ),
                          title: TextField(
                            textInputAction: TextInputAction.search,
                            onSubmitted: (pattern) async {
                              app.changeLoading();
                              if (app.search == SearchBy.PRODUCTS) {
                                await productProvider.search(
                                    productName: pattern);
                                changeScreen(context, ProductSearchScreen());
                              } else {
                                await restaurantProvider.search(name: pattern);
                                changeScreen(
                                    context, RestaurantsSearchScreen());
                              }
                              app.changeLoading();
                            },
                            decoration: InputDecoration(
                              hintText: "Search by  ",
                              border: InputBorder.none,
                            ),
                          ),
                          trailing: DropdownButton<String>(
                              value: app.filterBy,
                              icon: Icon(Icons.filter_list, color: primary),
                              elevation: 0,
                              onChanged: (value) {
                                if (value == "Products") {
                                  app.changeSearchBy(
                                      newSearchBy: SearchBy.PRODUCTS);
                                } else {
                                  app.changeSearchBy(
                                      newSearchBy: SearchBy.RESTAURANTS);
                                }
                              },
                              items: <String>[
                                "Products",
                                "Restaurants"
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                    value: value, child: Text(value));
                              }).toList()),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryProvider.categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            await productProvider.loadProductsByCategory(
                                categoryName:
                                    categoryProvider.categories[index].name);
                            changeScreen(
                                context,
                                CategoryScreen(
                                  categoryModel:
                                      categoryProvider.categories[index],
                                ));
                          },
                          child: CategoryWidget(
                              category: categoryProvider.categories[index]),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomText(
                          text: "Featured",
                          size: 20,
                          color: grey,
                        ),
                        CustomText(
                          text: "see all",
                          size: 14,
                          color: primary,
                        ),
                      ],
                    ),
                  ),
                  Featured(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomText(
                          text: "Popular restaurants",
                          size: 20,
                          color: grey,
                        ),
                        CustomText(
                          text: "see all",
                          size: 14,
                          color: primary,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: restaurantProvider.restaurants
                        .map((item) => GestureDetector(
                              onTap: () async {
                                await productProvider.loadProductsByRestaurant(
                                    restaurantId: item.id);
                                changeScreen(
                                    context,
                                    RestaurantScreen(
                                      restaurantModel: item,
                                    ));
                              },
                              child: Container(
                                  height: 250,
                                  child: RestaurantWidget(
                                    restaurant: item,
                                  )),
                            ))
                        .toList(),
                  )
                ],
              ),
            ),
    );
  }
}