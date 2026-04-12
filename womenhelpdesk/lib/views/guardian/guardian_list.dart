import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/auth_controller.dart';
import '../../services/firestore_service.dart';
import '../../models/guardian_model.dart';
import '../../constants/app_colors.dart';
import '../chat/chat_detail_screen.dart';
import 'add_guardian.dart';

class GuardianList extends StatelessWidget {
  const GuardianList({super.key});

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Future<void> _sendSms(BuildContext context, String phone, String id, String password) async {
    final message = 'Hello! I have added you as a Guardian on my SafeHer App. Please log in using Guardian ID: $id and Password: $password.';
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phone,
      query: _encodeQueryParameters(<String, String>{'body': message}),
    );
    try {
      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri);
      } else {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not open SMS app.')));
      }
    } catch (e) {
      debugPrint('SMS Error: $e');
    }
  }

  void _showCredentialsDialog(BuildContext context, GuardianModel guardian) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Guardian Credentials'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Relation: ${guardian.relation}', style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.grey)),
            const SizedBox(height: 16),
            Text('Guardian ID: ${guardian.assignedId}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Password: ${guardian.assignedPassword}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _sendSms(context, guardian.guardianPhone, guardian.assignedId, guardian.assignedPassword);
            },
            child: const Text('Resend via SMS', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);
    final firestoreService = FirestoreService();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('My Guardians'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<List<GuardianModel>>(
        stream: firestoreService.getGuardians(authController.userModel?.uid ?? ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No guardians added yet.', style: TextStyle(color: AppColors.textSecondary)));
          }

          final guardians = snapshot.data!;

          return ListView.builder(
            itemCount: guardians.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final guardian = guardians[index];
              return Card(
                color: AppColors.surface,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: AppColors.primary.withOpacity(0.1)),
                ),
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  onTap: () => _showCredentialsDialog(context, guardian),
                  leading: const CircleAvatar(
                    backgroundColor: AppColors.cardPink,
                    child: Icon(Icons.shield_rounded, color: AppColors.primary),
                  ),
                  title: Text(guardian.guardianName, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  subtitle: Text('${guardian.relation} • Tap to view credentials', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.forum_rounded, color: AppColors.primary),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatDetailScreen(
                                receiverId: guardian.id,
                                receiverName: guardian.guardianName,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_sweep_rounded, color: AppColors.error),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              backgroundColor: AppColors.surface,
                              title: const Text('Remove Guardian', style: TextStyle(color: AppColors.textPrimary)),
                              content: Text('Are you sure you want to remove ${guardian.guardianName}?', style: const TextStyle(color: AppColors.textSecondary)),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx),
                                  child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(ctx);
                                    firestoreService.deleteGuardian(guardian.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('${guardian.guardianName} removed.')),
                                    );
                                  },
                                  child: const Text('Remove', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddGuardian())),
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 30),
      ),
    );
  }
}

