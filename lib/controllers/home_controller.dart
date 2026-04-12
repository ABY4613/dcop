import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product.dart';
import '../core/constants.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var cartCount = 0.obs;

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

  void addToCart() {
    cartCount.value++;
    // Show a quick snackbar here using Get
    Get.snackbar(
      'Added to Cart',
      'Item has been added to your shopping cart.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFE50914),
      colorText: const Color(0xFFFFFFFF),
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 4,
    );
  }
}
