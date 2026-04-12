import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../home/widgets/custom_appbar.dart';
import '../shop/product_list_view.dart';

class CollectionsView extends StatelessWidget {
  const CollectionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 120),
                _buildHeader(),
                _buildCollectionItem(
                  'SUMMER 2026',
                  'LIGHTWEIGHT FABRICS / VIBRANT PRINTS',
                  'https://images.unsplash.com/photo-1523381235312-3a1bc2 building-a362?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80',
                ),
                _buildCollectionItem(
                  'MIDNIGHT DROP',
                  'PITCH BLACK / REFLECTIVE ACCENTS',
                  'https://images.unsplash.com/photo-1550991152-713ed3 building-5645?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80',
                ),
                _buildCollectionItem(
                  'URBAN CORE',
                  'MINIMALIST DESIGN / MAXIMUM IMPACT',
                  'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80',
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
          const Positioned(top: 0, left: 0, right: 0, child: CustomAppbar()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'EXPLORE',
            style: GoogleFonts.outfit(
              color: const Color(0xFFE50914),
              letterSpacing: 8,
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn().slideX(begin: -0.1),
          const SizedBox(height: 8),
          Text(
            'COLLECTIONS',
            style: GoogleFonts.outfit(
              fontSize: 64,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.05),
        ],
      ),
    );
  }

  Widget _buildCollectionItem(String title, String subtitle, String imageUrl) {
    return Container(
      height: 500,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: InkWell(
        onTap: () => Get.to(() => ProductListView(categoryName: title)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(imageUrl, fit: BoxFit.cover),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(0.2),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subtitle,
                    style: GoogleFonts.outfit(
                      color: const Color(0xFFE50914),
                      letterSpacing: 4,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Text(
                      'VIEW COLLECTION',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1);
  }
}
