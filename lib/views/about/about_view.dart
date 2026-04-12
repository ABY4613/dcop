import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../home/widgets/custom_appbar.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 120), // Space for AppBar
                _buildHero(),
                _buildStoryContent(context),
                _buildContactSection(context),
                const SizedBox(height: 100),
              ],
            ),
          ),
          const Positioned(top: 0, left: 0, right: 0, child: CustomAppbar()),
        ],
      ),
    );
  }

  Widget _buildHero() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Center(
        child: Column(
          children: [
            Text(
              'AESTHETIC / VISION',
              style: GoogleFonts.outfit(
                color: const Color(0xFFE50914),
                letterSpacing: 8,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn().slideY(begin: 0.2),
            const SizedBox(height: 24),
            Text(
              'REDEFINING\nSTREETWEAR',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 72,
                height: 1.1,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ).animate().fadeIn(delay: 200.ms).scale(begin: const Offset(0.9, 0.9)),
          ],
        ),
      ),
    );
  }

  Widget _buildStoryContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildImageCard()),
                const SizedBox(width: 80),
                Expanded(child: _buildTextContent()),
              ],
            );
          } else {
            return Column(
              children: [
                _buildImageCard(),
                const SizedBox(height: 60),
                _buildTextContent(),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildImageCard() {
    return Container(
      height: 600,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE50914), width: 2),
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1558769132-cb1aea458c5e?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80',
          ),
          fit: BoxFit.cover,
        ),
      ),
    ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.05);
  }

  Widget _buildTextContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'OUR STORY',
          style: GoogleFonts.outfit(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          'DCOP was born at the intersection of high-end aesthetics and raw urban culture. We believe that streetwear is not just clothing; it is a statement of identity, a canvas for self-expression, and a badge of belonging in the modern world.',
          style: GoogleFonts.outfit(
            fontSize: 18,
            color: Colors.white70,
            height: 1.8,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Every piece we create is a testament to quality and meticulous design. We don\'t follow trends; we set the pace. Our mission is to empower the bold, the creative, and the uncompromising.',
          style: GoogleFonts.outfit(
            fontSize: 18,
            color: Colors.white70,
            height: 1.8,
          ),
        ),
        const SizedBox(height: 48),
        _qualityItem('Premium Cotton Blends'),
        _qualityItem('Eco-Friendly Printing'),
        _qualityItem('Global Streetwear Presence'),
      ],
    ).animate().fadeIn(delay: 600.ms).slideX(begin: 0.05);
  }

  Widget _qualityItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          const Icon(FontAwesomeIcons.circleCheck, color: Color(0xFFE50914), size: 16),
          const SizedBox(width: 16),
          Text(
            text,
            style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      padding: const EdgeInsets.all(60),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Text(
            'JOIN THE MOVEMENT',
            style: GoogleFonts.outfit(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 4,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Connect with the culture and follow our journey.',
            style: GoogleFonts.outfit(color: Colors.white54),
          ),
          const SizedBox(height: 60),
          Wrap(
            spacing: 40,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: [
              _contactCard(FontAwesomeIcons.instagram, 'INSTAGRAM', '@dcop_official'),
              _contactCard(FontAwesomeIcons.envelope, 'EMAIL', 'contact@dcop.com'),
              _contactCard(FontAwesomeIcons.whatsapp, 'WHATSAPP', '+91 98765 43210'),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.1);
  }

  Widget _contactCard(IconData icon, String label, String value) {
    return Container(
      width: 250,
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFFE50914), size: 32),
          const SizedBox(height: 16),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              fontSize: 12,
              color: Colors.white54,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    ).animate().scale(delay: 1000.ms, curve: Curves.easeOutBack);
  }
}
