import 'package:flutter/material.dart';

class SignInAccountPage extends StatelessWidget {
  const SignInAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Sign In")),
        body: const Text('Sign in'));
  }
}
