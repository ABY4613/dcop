import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _policeEmailController = TextEditingController(text: 'police@gmail.com');
  final TextEditingController _policePasswordController = TextEditingController(text: 'password-123456');

  int _selectedRoleIndex = 0; // 0=Woman, 1=Guardian, 2=Police
  final List<String> _roles = ['Woman', 'Guardian', 'Police'];

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildHeader(),
                const SizedBox(height: 48),
                _buildRoleSelector(),
                const SizedBox(height: 40),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: _selectedRoleIndex == 2
                      ? _buildPoliceLogin(context, authController)
                      : _selectedRoleIndex == 1
                          ? _buildGuardianAuth(context, authController)
                          : _buildWomanAuth(context, authController),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(Icons.security_rounded, size: 80, color: AppColors.primary),
        ),
        const SizedBox(height: 24),
        const Text(
          AppStrings.appName,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 8),
        const Text(
          "Welcome to Your Safety Network",
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildRoleSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_roles.length, (index) {
          final isSelected = _selectedRoleIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedRoleIndex = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: isSelected
                      ? [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))]
                      : [],
                ),
                child: Center(
                  child: Text(
                    _roles[index],
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  bool _isLoginMode = true;
  
  final TextEditingController _regularEmailController = TextEditingController();
  final TextEditingController _regularPasswordController = TextEditingController();
  final TextEditingController _regularNameController = TextEditingController();
  final TextEditingController _regularPhoneController = TextEditingController();

  Widget _buildWomanAuth(BuildContext context, AuthController authController) {
    return Container(
      key: const ValueKey(0),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.female, size: 40, color: AppColors.accent),
          const SizedBox(height: 16),
          Text(
            _isLoginMode ? 'Sign In as Primary User' : 'Register as Primary User',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 32),
          
          if (!_isLoginMode) ...[
            CustomTextField(
              controller: _regularNameController,
              hintText: 'Full Name',
              icon: Icons.person_rounded,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _regularPhoneController,
              hintText: 'Phone Number',
              icon: Icons.phone_android_rounded,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
          ],
          
          CustomTextField(
            controller: _regularEmailController,
            hintText: 'Email Address',
            icon: Icons.email_rounded,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _regularPasswordController,
            hintText: 'Password',
            icon: Icons.lock_rounded,
            isPassword: true,
          ),
          
          const SizedBox(height: 32),
          CustomButton(
            text: _isLoginMode ? 'Login' : 'Register',
            isLoading: authController.isLoading,
            onPressed: () {
              if (_isLoginMode) {
                if (_regularEmailController.text.isNotEmpty && _regularPasswordController.text.isNotEmpty) {
                  authController.loginUser(
                    _regularEmailController.text, 
                    _regularPasswordController.text
                  );
                }
              } else {
                if (_regularEmailController.text.isNotEmpty && 
                    _regularPasswordController.text.isNotEmpty &&
                    _regularNameController.text.isNotEmpty &&
                    _regularPhoneController.text.isNotEmpty) {
                  authController.registerUser(
                    _regularEmailController.text,
                    _regularPasswordController.text,
                    _regularNameController.text,
                    _regularPhoneController.text,
                    'woman',
                  );
                }
              }
            },
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => setState(() => _isLoginMode = !_isLoginMode),
            child: Text(
              _isLoginMode ? "Don't have an account? Register" : "Already have an account? Login",
              style: const TextStyle(color: AppColors.primary),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGuardianAuth(BuildContext context, AuthController authController) {
    return Container(
      key: const ValueKey(1),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.shield, size: 40, color: AppColors.accent),
          const SizedBox(height: 16),
          const Text(
            'Sign In as Guardian',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 8),
          const Text(
            'Check credentials shared by User',
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 32),
          CustomTextField(
            controller: _regularEmailController,
            hintText: 'Guardian ID (e.g. GD1234)',
            icon: Icons.badge_rounded,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _regularPasswordController,
            hintText: 'Password',
            icon: Icons.lock_rounded,
            isPassword: true,
          ),
          const SizedBox(height: 32),
          CustomButton(
            text: 'Login',
            isLoading: authController.isLoading,
            onPressed: () {
              if (_regularEmailController.text.isNotEmpty && _regularPasswordController.text.isNotEmpty) {
                authController.loginGuardian(
                  _regularEmailController.text,
                  _regularPasswordController.text,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPoliceLogin(BuildContext context, AuthController authController) {
    return Container(
      key: const ValueKey(2),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.local_police_rounded, size: 40, color: Colors.blue),
          const SizedBox(height: 16),
          const Text(
            'Admin Authorization',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 32),
          CustomTextField(
            controller: _policeEmailController,
            hintText: 'Admin Email',
            icon: Icons.email_rounded,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _policePasswordController,
            hintText: 'Security Protocol Password',
            icon: Icons.lock_rounded,
            isPassword: true,
          ),
          const SizedBox(height: 32),
          CustomButton(
            text: 'Authenticate',
            isLoading: authController.isLoading,
            onPressed: () {
              if (_policeEmailController.text.isNotEmpty && _policePasswordController.text.isNotEmpty) {
                authController.loginWithPolice(
                  _policeEmailController.text, 
                  _policePasswordController.text
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
