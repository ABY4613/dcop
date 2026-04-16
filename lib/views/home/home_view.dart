import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
import 'widgets/collections_section.dart';
import 'widgets/footer_section.dart';

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
                  // ── Section 1: Hero ──
                  const HeroSection(),

                  // ── Section 2: Featured Products (watermark style) ──
                  FeaturedSection(
                    title: 'FEATURED T-SHIRTS',
                    products: controller.featuredProducts,
                  ),

                  // ── Section 3: Red Accent Banner ──
                  _buildAccentBanner(context),

                  // ── Section 4: Collections Grid ──
                  const CollectionsSection(),

                  // ── Section 5: Footer ──
                  const FooterSection(),
                ],
              ),
            ),
            // Sticky appbar always on top
            const Positioned(top: 0, left: 0, right: 0, child: CustomAppbar()),
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
          image: const NetworkImage('https://picsum.photos/id/1035/1920/1000'),
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
              const Color.fromARGB(255, 255, 255, 255).withOpacity(0.85),
              const Color.fromARGB(255, 255, 255, 255).withOpacity(0.6),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Center(
          child:
              Text(
                    'UNLEASH YOUR\nSTYLE',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: isDesktop ? 64 : 40,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
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

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0A0A0A),
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.black,
              border: Border(bottom: BorderSide(color: Color(0xFF1A1A1A))),
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
          _drawerItem(
            FontAwesomeIcons.store,
            'STORES',
            () => Get.to(() => const ShopView()),
          ),
          _drawerItem(
            FontAwesomeIcons.layerGroup,
            'COLLECTIONS',
            () => Get.to(() => const CollectionsView()),
          ),
          _drawerItem(
            FontAwesomeIcons.circleInfo,
            'ABOUT',
            () => Get.to(() => const AboutView()),
          ),
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
}
