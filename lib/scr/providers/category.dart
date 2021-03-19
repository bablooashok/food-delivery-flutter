import 'package:flutter/material.dart';
import '../helpers/category.dart';
import '../models/category.dart';

class CategoryProvider with ChangeNotifier{
  ProductServices _categoryServices = ProductServices();
  List<CategoryModel> categories = [];

  CategoryProvider.initialize(){
    _loadCategories();
  }

  _loadCategories() async{
    categories = await _categoryServices.getCategories();
    notifyListeners();
  }
}