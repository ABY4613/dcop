import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/sos_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';

class SosButton extends StatefulWidget {
  const SosButton({super.key});

  @override
  State<SosButton> createState() => _SosButtonState();
}

class _SosButtonState extends State<SosButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sosController = Provider.of<SosController>(context);
    final authController = Provider.of<AuthController>(context);

    return ScaleTransition(
      scale: _animation,
      child: GestureDetector(
        onTap: () async {
          if (authController.userModel != null) {
            await sosController.triggerSos(authController.userModel!);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('SOS ALERT SENT!')),
              );
            }
          }
        },
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.sosRed, Color(0xFFBF002B)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.sosRed.withOpacity(0.3),
                spreadRadius: 20,
                blurRadius: 40,
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
            border: Border.all(color: Colors.white.withOpacity(0.2), width: 2),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.white, size: 60),
                SizedBox(height: 12),
                Text(
                  AppStrings.sosTap,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
