import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class SetupRequiredScreen extends StatelessWidget {
  final String error;
  const SetupRequiredScreen({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_off_rounded, size: 100, color: AppColors.primary),
            const SizedBox(height: 32),
            const Text(
              'Configuration Required',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'To activate SafeHer protection, you must initialize your Firebase project first.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
            ),
            const SizedBox(height: 48),
            _buildStep('1. Install FlutterFire CLI.'),
            _buildStep('2. Run "flutterfire configure" in your project terminal.'),
            _buildStep('3. Add your google-services.json to the android/app folder.'),
            const SizedBox(height: 48),
            Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: const Text('Technical Diagnostics', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'ERROR: $error',
                        style: const TextStyle(fontSize: 12, color: AppColors.error, fontFamily: 'monospace'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline_rounded, size: 24, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(color: AppColors.textPrimary, fontSize: 15))),
        ],
      ),
    );
  }
}
