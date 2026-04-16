import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CollectionsSection extends StatefulWidget {
  const CollectionsSection({Key? key}) : super(key: key);

  @override
  State<CollectionsSection> createState() => _CollectionsSectionState();
}

class _CollectionsSectionState extends State<CollectionsSection> {
  String _activeFilter = 'Current';

  static const _filters = ['Current', 'Archive', 'Limited'];

  static const _cards = [
    _CollectionCard(
      imageUrl: 'https://images.unsplash.com/photo-1529139574466-a303027c1d8b?w=700&q=80',
      label: 'DROP 01',
      tag: '63',
      tagColor: Color(0xFFE81335),
      subtitle: 'Street Essentials',
    ),
    _CollectionCard(
      imageUrl: 'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?w=700&q=80',
      label: 'DROP 02',
      tag: 'HOT',
      tagColor: Color(0xFF444444),
      subtitle: 'Urban Signature',
    ),
    _CollectionCard(
      imageUrl: 'https://images.unsplash.com/photo-1583309728236-86a7c96218d3?w=700&q=80',
      label: 'DROP 03',
      tag: null,
      tagColor: null,
      subtitle: 'The Nightwatch Collection',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w > 900) return _desktopLayout(context);
    if (w > 600) return _tabletLayout(context);
    return _mobileLayout(context);
  }

  // ─────────────────────────────────────────────────────────────
  //  DESKTOP
  // ─────────────────────────────────────────────────────────────
  Widget _desktopLayout(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 60),
      child: Column(
        children: [
          // ── Title row ──
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 160), // balance
              Text(
                'COLLECTIONS',
                style: GoogleFonts.outfit(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 5,
                ),
              ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.1),
              // Filter pill button
              _FilterPill(
                filters: _filters,
                active: _activeFilter,
                onChanged: (f) => setState(() => _activeFilter = f),
              ),
            ],
          ),
          const SizedBox(height: 40),
          // ── 3 cards row ──
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(_cards.length, (i) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: i < _cards.length - 1 ? 16 : 0),
                  child: _CollectionCardWidget(card: _cards[i], index: i),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  //  TABLET
  // ─────────────────────────────────────────────────────────────
  Widget _tabletLayout(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'COLLECTIONS',
                style: GoogleFonts.outfit(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 4,
                ),
              ).animate().fadeIn(duration: 600.ms),
              _FilterPill(
                filters: _filters,
                active: _activeFilter,
                onChanged: (f) => setState(() => _activeFilter = f),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(_cards.length, (i) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: i < _cards.length - 1 ? 10 : 0),
                  child: _CollectionCardWidget(card: _cards[i], index: i),
                ),
              );
            }),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 16,
            runSpacing: 16,
            children: [
              Text(
                'COLLECTIONS',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 3,
                ),
              ).animate().fadeIn(duration: 600.ms),
              _FilterPill(
                filters: _filters,
                active: _activeFilter,
                onChanged: (f) => setState(() => _activeFilter = f),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _cards.length,
              itemBuilder: (ctx, i) => Padding(
                padding: EdgeInsets.only(right: i < _cards.length - 1 ? 12 : 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.72,
                  child: _CollectionCardWidget(card: _cards[i], index: i),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  FILTER PILL (top-right of section)
// ═══════════════════════════════════════════════════════════════
class _FilterPill extends StatelessWidget {
  final List<String> filters;
  final String active;
  final ValueChanged<String> onChanged;

  const _FilterPill({
    required this.filters,
    required this.active,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: filters.map((f) {
          final isActive = f == active;
          return GestureDetector(
            onTap: () => onChanged(f),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFFE81335) : Colors.transparent,
                borderRadius: BorderRadius.circular(26),
              ),
              child: Text(
                f,
                style: GoogleFonts.outfit(
                  color: isActive ? Colors.white : Colors.white54,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 200.ms);
  }
}

// ═══════════════════════════════════════════════════════════════
//  DATA MODEL FOR COLLECTION CARD
// ═══════════════════════════════════════════════════════════════
class _CollectionCard {
  final String imageUrl;
  final String label;
  final String? tag;
  final Color? tagColor;
  final String subtitle;

  const _CollectionCard({
    required this.imageUrl,
    required this.label,
    required this.tag,
    required this.tagColor,
    required this.subtitle,
  });
}

// ═══════════════════════════════════════════════════════════════
//  SINGLE COLLECTION CARD WIDGET
// ═══════════════════════════════════════════════════════════════
class _CollectionCardWidget extends StatefulWidget {
  final _CollectionCard card;
  final int index;

  const _CollectionCardWidget({required this.card, required this.index});

  @override
  State<_CollectionCardWidget> createState() => _CollectionCardWidgetState();
}

class _CollectionCardWidgetState extends State<_CollectionCardWidget> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..translate(0.0, _hovered ? -6.0 : 0.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: AspectRatio(
            aspectRatio: 3 / 4,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // ── Photo (B&W) ──
                ColorFiltered(
                  colorFilter: const ColorFilter.matrix([
                    0.2126, 0.7152, 0.0722, 0, 0,
                    0.2126, 0.7152, 0.0722, 0, 0,
                    0.2126, 0.7152, 0.0722, 0, 0,
                    0,      0,      0,      1, 0,
                  ]),
                  child: Image.network(
                    widget.card.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFF1A1A1A),
                      child: const Icon(Icons.image_outlined, color: Colors.white24, size: 48),
                    ),
                  ),
                ),

                // ── Bottom gradient ──
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 120,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black, Colors.transparent],
                      ),
                    ),
                  ),
                ),

                // ── Bottom label row ──
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.card.label,
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.card.subtitle,
                              style: GoogleFonts.outfit(
                                color: Colors.white54,
                                fontSize: 11,
                                letterSpacing: 0.5,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      if (widget.card.tag != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: widget.card.tagColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            widget.card.tag!,
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // ── Hover overlay ──
                AnimatedOpacity(
                  opacity: _hovered ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 250),
                  child: Container(
                    color: Colors.white.withOpacity(0.06),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
          .animate(delay: (150 * widget.index).ms)
          .fadeIn(duration: 600.ms)
          .slideY(begin: 0.1, end: 0, duration: 600.ms, curve: Curves.easeOutCubic),
    );
  }
}
