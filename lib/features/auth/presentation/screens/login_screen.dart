import 'package:currensee/core/constants/app_strings.dart';
import 'package:currensee/core/widgets/custom_button.dart';
import 'package:currensee/core/widgets/custom_textfield.dart';
import 'package:currensee/features/auth/presentation/widgets/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:currensee/features/auth/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      ref.read(authControllerProvider.notifier).signIn(
            _emailController.text.trim(),
            _passwordController.text.trim(),
            (error) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error)),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);

    // Listen to auth state to navigate away on successful login
    ref.listen(authStateProvider, (previous, next) {
      if (next.value != null) {
        context.go('/converter');
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.loginTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            const Text("Sign In",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            CustomTextField(
              controller: _emailController,
              hintText: AppStrings.emailHint,
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _passwordController,
              hintText: AppStrings.passwordHint,
              prefixIcon: Icons.lock_outline,
              obscureText: true,
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'Login',
              isLoading: isLoading,
              onPressed: _handleLogin,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () => context.go('/register'),
                  child: const Text('Sign Up'),
                ),
              ],
            ),
            const Divider(height: 48),
            SocialLoginButton(
              text: 'Sign in with Google',
              assetPath: 'assets/google.svg', // Assumes you have this asset
              onPressed: () {
                // TODO: Implement Google Sign-In
              },
            ),
          ],
        ),
      ),
    );
  }
}
