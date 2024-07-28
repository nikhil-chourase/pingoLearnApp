

import 'package:flutter/foundation.dart';
import 'package:pingolearnapp/controllers/product/api_service.dart';
import 'package:pingolearnapp/model/product/product.dart';


class ProductProvider with ChangeNotifier {
  List<Product>? _products;
  bool _isLoading = true;
  String? _errorMessage;

  List<Product>? get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final ApiService _apiService = ApiService();

  ProductProvider() {
    fetchProducts();
  }

   Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _apiService.fetchProducts();
      _errorMessage = null;
    } catch (e) {
      if (e is ApiException) {
        _errorMessage = e.message;
        if (e.statusCode != null) {
          print('Status Code: ${e.statusCode}');
        }
        if (e.responseBody != null) {
          print('Response Body: ${e.responseBody}');
        }
      } else {
        _errorMessage = 'Unexpected error: $e';
      }
      _products = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


}
