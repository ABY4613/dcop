import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_controller.dart';
import 'controllers/sos_controller.dart';
import 'config/theme.dart';
import 'constants/app_colors.dart';
import 'services/notification_service.dart';
import 'views/auth/setup_required_screen.dart';
import 'views/splash/splash_screen.dart';
import 'firebase_options.dart';

bool isFirebaseInitialized = false;
String firebaseError = "";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light, // White icons
    statusBarBrightness: Brightness.dark, // For iOS
  ));

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    isFirebaseInitialized = true;
    // Initialize Notifications
    await NotificationService().initialize();
  } catch (e) {
    debugPrint("Firebase initialization failed: $e");
    firebaseError = e.toString();
  }

  runApp(
    SafeHerApp(isInitialized: isFirebaseInitialized, error: firebaseError),
  );
}

class SafeHerApp extends StatelessWidget {
  final bool isInitialized;
  final String error;

  const SafeHerApp({
    super.key,
    required this.isInitialized,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      return SizedBox(
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          home: SetupRequiredScreen(error: error),
        ),
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthController()..checkCurrentUser(),
        ),
        ChangeNotifierProvider(create: (_) => SosController()),
      ],
      child: Consumer<AuthController>(
        builder: (context, auth, _) {
          return MaterialApp(
            title: 'SafeHer',
            color: AppColors.primary,
            theme: AppTheme.lightTheme,
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
