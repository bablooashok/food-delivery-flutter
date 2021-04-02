import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const NAME = "name";
  static const EMAIL = "email";
  static const PHONE_NO = "phoneNo";
  static const ID = "id";
  static const STRIPE_ID = "stripeId";
  static const CART = "cart";

  String _name;
  String _email;
  int _phoneNo;
  String _id;
  String _stripeId;
  List cart;
  int _totalPrice = 0;
  int totalCartPrice;
  
  String get name => _name;

  String get email => _email;

  int get phoneNo => _phoneNo;

  String get id => _id;

  String get stripeId => _stripeId;


  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data[NAME];
    _email = snapshot.data[EMAIL];
    _phoneNo = snapshot.data[PHONE_NO];
    _id = snapshot.data[ID];
    _stripeId = snapshot.data[STRIPE_ID];
    cart = snapshot.data[CART] ?? [];
    totalCartPrice = getTotalPrice(cart: snapshot.data[CART]);
  }

  int getTotalPrice({List cart}){
    for(Map cartItem in cart){
      int sum =  cartItem["price"] * cartItem["quantity"];
      _totalPrice += sum;
    }
    int total = _totalPrice;
    return total;
  }
  
  // List<CartItemModel> _convertCartItems(List<Map> cart) {
  //   List<CartItemModel> convertedCart = [];
  //   for(Map cartItem in cart) {
  //     convertedCart.add(CartItemModel.fromMap(cartItem));
  //   }
  //   return convertedCart;
  // }
}