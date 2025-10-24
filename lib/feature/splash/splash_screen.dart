// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:x_deal/core/utils/app_colors.dart';
import 'package:x_deal/core/utils/app_icons.dart';
import 'package:x_deal/core/utils/app_string.dart';
import 'package:x_deal/feature/onboarding/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:x_deal/feature/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goToOnboarding();
  }

  void _goToOnboarding() {
    Future.delayed(const Duration(seconds: 5), () async {
      if (!mounted) return;
      final prefs = await SharedPreferences.getInstance();
      final seen = prefs.getBool('seenOnboarding') ?? false;

      if (seen) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 1200),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.scale(scale: value, child: child),
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Use the SVG logo defined in AppIcons
              SvgPicture.asset(
                AppIcons.logo,
                width: mq.width * 0.24,
                height: mq.width * 0.24,
                color: Colors.white,
              ),
              SizedBox(height: mq.height * 0.02),
              Text(
                AppString.appName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: mq.width * 0.07,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
