import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../models/product.dart';
import '../../shop/product_list_view.dart';
import '../../details/product_detail_view.dart';

class FeaturedSection extends StatelessWidget {
  final String title;
  final List<Product> products;

  const FeaturedSection({Key? key, required this.title, required this.products})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w > 900) return _desktopLayout(context, w);
    if (w > 600) return _tabletLayout(context, w);
    return _mobileLayout(context, w);
  }

  // ─────────────────────────────────────────────────────────────
  //  DESKTOP  (> 900px)
  // ─────────────────────────────────────────────────────────────
  Widget _desktopLayout(BuildContext context, double w) {
    // Show top 3 products only (like the reference image)
    final displayProducts = products.take(3).toList();

    return Container(
      color: Colors.black,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ── Massive watermark text ──
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                title.split(' ').first, // First word as giant watermark
                style: GoogleFonts.oswald(
                  fontSize: 400,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -8,
                  height: 0.85,
                ),
              )
                  .animate()
                  .fadeIn(duration: 700.ms, delay: 100.ms)
                  .slideX(begin: -0.05, duration: 700.ms),
            ),
          ),

          // ── Content column (cards + label) ──
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top pill label + view all
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Small + accent
                      Row(
                        children: [
                          Text(
                            '+',
                            style: GoogleFonts.outfit(
                              color: Colors.white54,
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            title,
                            style: GoogleFonts.outfit(
                              color: Colors.white38,
                              fontSize: 13,
                              letterSpacing: 3,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      // View All pill
                      _ViewAllButton(title: title),
                    ],
                  ),
                ),

                // Cards row – overlapping watermark
                const SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Spacer – pushes cards to the right (matching reference)
                      const Spacer(),
                      // 3 product cards, staggered heights
                      if (displayProducts.isNotEmpty)
                        _FeaturedCard(
                          product: displayProducts[0],
                          index: 0,
                          height: 340,
                        ),
                      const SizedBox(width: 16),
                      if (displayProducts.length > 1)
                        _FeaturedCard(
                          product: displayProducts[1],
                          index: 1,
                          height: 280,
                        ),
                      const SizedBox(width: 16),
                      if (displayProducts.length > 2)
                        _FeaturedCard(
                          product: displayProducts[2],
                          index: 2,
                          height: 280,
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  //  TABLET  (600–900px)
  // ─────────────────────────────────────────────────────────────
  Widget _tabletLayout(BuildContext context, double w) {
    final displayProducts = products.take(3).toList();

    return Container(
      color: Colors.black,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Watermark
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                title.split(' ').first,
                style: GoogleFonts.oswald(
                  fontSize: 300,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -6,
                  height: 0.85,
                ),
              ).animate().fadeIn(duration: 700.ms).slideX(begin: -0.05),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.outfit(
                          color: Colors.white38,
                          fontSize: 11,
                          letterSpacing: 2.5,
                        ),
                      ),
                      _ViewAllButton(title: title),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (displayProducts.isNotEmpty)
                        _FeaturedCard(
                          product: displayProducts[0],
                          index: 0,
                          height: 270,
                          width: 160,
                        ),
                      const SizedBox(width: 12),
                      if (displayProducts.length > 1)
                        _FeaturedCard(
                          product: displayProducts[1],
                          index: 1,
                          height: 220,
                          width: 160,
                        ),
                      const SizedBox(width: 12),
                      if (displayProducts.length > 2)
                        _FeaturedCard(
                          product: displayProducts[2],
                          index: 2,
                          height: 220,
                          width: 160,
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  //  MOBILE  (< 600px)
  // ─────────────────────────────────────────────────────────────
  Widget _mobileLayout(BuildContext context, double w) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Watermark
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              title.split(' ').first,
              style: GoogleFonts.oswald(
                fontSize: 200,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: -4,
                height: 0.9,
              ),
            ).animate().fadeIn(duration: 700.ms),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    color: Colors.white38,
                    fontSize: 10,
                    letterSpacing: 2,
                  ),
                ),
                _ViewAllButton(title: title),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Horizontal scrollable cards
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: _FeaturedCard(
                    product: products[index],
                    index: index,
                    height: 270,
                    width: 160,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  VIEW ALL PILL BUTTON
// ═══════════════════════════════════════════════════════════════
class _ViewAllButton extends StatefulWidget {
  final String title;
  const _ViewAllButton({required this.title});

  @override
  State<_ViewAllButton> createState() => _ViewAllButtonState();
}

class _ViewAllButtonState extends State<_ViewAllButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => Get.to(() => ProductListView(categoryName: widget.title)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: _hovered ? const Color(0xFFE81335) : Colors.transparent,
            border: Border.all(
              color: _hovered ? const Color(0xFFE81335) : Colors.white24,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            'VIEW ALL',
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 2.5,
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 300.ms);
  }
}

// ═══════════════════════════════════════════════════════════════
//  INDIVIDUAL FEATURED CARD  (white card with model image)
// ═══════════════════════════════════════════════════════════════
class _FeaturedCard extends StatefulWidget {
  final Product product;
  final int index;
  final double height;
  final double width;

  const _FeaturedCard({
    required this.product,
    required this.index,
    this.height = 300,
    this.width = 185,
  });

  @override
  State<_FeaturedCard> createState() => _FeaturedCardState();
}

class _FeaturedCardState extends State<_FeaturedCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            onTap:
                () => Get.to(
                  () => ProductDetailView(product: widget.product),
                ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              width: widget.width,
              height: widget.height,
              transform:
                  Matrix4.identity()
                    ..translate(0.0, _hovered ? -8.0 : 0.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(_hovered ? 0.5 : 0.3),
                    blurRadius: _hovered ? 32 : 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Product image (fills most of the card) ──
                    Expanded(
                      flex: 7,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            widget.product.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (_, __, ___) => Container(
                                  color: const Color(0xFFF5F5F5),
                                  child: const Icon(
                                    Icons.image_not_supported_outlined,
                                    color: Colors.black26,
                                  ),
                                ),
                          ),
                          // Subtle gradient at bottom for readability
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            height: 60,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.white.withOpacity(0.9),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // NEW badge
                          if (widget.product.isNewArrival)
                            Positioned(
                              top: 10,
                              left: 10,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE81335),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'NEW',
                                  style: GoogleFonts.outfit(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ).animate().shimmer(duration: 1500.ms),
                            ),
                        ],
                      ),
                    ),
                    // ── Name + price ──
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.product.name,
                              style: GoogleFonts.outfit(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.3,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'RM ${widget.product.price.toStringAsFixed(0)}',
                              style: GoogleFonts.outfit(
                                color: const Color(0xFFE81335),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        .animate(delay: (200 + widget.index * 150).ms)
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.15, end: 0, duration: 600.ms, curve: Curves.easeOutCubic);
  }
}
