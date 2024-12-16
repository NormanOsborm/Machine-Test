import 'package:flutter/material.dart';
import '../model/model1.dart';
import '../service/service.dart';

class ProductProvider with ChangeNotifier {
  List<Wel> _products = [];
  List<Wel> _filteredProducts = [];
  String _searchQuery = '';

  List<Wel> get products => _products;

  List<Wel> get filteredProducts => _filteredProducts;

  Future<void> fetchProducts() async {
    try {
      final products = await HttService.fetchProducts();
      _products = products;
      _filteredProducts = products;
      notifyListeners();
    } catch (e) {}
  }

  void filterProducts(String query) {
    _searchQuery = query;
    _filteredProducts = _products
        .where((product) =>
            product.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
