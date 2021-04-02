import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/scr/helpers/screen_navigation.dart';
import 'package:flutter_food_delivery/scr/helpers/style.dart';
import 'package:flutter_food_delivery/scr/providers/category.dart';
import 'package:flutter_food_delivery/scr/providers/product.dart';
import 'package:flutter_food_delivery/scr/providers/restaurant.dart';
import 'package:flutter_food_delivery/scr/providers/user.dart';
import 'package:flutter_food_delivery/scr/widgets/custom_text.dart';
import 'package:flutter_food_delivery/scr/widgets/loading.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import 'login.dart';
import 'home.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _key =
      GlobalKey<ScaffoldMessengerState>();
  bool _isHidden = true;
  String password;
  String confirmPass;

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
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
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
                      TextFormField(
                        autofocus: true,
                        controller: authProvider.name,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            labelText: "Username",
                            suffixIcon: Icon(Icons.person)),
                        validator: RequiredValidator(
                            errorText: "This field is required *"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: TextFormField(
                          controller: authProvider.email,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              labelText: "E Mail",
                              suffixIcon: Icon(Icons.email)),
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "This field is required"),
                            EmailValidator(errorText: "Enter a valid email")
                          ]),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: TextFormField(
                          obscureText: true,
                          controller: authProvider.password,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              labelText: "Password",
                              suffixIcon: Icon(Icons.lock)),
                          onChanged: (val) => password = val,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "This field is required *"),
                            MinLengthValidator(7,
                                errorText:
                                    "Password should be of minimum 7 characters"),
                            PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                                errorText:
                                    'Passwords must have at least one special character')
                          ]),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: TextFormField(
                          obscureText: _isHidden,
                          // controller: authProvider.password,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              labelText: "Re-Type Password",
                              suffixIcon: InkWell(
                                  onTap: _toggleView,
                                  child: Icon(_isHidden
                                      ? Icons.visibility
                                      : Icons.visibility_off))),
                          validator: (val) => MatchValidator(
                                  errorText: 'Passwords do not match')
                              .validateMatch(val, password),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (password != confirmPass &&
                                !await authProvider.signUp()) {
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
                                                "Username or Email already in use",
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
                              return;
                            }
                            categoryProvider.loadCategories();
                            restaurantProvider.loadRestaurants();
                            productProvider.loadProducts();
                            authProvider.clearController();
                            changeScreenReplacement(context, Home());
                          },
                          child: CustomText(
                            text: "Register",
                            size: 20,
                            color: white,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          changeScreen(context, LoginScreen());
                        },
                        child: CustomText(
                          text: "Login here",
                          size: 20,
                          color: white,
                        ),
                      )
                    ],
                  ),
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
