import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../controllers/auth_controller.dart';
import '../../constants/app_colors.dart';
import '../chat/chat_detail_screen.dart';
import '../chat/chat_list_screen.dart';

class GuardianDashboard extends StatelessWidget {
  const GuardianDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);
    final user = authController.userModel;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Guardian Dashboard'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.forum_rounded, color: AppColors.primary),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatListScreen()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: AppColors.primary),
            onPressed: () => authController.logout(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeCard(user?.name),
            const SizedBox(height: 32),
            const Text('Safety Recipient', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            const SizedBox(height: 16),
            _buildProtectedUsersList(context, user?.uid),
            const SizedBox(height: 40),
            const Text('Emergency Response', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: [
                _buildActionCard(context, 'Live Location', Icons.map_rounded, Colors.green),
                _buildActionCard(context, 'Active Alerts', Icons.warning_rounded, Colors.red),
                _buildActionCard(context, 'Call Primary', Icons.phone_in_talk_rounded, Colors.blue),
                _buildActionCard(context, 'Alert History', Icons.history_rounded, Colors.orange),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(String? name) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Welcome Back,', style: TextStyle(fontSize: 16, color: AppColors.textSecondary)),
          const SizedBox(height: 4),
          Text(
            name ?? 'Guardian',
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.successGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'ACTIVE NETWORK CONNECTION',
              style: TextStyle(color: AppColors.successGreen, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProtectedUsersList(BuildContext context, String? guardianUid) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withOpacity(0.05)),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withOpacity(0.1),
          child: const Icon(Icons.person, color: AppColors.primary),
        ),
        title: const Text('Safety Recipient', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
        subtitle: const Text('Click to open secure chat', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        trailing: const Icon(Icons.forum_rounded, color: AppColors.primary),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatListScreen()));
        },
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Opening $title...')));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardPink.withOpacity(0.5),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.primary.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 15, offset: const Offset(0, 8)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 32, color: color),
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
