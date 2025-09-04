import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart'; // Add flutter_svg to pubspec.yaml to use

class SocialLoginButton extends StatelessWidget {
  final String text;
  final String assetPath;
  final VoidCallback onPressed;

  const SocialLoginButton({
    super.key,
    required this.text,
    required this.assetPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: const Icon(Icons.g_mobiledata, size: 28), // Placeholder icon
      // icon: SvgPicture.asset(assetPath, height: 24), // Use this with flutter_svg
      label: Text(text),
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
