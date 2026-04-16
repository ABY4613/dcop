import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../controllers/home_controller.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../cart/cart_view.dart';
import '../../about/about_view.dart';
import '../../shop/shop_view.dart';
import '../../collections/collections_view.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 40 : 16,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.9),
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.06)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Text(
            'DCOP',
            style: GoogleFonts.outfit(
              fontSize: isDesktop ? 26 : 20,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 3,
            ),
          ).animate().slideY(begin: -1, duration: 400.ms).fadeIn(),

          // Nav items (desktop)
          if (isDesktop)
            Row(
              children: [
                _navItem('HOME'),
                const SizedBox(width: 28),
                _navItem('STORES'),
                const SizedBox(width: 28),
                _navItem('SERVICES'),
                const SizedBox(width: 28),
                _navItem('MENS'),
                const SizedBox(width: 28),
                _navItem('BLOG'),
              ],
            ).animate().slideY(begin: -1, duration: 500.ms).fadeIn(),

          // Right icons
          Row(
            children: [
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.magnifyingGlass,
                    color: Colors.white, size: 18),
                onPressed: () {},
                splashRadius: 20,
              ),
              const SizedBox(width: 8),
              Obx(() {
                final count = Get.find<HomeController>().cartCount;
                return Stack(
                  children: [
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.bagShopping,
                          color: Colors.white, size: 18),
                      onPressed: () => Get.to(
                        () => const CartView(),
                        transition: Transition.rightToLeftWithFade,
                        duration: const Duration(milliseconds: 500),
                      ),
                      splashRadius: 20,
                    ),
                    if (count > 0)
                      Positioned(
                        right: 6,
                        top: 6,
                        child: IgnorePointer(
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Color(0xFFFF2D2D),
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
              if (!isDesktop) ...[
                const SizedBox(width: 8),
                Builder(
                  builder: (context) => IconButton(
                    icon: const FaIcon(FontAwesomeIcons.bars,
                        color: Colors.white, size: 18),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    splashRadius: 20,
                  ),
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
      onTap: () {
        if (title == 'HOME') {
          Get.offAllNamed('/');
        } else if (title == 'STORES') {
          Get.to(() => const ShopView());
        } else if (title == 'SERVICES') {
          Get.to(() => const CollectionsView());
        } else if (title == 'BLOG') {
          Get.to(() => const AboutView());
        }
      },
      hoverColor: Colors.transparent,
      child: Text(
        title,
        style: GoogleFonts.outfit(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
