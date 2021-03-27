import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  static const ID = "id";
  static const DESCRIPTION = "description";
  static const CART = "cart";
  static const USER_ID = "userId";
  static const TOTAL = "total";
  static const STATUS = "status";
  static const CREATED_AT = "createdAt";

  String _id;
  String _description;
  String _userId;
  int _total;
  String _status;
  int _createdAt;
  List cart;


  String get id => _id;

  String get description => _description;

  String get userId => _userId;

  int get total => _total;

  String get status => _status;

  int get createdAt => _createdAt;

  OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _description = snapshot.data[DESCRIPTION];
    _userId = snapshot.data[USER_ID];
    _total = snapshot.data[TOTAL];
    _status = snapshot.data[STATUS];
    _createdAt = snapshot.data[CREATED_AT];
    cart = snapshot.data[CART];
  }
}
