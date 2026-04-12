import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80',
          ),
          fit: BoxFit.cover,
          opacity: 0.5,
        ),
      ),
      child: Stack(
        children: [
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.9),
                ],
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                      'DCOP',
                      style: GoogleFonts.outfit(
                        fontSize: 24,
                        letterSpacing: 8,
                        color: const Color(0xFFE50914),
                        fontWeight: FontWeight.bold,
                      ),
                    )
                    .animate()
                    .slideY(
                      begin: 1,
                      end: 0,
                      duration: 600.ms,
                      curve: Curves.easeOutCubic,
                    )
                    .fadeIn(),
                const SizedBox(height: 16),
                Text(
                      'STREETWEAR\nEVOLVED',
                      style: GoogleFonts.outfit(
                        fontSize: MediaQuery.of(context).size.width > 768
                            ? 84
                            : 48,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1.1,
                      ),
                    )
                    .animate()
                    .slideY(
                      begin: 1,
                      end: 0,
                      delay: 200.ms,
                      duration: 800.ms,
                      curve: Curves.easeOutCubic,
                    )
                    .fadeIn(),
                const SizedBox(height: 24),
                Container(
                  width: MediaQuery.of(context).size.width > 768 ? 600 : 300,
                  child:
                      Text(
                            'The latest collection of premium printed T-shirts. Level up your street style with uncompromising quality and futuristic designs.',
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              color: Colors.white70,
                              height: 1.5,
                            ),
                          )
                          .animate()
                          .slideX(
                            begin: -0.1,
                            end: 0,
                            delay: 400.ms,
                            duration: 800.ms,
                          )
                          .fadeIn(),
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 24,
                    ),
                    backgroundColor: const Color(0xFFE50914),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  child: Text(
                    'SHOP NOW',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ).animate().scale(
                  delay: 600.ms,
                  duration: 400.ms,
                  curve: Curves.elasticOut,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
