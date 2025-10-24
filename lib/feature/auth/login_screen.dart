// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:x_deal/core/utils/app_colors.dart';
import 'package:x_deal/core/utils/app_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:x_deal/core/utils/app_images.dart';
import 'package:x_deal/core/utils/app_string.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showForgotPassword() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text(AppString.forgetPass),
            content: const Text(
              'Password reset instructions will be sent to your email.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: implement actual login
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Logging in...')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: mq.width * 0.08,
            vertical: mq.height * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: mq.height * 0.05),
              SvgLogo(size: mq.width * 0.28 > 120 ? 120 : mq.width * 0.28),
              SizedBox(height: mq.height * 0.04),
              Text(
                'Welcome back',
                style: TextStyle(
                  fontSize: mq.width * 0.06 > 22 ? 22 : mq.width * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: mq.height * 0.02),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(labelText: 'Username'),
                      validator:
                          (v) =>
                              (v == null || v.isEmpty)
                                  ? 'Enter username'
                                  : null,
                    ),
                    SizedBox(height: mq.height * 0.02),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscure,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscure ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                      ),
                      validator:
                          (v) =>
                              (v == null || v.length < 6)
                                  ? 'Password must be 6+ chars'
                                  : null,
                    ),
                    SizedBox(height: mq.height * 0.015),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _showForgotPassword,
                        child: const Text('Forgot password?'),
                      ),
                    ),
                    SizedBox(height: mq.height * 0.02),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                        child: const Text('Login'),
                      ),
                    ),
                    SizedBox(height: mq.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const RegisterScreen(),
                                ),
                              ),
                          child: const Text('Register'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SvgLogo extends StatelessWidget {
  final double size;
  const SvgLogo({required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    try {
      return SvgPicture.asset(
        AppIcons.logo,
        width: size,
        height: size,
        color: AppColors.primary,
      );
    } catch (_) {
      return Image.asset(AppImages.logo, width: size, height: size);
    }
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: const Center(child: Text('Register screen placeholder')),
    );
  }
}
