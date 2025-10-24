// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:x_deal/core/utils/app_colors.dart';
import 'package:x_deal/core/utils/app_images.dart';
import 'package:x_deal/core/utils/app_string.dart';
import 'package:x_deal/feature/auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final PageController _controller = PageController();
  late final AnimationController _skipFadeController;
  int _page = 0;

  final List<Map<String, String>> _pages = [
    {'image': AppImages.logo, 'text': AppString.firstDiscription},
    {'image': AppImages.logo, 'text': AppString.secondDiscription},
    {'image': AppImages.logo, 'text': AppString.thirdDiscription},
    {'image': AppImages.logo, 'text': AppString.fourthDiscription},
  ];

  @override
  void dispose() {
    _controller.dispose();
    _skipFadeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _skipFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      value: 1.0,
    );
  }

  Future<void> _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with Skip button (fades) and hidden on last page
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: mq.width * 0.04,
                vertical: mq.height * 0.01,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_page != _pages.length - 1)
                    FadeTransition(
                      opacity: _skipFadeController,
                      child: TextButton(
                        onPressed: _finishOnboarding,
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: mq.width * 0.04,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (i) => setState(() => _page = i),
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final item = _pages[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: mq.width * 0.06,
                      vertical: mq.height * 0.04,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.8, end: 1.0),
                          duration: const Duration(milliseconds: 500),
                          builder:
                              (context, value, child) =>
                                  Transform.scale(scale: value, child: child),
                          child: Container(
                            height:
                                mq.width * 0.75 > 300 ? 300.0 : mq.width * 0.75,
                            width:
                                mq.width * 0.75 > 300 ? 300.0 : mq.width * 0.75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                mq.width * 0.04 > 16 ? 16.0 : mq.width * 0.04,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 12,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                mq.width * 0.04 > 16 ? 16.0 : mq.width * 0.04,
                              ),
                              child: Image.asset(
                                item['image']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: mq.height * 0.04 * 0.9),
                        Text(
                          item['text']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize:
                                mq.width * 0.045 > 18 ? 18.0 : mq.width * 0.045,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: mq.height * 0.03 > 24 ? 24.0 : mq.height * 0.03,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(
                          horizontal:
                              mq.width * 0.015 > 6 ? 6.0 : mq.width * 0.015,
                        ),
                        height: mq.height * 0.01 > 8 ? 8.0 : mq.height * 0.01,
                        width:
                            _page == i
                                ? (mq.width * 0.18 > 28
                                    ? 28.0
                                    : mq.width * 0.18)
                                : (mq.height * 0.01 > 8
                                    ? 8.0
                                    : mq.height * 0.01),
                        decoration: BoxDecoration(
                          color:
                              _page == i
                                  ? AppColors.primary
                                  : AppColors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(
                            mq.height * 0.01 > 8 ? 8.0 : mq.height * 0.01,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: mq.height * 0.02 > 16 ? 16 : mq.height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: mq.width * 0.08),
                    child: Row(
                      children: [
                        if (_page != _pages.length - 1)
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                _controller.nextPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.ease,
                                );
                              },
                              child: Text('Next'),
                            ),
                          ),
                        if (_page != _pages.length - 1)
                          SizedBox(width: mq.width * 0.04),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: EdgeInsets.symmetric(
                                vertical:
                                    mq.height * 0.02 > 14
                                        ? 14
                                        : mq.height * 0.02,
                              ),
                            ),
                            onPressed: _finishOnboarding,
                            child: Text(
                              _page == _pages.length - 1
                                  ? 'Get Started'
                                  : 'Get Started',
                              style: TextStyle(
                                fontSize:
                                    mq.width * 0.045 > 18
                                        ? 18
                                        : mq.width * 0.045,
                              ),
                            ),
                          ),
                        ),
                      ],
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
}
