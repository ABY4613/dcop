import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theme.dart';
import 'views/home/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'DCOP',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomeView(),
      // Adding support for smooth scrolling on web/desktop
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          ...MaterialScrollBehavior().dragDevices,
          // ignore: deprecated_member_use
        },
      ),
    );
  }
}
