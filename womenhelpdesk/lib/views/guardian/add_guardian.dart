import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/user_model.dart';
import '../../controllers/auth_controller.dart';
import '../../services/firestore_service.dart';
import '../../models/guardian_model.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../constants/app_colors.dart';
import 'package:uuid/uuid.dart';

class AddGuardian extends StatefulWidget {
  const AddGuardian({super.key});

  @override
  State<AddGuardian> createState() => _AddGuardianState();
}

class _AddGuardianState extends State<AddGuardian> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedRelation = 'Friend';
  
  final List<String> _relations = ['Father', 'Mother', 'Brother', 'Husband', 'Friend', 'Other'];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill with auto-generated credentials, user can override them
    _idController.text = 'GD${Random().nextInt(9000) + 1000}';
    _passwordController.text = (Random().nextInt(900000) + 100000).toString();
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Future<void> _sendSms(String phone, String id, String password) async {
    final message = 'Hello! I have added you as a Guardian on my SafeHer App. Please log in using Guardian ID: $id and Password: $password.';
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phone,
      query: encodeQueryParameters(<String, String>{'body': message}),
    );
    try {
      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri);
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not open SMS app.')));
      }
    } catch (e) {
      debugPrint('SMS Error: $e');
    }
  }

  void _showCredentialsDialog(String phone, String id, String password) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Guardian Added!', style: TextStyle(color: AppColors.textPrimary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Share these credentials with your guardian so they can log in to their dashboard.',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardPink.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary.withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  _buildCredentialRow('Guardian ID', id),
                  const Divider(color: AppColors.primary, height: 24, thickness: 0.2),
                  _buildCredentialRow('Password', password),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _sendSms(phone, id, password);
              Navigator.pop(context);
            },
            child: const Text('Send SMS Now', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text('Done', style: TextStyle(color: AppColors.textSecondary)),
          )
        ],
      ),
    );
  }

  Widget _buildCredentialRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        Text(value, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);
    final firestoreService = FirestoreService();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Enroll Guardian'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: _nameController,
              hintText: 'Guardian Name',
              icon: Icons.person_rounded,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _phoneController,
              hintText: 'Guardian Phone Number',
              icon: Icons.phone_android_rounded,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary.withOpacity(0.1)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedRelation,
                  isExpanded: true,
                  dropdownColor: AppColors.surface,
                  style: const TextStyle(color: AppColors.textPrimary, fontSize: 16),
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primary),
                  items: _relations
                      .map((r) => DropdownMenuItem(
                            value: r,
                            child: Text(r),
                          ))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedRelation = val);
                  },
                ),
              ),
            ),
            const SizedBox(height: 48),
            const Text(
              'Security Credentials',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 8),
            const Text(
              'System generated secure access codes for your guardian.',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            CustomTextField(
              controller: _idController,
              hintText: 'Guardian Access ID',
              icon: Icons.badge_rounded,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _passwordController,
              hintText: 'Access Password',
              icon: Icons.lock_outline_rounded,
            ),
            const SizedBox(height: 40),
            CustomButton(
              text: 'Confirm & Save',
              isLoading: _isLoading,
              onPressed: () async {
                if (_nameController.text.isNotEmpty &&
                    _phoneController.text.isNotEmpty &&
                    _idController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty) {
                  setState(() => _isLoading = true);

                  final guardian = GuardianModel(
                    id: const Uuid().v4(),
                    userId: authController.userModel!.uid,
                    guardianName: _nameController.text,
                    guardianPhone: _phoneController.text,
                    relation: _selectedRelation,
                    assignedId: _idController.text.trim(),
                    assignedPassword: _passwordController.text.trim(),
                  );

                  try {
                    // 1. Add to guardians collection
                    await firestoreService.addGuardian(guardian);
                    
                    // 2. Add to users collection so they can be chatted with
                    final guardianUser = UserModel(
                      uid: guardian.id,
                      name: guardian.guardianName,
                      phone: guardian.guardianPhone.replaceAll(RegExp(r'\D'), ''),
                      role: 'guardian',
                    );
                    await firestoreService.saveUser(guardianUser);

                    if (!context.mounted) return;
                    _showCredentialsDialog(_phoneController.text.trim(), _idController.text.trim(),
                        _passwordController.text.trim());
                  } catch (e) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to add guardian: $e')),
                    );
                  } finally {
                    if (mounted) {
                      setState(() => _isLoading = false);
                    }
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

