import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({Key? key}) : super(key: key);

  static const _collectionLinks = ['Fade', 'Grunge', 'Virus', 'Thrive'];
  static const _productLinks    = ['Fossil', 'Flex', 'Rule', 'Fite'];
  static const _categoryLinks   = ['Grind', 'Frenzy', 'Found', 'Versus'];
  static const _infoLinks       = ['Sizing', 'Shipping', 'Returns', 'Lookbook'];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w > 900) return _desktopLayout(context, w);
    if (w > 600) return _tabletLayout(context, w);
    return _mobileLayout(context);
  }

  // ─────────────────────────────────────────────────────────────
  //  DESKTOP  (> 900px)
  // ─────────────────────────────────────────────────────────────
  Widget _desktopLayout(BuildContext context, double w) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.only(top: 60, bottom: 40),
      child: Column(
        children: [
          // ── Main grid row ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Col 1 – Collections photo column
                _CollectionsPhotoColumn(w: w),
                const SizedBox(width: 48),

                // Col 2 – SALPERS links (Products)
                Expanded(
                  child: _LinkColumn(
                    heading: 'SALPERS',
                    links: _productLinks,
                    delay: 100,
                  ),
                ),

                // Col 3 – COLECTINS links (Categories)
                Expanded(
                  child: _LinkColumn(
                    heading: 'COLECTINS',
                    links: _categoryLinks,
                    delay: 200,
                  ),
                ),

                // Col 4 – HAIY UPS + button
                Expanded(
                  child: _HaiyUpsColumn(links: _infoLinks, delay: 300),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),

          // ── Bottom bar ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '© 2026 DCOP. All rights reserved.',
                  style: GoogleFonts.outfit(
                    color: Colors.white24,
                    fontSize: 12,
                    letterSpacing: 0.5,
                  ),
                ),
                Row(
                  children: [
                    _socialDot('IG'),
                    const SizedBox(width: 16),
                    _socialDot('TK'),
                    const SizedBox(width: 16),
                    _socialDot('TW'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  //  TABLET  (600–900px)
  // ─────────────────────────────────────────────────────────────
  Widget _tabletLayout(BuildContext context, double w) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: _LinkColumn(heading: 'COLLECTIONS', links: _collectionLinks, delay: 0),
              ),
              Expanded(
                flex: 2,
                child: _LinkColumn(heading: 'SALPERS', links: _productLinks, delay: 100),
              ),
              Expanded(
                flex: 2,
                child: _LinkColumn(heading: 'COLECTINS', links: _categoryLinks, delay: 200),
              ),
              Expanded(
                flex: 2,
                child: _HaiyUpsColumn(links: _infoLinks, delay: 300),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Divider(color: Colors.white.withOpacity(0.08)),
          const SizedBox(height: 16),
          Text(
            '© 2026 DCOP. All rights reserved.',
            style: GoogleFonts.outfit(color: Colors.white24, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  //  MOBILE
  // ─────────────────────────────────────────────────────────────
  Widget _mobileLayout(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _LinkColumn(heading: 'COLLECTIONS', links: _collectionLinks, delay: 0),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _LinkColumn(heading: 'SALPERS', links: _productLinks, delay: 100)),
              Expanded(child: _LinkColumn(heading: 'COLECTINS', links: _categoryLinks, delay: 200)),
            ],
          ),
          const SizedBox(height: 24),
          _HaiyUpsColumn(links: _infoLinks, delay: 300),
          const SizedBox(height: 32),
          Divider(color: Colors.white.withOpacity(0.08)),
          const SizedBox(height: 16),
          Text(
            '© 2026 DCOP. All rights reserved.',
            style: GoogleFonts.outfit(color: Colors.white24, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _socialDot(String label) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white12),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(
        child: Text(
          label,
          style: GoogleFonts.outfit(
            color: Colors.white38,
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  COLLECTIONS PHOTO COLUMN  (left column with image)
// ═══════════════════════════════════════════════════════════════
class _CollectionsPhotoColumn extends StatelessWidget {
  final double w;
  const _CollectionsPhotoColumn({required this.w});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: w * 0.22,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'COLLECTIONS',
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w900,
              letterSpacing: 3,
            ),
          ).animate().fadeIn(duration: 600.ms),
          const SizedBox(height: 4),
          // Red underline accent
          Container(
            width: 32,
            height: 2,
            color: const Color(0xFFE81335),
          ),
          const SizedBox(height: 20),
          // Model photo
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: ColorFiltered(
                colorFilter: const ColorFilter.matrix([
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0,      0,      0,      1, 0,
                ]),
                child: Image.network(
                  'https://images.unsplash.com/photo-1552374196-1ab2a1c593e8?w=500&q=80',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: const Color(0xFF1A1A1A),
                    child: const Icon(Icons.person_outline, color: Colors.white24, size: 48),
                  ),
                ),
              ),
            ),
          ).animate(delay: 200.ms).fadeIn(duration: 700.ms).slideY(begin: 0.1),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  GENERIC LINK COLUMN
// ═══════════════════════════════════════════════════════════════
class _LinkColumn extends StatelessWidget {
  final String heading;
  final List<String> links;
  final int delay;

  const _LinkColumn({
    required this.heading,
    required this.links,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w900,
            letterSpacing: 2.5,
          ),
        ),
        const SizedBox(height: 4),
        Container(width: 24, height: 2, color: const Color(0xFFE81335)),
        const SizedBox(height: 16),
        ...links.map(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _HoverLink(text: link),
          ),
        ),
      ],
    ).animate(delay: delay.ms).fadeIn(duration: 600.ms).slideY(begin: 0.08);
  }
}

// ═══════════════════════════════════════════════════════════════
//  HAIY UPS COLUMN  (with Fast Plan button + model photo)
// ═══════════════════════════════════════════════════════════════
class _HaiyUpsColumn extends StatelessWidget {
  final List<String> links;
  final int delay;

  const _HaiyUpsColumn({required this.links, required this.delay});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'HAIY UPS',
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w900,
            letterSpacing: 2.5,
          ),
        ),
        const SizedBox(height: 4),
        Container(width: 24, height: 2, color: const Color(0xFFE81335)),
        const SizedBox(height: 16),
        ...links.map(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _HoverLink(text: link),
          ),
        ),
        const SizedBox(height: 20),
        // Fast Plan red pill button
        _FastPlanButton(),
        // Model photo (desktop only)
        if (w > 900) ...[
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 110,
              height: 130,
              child: ColorFiltered(
                colorFilter: const ColorFilter.matrix([
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0,      0,      0,      1, 0,
                ]),
                child: Image.network(
                  'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=300&q=80',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: const Color(0xFF1A1A1A),
                    child: const Icon(Icons.person_outline, color: Colors.white24, size: 36),
                  ),
                ),
              ),
            ),
          ).animate(delay: 400.ms).fadeIn(duration: 700.ms).slideY(begin: 0.1),
        ],
      ],
    ).animate(delay: delay.ms).fadeIn(duration: 600.ms).slideY(begin: 0.08);
  }
}

// ═══════════════════════════════════════════════════════════════
//  FAST PLAN RED BUTTON
// ═══════════════════════════════════════════════════════════════
class _FastPlanButton extends StatefulWidget {
  @override
  State<_FastPlanButton> createState() => _FastPlanButtonState();
}

class _FastPlanButtonState extends State<_FastPlanButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
        decoration: BoxDecoration(
          color: _hovered ? Colors.white : const Color(0xFFE81335),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          'Fast Plan',
          style: GoogleFonts.outfit(
            color: _hovered ? const Color(0xFFE81335) : Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  HOVER LINK
// ═══════════════════════════════════════════════════════════════
class _HoverLink extends StatefulWidget {
  final String text;
  const _HoverLink({required this.text});

  @override
  State<_HoverLink> createState() => _HoverLinkState();
}

class _HoverLinkState extends State<_HoverLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 150),
        style: GoogleFonts.outfit(
          color: _hovered ? Colors.white : Colors.white38,
          fontSize: 13,
          fontWeight: _hovered ? FontWeight.w500 : FontWeight.w400,
          letterSpacing: 0.3,
        ),
        child: Text(widget.text),
      ),
    );
  }
}
