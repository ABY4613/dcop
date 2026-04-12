import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedLoader extends StatelessWidget {
  const AnimatedLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                  'DCOP',
                  style: GoogleFonts.outfit(
                    fontSize: 64,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 4,
                  ),
                )
                .animate(
                  onPlay: (controller) => controller.repeat(reverse: true),
                )
                .fadeIn(duration: 800.ms)
                .shimmer(duration: 1200.ms, color: const Color(0xFFE50914))
                .scale(
                  begin: const Offset(0.9, 0.9),
                  end: const Offset(1.1, 1.1),
                  duration: 1200.ms,
                  curve: Curves.easeInOut,
                ),
            const SizedBox(height: 20),
            Container(
              width: 150,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child:
                    Container(
                          width: 50,
                          height: 4,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE50914),
                            borderRadius: BorderRadius.circular(2),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFE50914).withOpacity(0.8),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        )
                        .animate(onPlay: (controller) => controller.repeat())
                        .moveX(
                          begin: 0,
                          end: 100,
                          duration: 1000.ms,
                          curve: Curves.easeInOut,
                        )
                        .fadeIn(duration: 300.ms)
                        .fadeOut(delay: 700.ms, duration: 300.ms),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
