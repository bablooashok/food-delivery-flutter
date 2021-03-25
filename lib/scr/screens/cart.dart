import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/scr/helpers/style.dart';
// import 'package:flutter_food_delivery/scr/providers/app.dart';
import 'package:flutter_food_delivery/scr/providers/user.dart';
import 'package:flutter_food_delivery/scr/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _key = GlobalKey<ScaffoldState>();
  // OrderServices _orderServices = OrderServices();

  @override
    Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    // final app = Provider.of<AppProvider>(context);
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
            },),
          backgroundColor: white,
          elevation: 0,
          centerTitle: true,
          title: CustomText(
            text: "Shopping Cart",
          ),
        ),
        backgroundColor: white,
        body: ListView.builder(
            itemCount: user.userModel.cart.length,
            itemBuilder: (_,index){
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
                    child: Image.network(user.userModel.cart[index]["image"],
                      height: 120,
                      width: 120,
                      fit: BoxFit.fill,),
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
                                text: user.userModel.cart[index]["name"].toString() + "\n",
                                style: TextStyle(
                                    color: black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: "\₹" + user.userModel.cart[index]["price"].toString() + "\n\n",
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
                                text: user.userModel.cart[index]["quantity"].toString(),
                                style: TextStyle(
                                    color: red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300)),
                          ]),
                        ),
                        IconButton(icon: Icon(Icons.delete, color: red),
                            onPressed: null)
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
            child: Padding(padding: const EdgeInsets.all(8.0),
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
                          text: "\₹150",
                          style: TextStyle(
                              color: primary,
                              fontSize: 22,
                              fontWeight: FontWeight.w300)),
                    ]),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: primary
                    ),
                    child: FlatButton(onPressed: () {},
                        child: CustomText(text: "Order Now",
                          color: white,
                          weight: FontWeight.w700,
                          size: 22,)),
                  )
                ],
              ),
            )
        ),
      );
    }
  }