import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../about/about_view.dart';
import '../shop/shop_view.dart';
import '../collections/collections_view.dart';
import '../../controllers/home_controller.dart';
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
                  // Hero section – full width, directly under fixed header
                  const HeroSection(),
                  // Featured products
                  FeaturedSection(
                    title: 'FEATURED T-SHIRTS',
                    products: controller.featuredProducts,
                  ),
                  // Red accent banner
                  _buildAccentBanner(context),
                  // Trending
                  FeaturedSection(
                    title: 'TRENDING DESIGNS',
                    products: controller.trendingProducts,
                  ),
                  // New arrivals
                  FeaturedSection(
                    title: 'NEW ARRIVALS',
                    products: controller.newArrivals,
                  ),
                  // Footer
                  _buildFooter(context),
                ],
              ),
            ),
            // Sticky header on top
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CustomAppbar(),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildAccentBanner(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;
    return Container(
      width: double.infinity,
      height: isDesktop ? 400 : 260,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const NetworkImage(
            'https://picsum.photos/id/1035/1920/1000',
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.darken,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFFF2D2D).withOpacity(0.85),
              const Color(0xFFFF2D2D).withOpacity(0.6),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Center(
          child: Text(
                'UNLEASH YOUR\nSTYLE',
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: isDesktop ? 64 : 40,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 8,
                  height: 1.2,
                ),
              )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.04, 1.04),
                duration: const Duration(seconds: 3),
                curve: Curves.easeInOut,
              ),
        ),
      ),
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
                      style: GoogleFonts.outfit(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 4,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Premium printed T-shirts for the modern streetwear enthusiast. Designed to stand out.',
                      style: GoogleFonts.outfit(
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
                    Text(
                      'SHOP',
                      style: GoogleFonts.outfit(
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
                    Text(
                      'SUPPORT',
                      style: GoogleFonts.outfit(
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
          Text(
            '© 2026 DCOP. All rights reserved.',
            style: GoogleFonts.outfit(color: Colors.white54, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0A0A0A),
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.black,
              border: Border(
                bottom: BorderSide(color: Color(0xFF1A1A1A)),
              ),
            ),
            child: Center(
              child: Text(
                'DCOP',
                style: GoogleFonts.outfit(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 4,
                ),
              ),
            ),
          ),
          _drawerItem(FontAwesomeIcons.house, 'HOME', () => Get.back()),
          _drawerItem(FontAwesomeIcons.store, 'STORES',
              () => Get.to(() => const ShopView())),
          _drawerItem(FontAwesomeIcons.layerGroup, 'COLLECTIONS',
              () => Get.to(() => const CollectionsView())),
          _drawerItem(FontAwesomeIcons.circleInfo, 'ABOUT',
              () => Get.to(() => const AboutView())),
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
      leading: FaIcon(icon, color: Colors.white38, size: 18),
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
        style: GoogleFonts.outfit(color: Colors.white70, fontSize: 14),
      ),
    );
  }
}
