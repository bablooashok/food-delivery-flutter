import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RestaurantModel{
  static const ID = "id";
  static const NAME = "name";
  static const RATING = "rating";
  static const RATES = "rates";
  static const IMAGE = "image";
  static const POPULAR = "popular";

  int _id;
  String _name;
  double _rating;
  int _rates;
  String _image;
  bool _popular;

  int get id => _id;
  String get name => _name;
  double get rating => _rating;
  int get rates => _rates;
  String get image => _image;
  bool get popular => _popular;

  RestaurantModel.fromSnapshot(DocumentSnapshot snapshot){
    _id = snapshot.data[ID];
    _name = snapshot.data[NAME];
    _rating = snapshot.data[RATING];
    _rates = snapshot.data[RATES];
    _image = snapshot.data[IMAGE];
    _popular = snapshot.data[POPULAR];
  }
}