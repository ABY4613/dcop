import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({Key? key}) : super(key: key);

  // ── Network images matching reference ──
  // Main model: local transparent hoody guy asset
  static const String _heroModelAsset =
      'assets/images/ChatGPT_Image_Apr_15__2026__07_34_53_PM-removebg-preview.png';

  // 3 small cards: moody dark portraits
  static const String _card1Url = 'https://picsum.photos/id/338/400/400';
  static const String _card2Url = 'https://picsum.photos/id/349/400/400';
  static const String _card3Url = 'https://picsum.photos/id/375/400/400';

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    if (w > 1000) return _desktopHero(context, w, h);
    if (w > 650) return _tabletHero(context, w, h);
    return _mobileHero(context, w, h);
  }

  // ═══════════════════════════════════════════════════
  //  DESKTOP  (> 1000px) – FULL VIEWPORT HEIGHT
  // ═══════════════════════════════════════════════════
  Widget _desktopHero(BuildContext context, double screenW, double screenH) {
    // Full viewport minus header height (~60px)
    final heroHeight = screenH - 60;

    return SizedBox(
      width: double.infinity,
      height: heroHeight < 600 ? 600 : heroHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ── BACKGROUND: light grey base + dark charcoal S-curve ──
          Positioned.fill(child: CustomPaint(painter: _HeroBgDesktop())),

          // ── GRAIN OVERLAY ──
          Positioned.fill(
            child: Opacity(
              opacity: 0.12,
              child: IgnorePointer(
                child: Image.network(
                  'https://www.transparenttextures.com/patterns/cubes.png',
                  repeat: ImageRepeat.repeat,
                ),
              ),
            ),
          ),

          // ── BLACK BOTTOM BAR ──
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 40,
            child: Container(color: const Color(0xFF0B0B0B)),
          ),

          // ── "STRETEAT" – huge white bold text at top ──
          Positioned(
            top: heroHeight * 0.08,
            left: screenW * 0.05,
            right: screenW * 0.05,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child:
                  Text(
                        'DCOP.MY',
                        style: GoogleFonts.oswald(
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          letterSpacing: -2,
                          fontSize: 240,
                          height: 1.0,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 700.ms, delay: 200.ms)
                      .slideY(begin: 0.1, duration: 700.ms),
            ),
          ),

          // ── "SELVING" – centered subtitle ──
          Positioned(
            top: heroHeight * 0.35,
            left: 0,
            right: 0,
            child: Center(
              child:
                  Text(
                        'SELVING',
                        style: GoogleFonts.outfit(
                          fontSize: 54,
                          fontWeight: FontWeight.w300,
                          color: Colors.white.withOpacity(0.95),
                          letterSpacing: 24,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 700.ms, delay: 350.ms)
                      .slideY(begin: 0.1, duration: 700.ms),
            ),
          ),

          // ── RED PILL BUTTON – centered ──
          Positioned(
            top: heroHeight * 0.48,
            left: 0,
            right: 0,
            child: Center(
              child:
                  Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFF2D2D).withOpacity(0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE81335),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 46,
                              vertical: 20,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Filgi Desy',
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 500.ms)
                      .scale(
                        begin: const Offset(0.85, 0.85),
                        duration: 600.ms,
                        curve: Curves.easeOutBack,
                      ),
            ),
          ),

          // ── 3 SMALL CARDS: HORIZONTAL, bottom-right ──
          Positioned(
            right: screenW * 0.08,
            bottom: 80,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _roundedCard(_card1Url, 0, width: 150, height: 210),
                const SizedBox(width: 16),
                _roundedCard(_card2Url, 1, width: 150, height: 210),
                const SizedBox(width: 16),
                _roundedCard(_card3Url, 2, width: 150, height: 210),
              ],
            ),
          ),

          // ── DESCRIPTION TEXT: bottom-left ──
          Positioned(
            left: screenW * 0.08,
            bottom: 80,
            child: SizedBox(
              width: 320,
              child: Text(
                'The i candid the edition us sum optale and\nunde variantiao obtiages strongos ponerity lext\niayder dhe gats et ear.',
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  color: Colors.black.withOpacity(0.8), // Dark on gray
                  fontWeight: FontWeight.w500,
                  height: 1.8,
                ),
              ),
            ).animate().fadeIn(duration: 800.ms, delay: 700.ms),
          ),

          // ── MODEL IMAGE: overlapping foreground ──
          Positioned(
            left: screenW * 0.12,
            bottom: 40, // Base level with black bar
            height:
                heroHeight *
                0.80, // Allow scaling to overlap the text but keep shape
            child:
                IgnorePointer(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(60),
                          bottomRight: Radius.circular(60),
                        ),
                        child: Image.asset(
                          _heroModelAsset,
                          fit: BoxFit.contain,
                          alignment: Alignment.bottomCenter,
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 800.ms)
                    .slideX(
                      begin: -0.1,
                      duration: 700.ms,
                      curve: Curves.easeOutCubic,
                    ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════
  //  TABLET  (650–1000px)
  // ═══════════════════════════════════════════════════
  Widget _tabletHero(BuildContext context, double screenW, double screenH) {
    final heroHeight = screenH - 60;

    return SizedBox(
      width: double.infinity,
      height: heroHeight < 450 ? 450 : heroHeight,
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _HeroBgDesktop())),

          // Title
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child:
                  Text(
                        'DCOP.MY',
                        style: GoogleFonts.oswald(
                          fontSize: 180,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          height: 1.0,
                          letterSpacing: -2,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 700.ms, delay: 200.ms)
                      .slideY(begin: 0.1, duration: 700.ms),
            ),
          ),

          // Subtitle
          Positioned(
            top: 180,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'SELVING',
                style: GoogleFonts.outfit(
                  fontSize: 34,
                  fontWeight: FontWeight.w300,
                  color: Colors.white.withOpacity(0.9),
                  letterSpacing: 14,
                ),
              ).animate().fadeIn(duration: 700.ms, delay: 350.ms),
            ),
          ),

          // Button
          Positioned(
            top: 250,
            left: 0,
            right: 0,
            child:
                Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF2D2D),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'Filgi Desy',
                          style: GoogleFonts.outfit(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 500.ms)
                    .scale(
                      begin: const Offset(0.85, 0.85),
                      curve: Curves.easeOutBack,
                    ),
          ),

          // Cards
          Positioned(
            right: 30,
            bottom: 55,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _roundedCard(_card1Url, 0, width: 90, height: 130),
                const SizedBox(width: 10),
                _roundedCard(_card2Url, 1, width: 90, height: 130),
                const SizedBox(width: 10),
                _roundedCard(_card3Url, 2, width: 90, height: 130),
              ],
            ),
          ),

          // Description
          Positioned(
            left: 30,
            bottom: 55,
            child: SizedBox(
              width: 250,
              child: Text(
                'The leading streetwear collection for premium\ngraphics and bold street-style designs.',
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  color: Colors.black87,
                  height: 1.7,
                ),
              ),
            ).animate().fadeIn(duration: 800.ms, delay: 700.ms),
          ),

          // Model (in front)
          Positioned(
            left: 20,
            bottom: 0,
            height: heroHeight * 0.75,
            child:
                IgnorePointer(
                      child: Image.asset(
                        _heroModelAsset,
                        fit: BoxFit.contain,
                        alignment: Alignment.bottomCenter,
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 800.ms)
                    .slideX(begin: -0.1, duration: 700.ms),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════
  //  MOBILE  (< 650px)
  // ═══════════════════════════════════════════════════
  Widget _mobileHero(BuildContext context, double screenW, double screenH) {
    return SizedBox(
      width: double.infinity,
      height: screenH - 60,
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _HeroBgMobile())),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 76, bottom: 16),
            child: Column(
              children: [
                const SizedBox(height: 8),
                FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'DCOP.MY',
                        style: GoogleFonts.oswald(
                          fontSize: 110,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          height: 1.0,
                          letterSpacing: -1,
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 700.ms)
                    .slideY(begin: 0.15, duration: 700.ms),
                const SizedBox(height: 4),
                Text(
                  'SELVING',
                  style: GoogleFonts.outfit(
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                    color: Colors.white.withOpacity(0.9),
                    letterSpacing: 10,
                  ),
                ).animate(delay: 200.ms).fadeIn(duration: 700.ms),
                const SizedBox(height: 16),
                ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF2D2D),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Filgi Desy',
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                    .animate(delay: 350.ms)
                    .fadeIn()
                    .scale(
                      begin: const Offset(0.85, 0.85),
                      curve: Curves.easeOutBack,
                    ),
                const SizedBox(height: 20),
                Expanded(
                  flex: 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      _heroModelAsset,
                      width: double.infinity,
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomCenter,
                    ),
                  ).animate(delay: 300.ms).fadeIn(duration: 800.ms),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 120, // Taller cards
                  child: Row(
                    children: [
                      Expanded(child: _roundedCardFlex(_card1Url, 0)),
                      const SizedBox(width: 8),
                      Expanded(child: _roundedCardFlex(_card2Url, 1)),
                      const SizedBox(width: 8),
                      Expanded(child: _roundedCardFlex(_card3Url, 2)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'The leading streetwear collection for premium graphics and bold designs.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ).animate(delay: 600.ms).fadeIn(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Rounded card (fixed size) ──
  Widget _roundedCard(
    String url,
    int index, {
    double width = 130,
    double height = 180,
  }) {
    return ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: ColorFiltered(
            colorFilter: const ColorFilter.mode(
              Colors.grey,
              BlendMode.saturation,
            ),
            child: Image.network(
              url,
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
          ),
        )
        .animate(delay: (500 + index * 150).ms)
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.2, duration: 600.ms, curve: Curves.easeOutCubic);
  }

  // ── Rounded card (flexible size) ──
  Widget _roundedCardFlex(String url, int index) {
    return ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: ColorFiltered(
            colorFilter: const ColorFilter.mode(
              Colors.grey,
              BlendMode.saturation,
            ),
            child: Image.network(
              url,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        )
        .animate(delay: (500 + index * 120).ms)
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.15, duration: 500.ms, curve: Curves.easeOutCubic);
  }
}

// ═══════════════════════════════════════════════════════
//  DESKTOP PAINTER
// ═══════════════════════════════════════════════════════
class _HeroBgDesktop extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1) Light grey fills everything
    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()..color = const Color(0xFFD8D8D8),
    );

    // 2) Exact matching dark charcoal continuous sweep
    final darkPath = Path()
      ..moveTo(0, 0)
      ..lineTo(w, 0)
      ..lineTo(w, h * 0.40)
      ..cubicTo(w * 0.8, h * 0.65, w * 0.65, h * 0.55, w * 0.5, h * 0.55)
      ..cubicTo(w * 0.35, h * 0.55, w * 0.2, h * 0.85, 0, h * 0.65)
      ..close();

    canvas.drawPath(darkPath, Paint()..color = const Color(0xFF4B4F54));

    // 3) Stylistic dark edge cutouts (notches)
    final notchPaint = Paint()..color = const Color(0xFF383B3F);
    canvas.drawOval(
      Rect.fromCenter(center: Offset(0, h * 0.45), width: 40, height: 60),
      notchPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w, h * 0.5), width: 40, height: 60),
      notchPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ═══════════════════════════════════════════════════════
//  MOBILE PAINTER
// ═══════════════════════════════════════════════════════
class _HeroBgMobile extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()..color = const Color(0xFFB5B5B5),
    );

    final dark = Path()
      ..moveTo(0, 0)
      ..lineTo(w, 0)
      ..lineTo(w, h * 0.18)
      ..cubicTo(w * 0.70, h * 0.30, w * 0.30, h * 0.15, 0, h * 0.35)
      ..close();

    canvas.drawPath(dark, Paint()..color = const Color(0xFF3D3D3D));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
