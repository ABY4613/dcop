import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../models/product.dart';
import '../../../controllers/home_controller.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..scale(isHovered ? 1.05 : 1.0),
        decoration: BoxDecoration(
          color: const Color(0xFF141414),
          border: Border.all(
            color: isHovered ? const Color(0xFFE50914) : Colors.transparent,
            width: 2,
          ),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: const Color(0xFFE50914).withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(widget.product.imageUrl, fit: BoxFit.cover),
                  if (widget.product.isNewArrival)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        color: const Color(0xFFE50914),
                        child: Text(
                          'NEW',
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ).animate().shimmer(duration: 1500.ms),
                    ),
                  if (isHovered)
                    Container(
                      color: Colors.black.withOpacity(0.4),
                      child: Center(
                        child:
                            ElevatedButton(
                              onPressed: () {
                                Get.find<HomeController>().addToCart(widget.product);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE50914),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                              child: const Text('Add to Cart'),
                            ).animate().scale(
                              duration: 200.ms,
                              curve: Curves.easeOutBack,
                            ),
                      ),
                    ).animate().fadeIn(duration: 200.ms),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${widget.product.price.toStringAsFixed(2)}',
                    style: GoogleFonts.outfit(
                      color: const Color(0xFFE50914),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ).animate().slideY(begin: 0.2, end: 0, duration: 400.ms).fadeIn(),
          ],
        ),
      ),
    );
  }
}
