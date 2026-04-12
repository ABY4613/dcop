import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';
import '../shared/animated_loader.dart';
import 'widgets/custom_appbar.dart';
import 'widgets/hero_section.dart';
import 'widgets/featured_section.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: Colors.black,
      endDrawer: _buildDrawer(context),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const AnimatedLoader();
        }

        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const HeroSection(),
                  FeaturedSection(
                    title: 'FEATURED T-SHIRTS',
                    products: controller.featuredProducts,
                  ),
                  Container(
                    width: double.infinity,
                    height: 500,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1579809939521-17f16bc42ea9?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      color: const Color(0xFFE50914).withOpacity(0.85),
                      child: Center(
                        child:
                            Text(
                                  'UNLEASH YOUR\nSTYLE',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 64,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    letterSpacing: 8,
                                  ),
                                )
                                .animate(onPlay: (c) => c.repeat(reverse: true))
                                .scale(
                                  begin: const Offset(1, 1),
                                  end: const Offset(1.05, 1.05),
                                  duration: const Duration(seconds: 2),
                                ),
                      ),
                    ),
                  ),
                  FeaturedSection(
                    title: 'TRENDING DESIGNS',
                    products: controller.trendingProducts,
                  ),
                  FeaturedSection(
                    title: 'NEW ARRIVALS',
                    products: controller.newArrivals,
                  ),
                  _buildFooter(context),
                ],
              ),
            ),
            const Positioned(top: 0, left: 0, right: 0, child: CustomAppbar()),
          ],
        );
      }),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      color: const Color(0xFF141414),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DCOP',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 4,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Premium printed T-shirts for the modern streetwear enthusiast. Designed to stand out.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SHOP',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _footerLink('New Arrivals'),
                    _footerLink('Best Sellers'),
                    _footerLink('Sale'),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SUPPORT',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _footerLink('FAQ'),
                    _footerLink('Shipping'),
                    _footerLink('Returns'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 80),
          Divider(color: Colors.white.withOpacity(0.1)),
          const SizedBox(height: 32),
          const Text(
            '© 2026 DCOP. All rights reserved.',
            style: TextStyle(color: Colors.white54, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF141414),
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.black),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'DC',
                    style: GoogleFonts.outfit(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFFE50914),
                    ),
                  ),
                  Text(
                    'OP',
                    style: GoogleFonts.outfit(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          _drawerItem(FontAwesomeIcons.house, 'HOME', () => Get.back()),
          _drawerItem(FontAwesomeIcons.tag, 'SHOP', () {}),
          _drawerItem(FontAwesomeIcons.layerGroup, 'COLLECTIONS', () {}),
          _drawerItem(FontAwesomeIcons.circleInfo, 'ABOUT', () {}),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              '© 2026 DCOP',
              style: GoogleFonts.outfit(color: Colors.white24, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70, size: 20),
      title: Text(
        title,
        style: GoogleFonts.outfit(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          letterSpacing: 2,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _footerLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white70, fontSize: 14),
      ),
    );
  }
}
