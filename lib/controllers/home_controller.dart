import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product.dart';
import '../core/constants.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var cartItems = <Product>[].obs;

  int get cartCount => cartItems.length;
  double get totalAmount => cartItems.fold(0, (sum, item) => sum + item.price);

  List<Product> get featuredProducts =>
      AppConstants.dummyProducts.where((p) => p.isFeatured).toList();
  List<Product> get newArrivals =>
      AppConstants.dummyProducts.where((p) => p.isNewArrival).toList();
  List<Product> get trendingProducts =>
      AppConstants.dummyProducts.where((p) => p.isTrending).toList();

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  void _loadData() async {
    // Simulate network delay for the custom loader
    await Future.delayed(const Duration(seconds: 3));
    isLoading.value = false;
  }

  void addToCart(Product product) {
    cartItems.add(product);
    Get.snackbar(
      'Added to Cart',
      '${product.name} added to your cart.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFE50914),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 0,
      icon: const Icon(Icons.shopping_bag, color: Colors.white),
    );
  }

  void removeFromCart(Product product) {
    cartItems.remove(product);
  }
}
