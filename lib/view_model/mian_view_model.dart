import 'package:flutter/foundation.dart';
import 'package:untitled1/model/product_model.dart';
import 'package:untitled1/model/sub_category.dart';

import '../model/category_model.dart';
import '../services/api_service.dart';

class CategoryViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<CategoryElement> _categories = [];
   SbCategory? _subCategories;
  Products? _products  ;
  bool _isLoading = false;
  int _pageIndex = 1;

  List<CategoryElement> get categories => _categories;
  SbCategory? get subCategories => _subCategories;
  Products? get products => _products;
  bool get isLoading => _isLoading;

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      final categoryResponse = await _apiService.fetchCategories(_pageIndex);
      _categories = categoryResponse.result.category;
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<SbCategory> fetchSubCategory(int  categoryId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final categoryResponse = await _apiService.fetchSubCategory(categoryId);
     return _subCategories = categoryResponse;
    } catch (e) {
      return throw Exception('Failed to load categories');
      ;
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchProduct(int?  categoryId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final productResponse = await _apiService.fetchProduct(categoryId);
      _products =  productResponse;
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  void loadMoreCategories() async {
    _pageIndex++;
    await fetchCategories();
  }




}

