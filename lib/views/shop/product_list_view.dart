import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../controllers/home_controller.dart';
import '../home/widgets/product_card.dart';
import '../home/widgets/custom_appbar.dart';

class ProductListView extends StatelessWidget {
  final String categoryName;
  const ProductListView({Key? key, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    
    // Determine which products to show based on category
    final products = categoryName.contains('FEATURED') 
        ? controller.featuredProducts 
        : categoryName.contains('TRENDING')
        ? controller.trendingProducts
        : controller.newArrivals;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 120), // Space for AppBar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(FontAwesomeIcons.chevronLeft, color: Colors.white, size: 18),
                            onPressed: () => Get.back(),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'SHOP / ${categoryName.toUpperCase()}',
                            style: GoogleFonts.outfit(
                              color: Colors.white54,
                              fontSize: 14,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ).animate().fadeIn().slideX(begin: -0.1),
                      const SizedBox(height: 24),
                      Text(
                        categoryName,
                        style: GoogleFonts.outfit(
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
                      const SizedBox(height: 40),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          int crossAxisCount = constraints.maxWidth > 1200
                              ? 4
                              : constraints.maxWidth > 800
                              ? 3
                              : 2;

                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 24,
                              mainAxisSpacing: 32,
                              childAspectRatio: 0.7,
                            ),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              return ProductCard(product: products[index])
                                  .animate(delay: (100 * index).ms)
                                  .fadeIn()
                                  .slideY(begin: 0.1);
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Positioned(top: 0, left: 0, right: 0, child: CustomAppbar()),
        ],
      ),
    );
  }
}
