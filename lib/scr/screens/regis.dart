import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/scr/helpers/screen_navigation.dart';
import 'package:flutter_food_delivery/scr/helpers/style.dart';
import 'package:flutter_food_delivery/scr/providers/category.dart';
import 'package:flutter_food_delivery/scr/providers/product.dart';
import 'package:flutter_food_delivery/scr/providers/restaurant.dart';
import 'package:flutter_food_delivery/scr/providers/user.dart';
import 'package:flutter_food_delivery/scr/screens/login.dart';
import 'package:flutter_food_delivery/scr/widgets/custom_text.dart';
import 'package:flutter_food_delivery/scr/widgets/loading.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class RegisScreen extends StatefulWidget {
  @override
  _RegisScreenState createState() => _RegisScreenState();
}

class _RegisScreenState extends State<RegisScreen> {

  final GlobalKey<ScaffoldMessengerState> _key = GlobalKey<ScaffoldMessengerState>();
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      key: _key,
      backgroundColor: white,
      body: authProvider.status == Status.Authenticating
          ? Loading()
          : SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Image.asset(
                "assets/lg.png",
                width: 240,
                height: 240,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  // decoration: BoxDecoration(
                  //     border: Border.all(color: grey),
                  //     borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: authProvider.name,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Username",
                          labelText: "Username",
                          suffixIcon: Icon(Icons.person)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: grey),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: authProvider.email,
                      decoration: InputDecoration(
                          focusColor: red,
                          border: InputBorder.none,
                          hintText: "Emails",
                          suffixIcon: Icon(Icons.email)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: grey),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TextFormField(
                      obscureText: _isHidden,
                      controller: authProvider.password,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                          suffixIcon: InkWell(
                              onTap: _toggleView,
                              child: Icon(_isHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () async {
                    if (!await authProvider.signUp()) {
                      _key.currentState.showSnackBar(
                          SnackBar(content: Text("Registration failed!")));
                      return;
                    }
                    categoryProvider.loadCategories();
                    restaurantProvider.loadSingleRestaurant();
                    productProvider.loadProducts();
                    authProvider.clearController();
                    changeScreenReplacement(context, Home());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: red,
                        border: Border.all(color: grey),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CustomText(
                            text: "Register",
                            color: white,
                            size: 22,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  changeScreen(context, LoginScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomText(
                      text: "login here",
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}