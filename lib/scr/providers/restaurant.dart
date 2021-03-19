import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/scr/helpers/restaurant.dart';
import 'package:flutter_food_delivery/scr/models/restaurant.dart';

class RestaurantProvider with ChangeNotifier{
  RestaurantSrevices _restaurantServices = RestaurantSrevices();
  List<RestaurantModel> restaurants = [];

  RestaurantProvider.initialize(){
    _loadRestaurants();
  }

  _loadRestaurants() async{
    restaurants = await _restaurantServices.getRestaurants();
    notifyListeners();
  }
}