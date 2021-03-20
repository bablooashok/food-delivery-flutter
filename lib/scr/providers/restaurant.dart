import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/scr/helpers/restaurant.dart';
import 'package:flutter_food_delivery/scr/models/restaurant.dart';

class RestaurantProvider with ChangeNotifier {
  RestaurantSrevices _restaurantServices = RestaurantSrevices();
  List<RestaurantModel> restaurants = [];
  List<RestaurantModel> searchedRestaurants = [];
  RestaurantModel restaurant;

  RestaurantProvider.initialize() {
    _loadRestaurants();
  }

  _loadRestaurants() async {
    restaurants = await _restaurantServices.getRestaurants();
    notifyListeners();
  }

  loadSingleRestaurant({int restaurantId}) async {
    restaurant = await _restaurantServices.getRestaurantById(id: restaurantId);
    notifyListeners();
  }

  Future search({String name}) async {
    searchedRestaurants =
        await _restaurantServices.searchRestaurants(restaurantName: name);
    // print("rest  "+ searchedRestaurants.length.toString());
    notifyListeners();
  }
}
