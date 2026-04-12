import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../models/product.dart';
import '../../shop/product_list_view.dart';
import 'product_card.dart';

class FeaturedSection extends StatelessWidget {
  final String title;
  final List<Product> products;

  const FeaturedSection({Key? key, required this.title, required this.products})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ).animate().slideX(begin: -0.1, duration: 600.ms).fadeIn(),
              TextButton(
                onPressed: () => Get.to(() => ProductListView(categoryName: title)),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFE50914),
                ),
                child: Text(
                  'VIEW ALL',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ).animate().slideX(begin: 0.1, duration: 600.ms).fadeIn(),
            ],
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = constraints.maxWidth > 1000
                  ? 4
                  : constraints.maxWidth > 700
                  ? 3
                  : constraints.maxWidth > 500
                  ? 2
                  : 1;

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
                      .slideY(begin: 0.2, end: 0, duration: 400.ms)
                      .fadeIn();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
