import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/scr/helpers/screen_navigation.dart';
import 'package:flutter_food_delivery/scr/helpers/style.dart';
import 'package:flutter_food_delivery/scr/providers/category.dart';
import 'package:flutter_food_delivery/scr/providers/product.dart';
import 'package:flutter_food_delivery/scr/providers/restaurant.dart';
import 'package:flutter_food_delivery/scr/providers/user.dart';
import 'package:flutter_food_delivery/scr/screens/home.dart';
import 'package:flutter_food_delivery/scr/screens/registration.dart';
import 'package:flutter_food_delivery/scr/widgets/custom_text.dart';
import 'package:flutter_food_delivery/scr/widgets/loading.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldMessengerState> _key =
      GlobalKey<ScaffoldMessengerState>();
  bool _isHidden = true;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

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
          : Form(
        autovalidateMode: AutovalidateMode.always,

        key: formkey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/lg.png",
                      width: 240,
                      height: 240,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: TextFormField(
                        autofocus: true,
                        controller: authProvider.email,
                        decoration: InputDecoration(
                            labelText: "E-Mail",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            suffixIcon: Icon(Icons.email)),
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: "This field is required"),
                          EmailValidator(errorText: "Enter a valid email")
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: TextFormField(
                        autofocus: true,
                        obscureText: _isHidden,
                        controller: authProvider.password,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          suffixIcon: InkWell(
                              onTap: _toggleView,
                              child: Icon(_isHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                        ),
                        validator: RequiredValidator(
                            errorText: "This field is required *"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () async {
                          if (!await authProvider.signIn()) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(20)),
                                    child: Container(
                                      height: 100,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Email or Password is incorrect",
                                            ),
                                            TextButton(
                                                onPressed: (){Navigator.pop(context);},
                                                child: Text("OKAY"))
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                            // _key.currentState.showSnackBar(
                            //     SnackBar(content: Text("Login failed!")));
                            return;
                          }
                          categoryProvider.loadCategories();
                          restaurantProvider.loadRestaurants();
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
                                  text: "Login",
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
                        changeScreen(context, RegistrationScreen());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CustomText(
                            text: "Register here",
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
