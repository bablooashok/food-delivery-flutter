import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/scr/helpers/order.dart';
import 'package:flutter_food_delivery/scr/helpers/style.dart';
import 'package:flutter_food_delivery/scr/providers/app.dart';
import 'package:flutter_food_delivery/scr/providers/user.dart';
import 'package:flutter_food_delivery/scr/widgets/custom_text.dart';
import 'package:flutter_food_delivery/scr/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _key = GlobalKey<ScaffoldState>();
  OrderServices _orderServices = OrderServices();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: "Shopping Cart",
        ),
      ),
      backgroundColor: white,
      body: app.isLoading
          ? Loading()
          : ListView.builder(
              itemCount: user.userModel.cart.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: white,
                        boxShadow: [
                          BoxShadow(
                              color: red.withOpacity(0.2),
                              offset: Offset(3, 2),
                              blurRadius: 15)
                        ]),
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                          child: Image.network(
                            user.userModel.cart[index]["image"],
                            height: 120,
                            width: 120,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: user.userModel.cart[index]["name"]
                                              .toString() +
                                          "\n",
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: "\₹" +
                                          user.userModel.cart[index]["price"]
                                              .toString() +
                                          "\n\n",
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300)),
                                  TextSpan(
                                      text: "Quantity: ",
                                      style: TextStyle(
                                          color: grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300)),
                                  TextSpan(
                                      text: user
                                          .userModel.cart[index]["quantity"]
                                          .toString(),
                                      style: TextStyle(
                                          color: red,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300)),
                                ]),
                              ),
                              IconButton(
                                  icon: Icon(Icons.delete, color: red),
                                  onPressed: () async {
                                    app.changeLoading();
                                    bool val = await user.removeFromCart(
                                        cartItem: user.userModel.cart[index]);
                                    if (val) {
                                      user.reloadUserModel();
                                      _key.currentState.showSnackBar(SnackBar(
                                          content:
                                              Text("Item Removed from cart")));
                                      app.changeLoading();
                                      return;
                                    } else {
                                      print("Item was not removed");
                                      app.changeLoading();
                                    }
                                  })
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
      bottomNavigationBar: Container(
          height: 70,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Total: ",
                        style: TextStyle(
                            color: black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: "\₹${user.userModel.totalCartPrice}",
                        style: TextStyle(
                            color: primary,
                            fontSize: 22,
                            fontWeight: FontWeight.normal)),
                  ]),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: primary),
                  child: FlatButton(
                      onPressed: () {
                        if (user.userModel.totalCartPrice == 0) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Container(
                                    height: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "Your cart is empty",
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                          return;
                        }
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Container(
                                  height: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                            child: Text(
                                                "You will be charged \₹${user.userModel.totalCartPrice}")),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 140,
                                              child: RaisedButton(
                                                onPressed: () async {
                                                  var uuid = Uuid();
                                                  String id = uuid.v4();
                                                  _orderServices.createOrder(
                                                      userId: user.user.uid,
                                                      id: id,
                                                      description: "Some random description",
                                                      status: "complete",
                                                      totalPrice: user.userModel.totalCartPrice,
                                                      cart: user.userModel.cart);
                                                  for (Map cartItem in user.userModel.cart) {
                                                    bool val = await user.removeFromCart(cartItem: cartItem);
                                                    if (val) {
                                                      user.reloadUserModel();
                                                      _key.currentState
                                                          .showSnackBar(
                                                          SnackBar(content: Text("Item Removed from cart"))
                                                      );
                                                    } else {
                                                      print("Item was not removed");
                                                      // app.changeLoading();
                                                    }
                                                  }
                                                  _key.currentState
                                                      .showSnackBar(SnackBar(
                                                          content: Text("Order Placed"))
                                                  );
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "Accept",
                                                  style:
                                                      TextStyle(color: white),
                                                ),
                                                color: const Color(0xFF1BC0C5),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            SizedBox(
                                              width: 140,
                                              child: RaisedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "Reject",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                color: red,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: CustomText(
                        text: "Order Now",
                        color: white,
                        weight: FontWeight.normal,
                        size: 20,
                      )),
                )
              ],
            ),
          )),
    );
  }
}