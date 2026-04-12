import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../controllers/home_controller.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../cart/cart_view.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      color: Colors.black.withOpacity(0.8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'DC',
                style: GoogleFonts.outfit(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFFE50914),
                ),
              ).animate().shimmer(duration: 1500.ms, delay: 500.ms),
              Text(
                'OP',
                style: GoogleFonts.outfit(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ],
          ).animate().slideY(begin: -1, duration: 400.ms).fadeIn(),
          if (MediaQuery.of(context).size.width > 800)
            Row(
              children: [
                _navItem('HOME'),
                const SizedBox(width: 32),
                _navItem('SHOP'),
                const SizedBox(width: 32),
                _navItem('COLLECTIONS'),
                const SizedBox(width: 32),
                _navItem('ABOUT'),
              ],
            ).animate().slideY(begin: -1, duration: 500.ms).fadeIn(),
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 16),
              Obx(() {
                final count = Get.find<HomeController>().cartCount;
                return Stack(
                  children: [
                      IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.bagShopping,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () => Get.to(
                          () => const CartView(),
                          transition: Transition.rightToLeftWithFade,
                          duration: const Duration(milliseconds: 500),
                        ),
                      ),
                      if (count > 0)
                        Positioned(
                          right: 8,
                          top: 8,
                          child: IgnorePointer(
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Color(0xFFE50914),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '$count',
                                style: GoogleFonts.outfit(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ).animate().scale(
                                  duration: 300.ms,
                                  curve: Curves.easeOutBack,
                                ),
                          ),
                        ),
                  ],
                );
              }),
              if (MediaQuery.of(context).size.width <= 800) ...[
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(
                    FontAwesomeIcons.bars,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () {},
                ),
              ],
            ],
          ).animate().slideY(begin: -1, duration: 600.ms).fadeIn(),
        ],
      ),
    );
  }

  Widget _navItem(String title) {
    return InkWell(
      onTap: () {},
      child: Text(
        title,
        style: GoogleFonts.outfit(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}
