import 'package:flutter/material.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send Feedback')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
            'We would love to hear your feedback! Please email us at feedback@currensee.app'),
      ),
    );
  }
}
