import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../models/product.dart';
import '../../controllers/home_controller.dart';
import '../home/widgets/custom_appbar.dart';

class ProductDetailView extends StatefulWidget {
  final Product product;
  const ProductDetailView({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailViewState createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  String? selectedSize;
  String? selectedColor;

  @override
  void initState() {
    super.initState();
    selectedSize = widget.product.availableSizes.first;
    selectedColor = widget.product.availableColors.first;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 120),
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 900) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 1, child: _buildImageGallery()),
                          Expanded(flex: 1, child: _buildProductDetails(controller)),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          _buildImageGallery(),
                          _buildProductDetails(controller),
                        ],
                      );
                    }
                  },
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
          const Positioned(top: 0, left: 0, right: 0, child: CustomAppbar()),
        ],
      ),
    );
  }

  Widget _buildImageGallery() {
    return Container(
      margin: const EdgeInsets.all(40),
      height: 700,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white10),
        image: DecorationImage(
          image: NetworkImage(widget.product.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    ).animate().fadeIn().slideX(begin: -0.05);
  }

  Widget _buildProductDetails(HomeController controller) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                color: const Color(0xFFFF2D2D),
                child: Text(
                  'LIMITED EDITION',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ],
          ).animate().fadeIn().slideY(begin: 0.1),
          const SizedBox(height: 24),
          Text(
            widget.product.name.toUpperCase(),
            style: GoogleFonts.outfit(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.1,
            ),
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
          const SizedBox(height: 16),
          Text(
            '\$${widget.product.price.toStringAsFixed(2)}',
            style: GoogleFonts.outfit(
              fontSize: 28,
              color: const Color(0xFFFF2D2D),
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn(delay: 300.ms),
          const SizedBox(height: 48),
          Text(
            'SELECT SIZE',
            style: GoogleFonts.outfit(
              color: Colors.white54,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            children: widget.product.availableSizes.map((size) {
              final isSelected = selectedSize == size;
              return InkWell(
                onTap: () => setState(() => selectedSize = size),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFFF2D2D) : Colors.transparent,
                    border: Border.all(color: isSelected ? const Color(0xFFFF2D2D) : Colors.white24),
                  ),
                  child: Text(
                    size,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ).animate().fadeIn(delay: 400.ms),
          const SizedBox(height: 40),
          Text(
            'SELECT COLOR',
            style: GoogleFonts.outfit(
              color: Colors.white54,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            children: widget.product.availableColors.map((color) {
              final isSelected = selectedColor == color;
              return InkWell(
                onTap: () => setState(() => selectedColor = color),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.transparent,
                    border: Border.all(color: isSelected ? Colors.white : Colors.white24),
                  ),
                  child: Text(
                    color.toUpperCase(),
                    style: GoogleFonts.outfit(
                      color: isSelected ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              );
            }).toList(),
          ).animate().fadeIn(delay: 500.ms),
          const SizedBox(height: 64),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                controller.addToCart(widget.product);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF2D2D),
                padding: const EdgeInsets.symmetric(vertical: 28),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              ),
              child: Text(
                'ADD TO BAG',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
            ),
          ).animate().fadeIn(delay: 600.ms),
          const SizedBox(height: 48),
          Text(
            'DESCRIPTION',
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.product.description,
            style: GoogleFonts.outfit(
              color: Colors.white70,
              height: 1.8,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
