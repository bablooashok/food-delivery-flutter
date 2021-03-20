import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const ID = "id";
  static const NAME = "name";
  static const RATING = "rating";
  static const IMAGE = "image";
  static const PRICE = "price";
  static const RESTAURANT_ID = "restaurantId";
  static const RESTAURANT = "restaurant";
  static const DESCRIPTION = "description";
  static const CATEGORY = "category";
  static const FEATURED = "featured";
  static const RATES = "rates";

  String _id;
  String _name;
  double _rating;
  int _price;
  int _restaurantId;
  String _restaurant;
  String _description;
  String _category;
  String _image;
  bool _featured;
  int _rates;

  String get id => _id;

  String get name => _name;

  String get restaurant => _restaurant;

  int get restaurantId => _restaurantId;

  String get description => _description;

  String get category => _category;

  String get image => _image;

  int get rates => -_rates;

  double get rating => _rating;

  int get price => _price;

  bool get featured => _featured;

  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _name = snapshot.data[NAME];
    _rating = snapshot.data[RATING];
    _price = snapshot.data[PRICE];
    _restaurant = snapshot.data[RESTAURANT];
    _restaurantId = snapshot.data[RESTAURANT_ID];
    _description = snapshot.data[DESCRIPTION];
    _category = snapshot.data[CATEGORY];
    _image = snapshot.data[IMAGE];
    _featured = snapshot.data[FEATURED];
    _rates = snapshot.data[RATES];
  }
}
