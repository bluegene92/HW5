import 'package:flutter/material.dart';
import 'package:hw4/services/auth.dart';
import 'package:hw4/utils/string_validator.dart';

import '../controllers/auth_controller.dart';
import 'home_page.dart';

class SignInAccountPage extends StatefulWidget {
  const SignInAccountPage({super.key});

  @override
  State<SignInAccountPage> createState() => _SignInAccountPageState();
}

class _SignInAccountPageState extends State<SignInAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Sign In")),
        body: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_errorMessage, style: const TextStyle(color: Colors.red)),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email Address'),
                  validator: validateEmailAddress,
                ),
                TextFormField(
                  obscureText: true,
                  controller: _pwController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: validatePassword,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        var error = await AuthController().signIn(
                            email: _emailController.text,
                            password: _pwController.text);

                        if (error == null) {
                          //sign in successful
                          if (!mounted) return;
                          _navigateToHomePage(context);
                        }

                        if (error != null) {
                          //sign in fail
                          setState(() {
                            _errorMessage = error;
                          });
                        }
                      }
                    },
                    child: const Text('Sign In'))
              ],
            )));
  }
}

void _navigateToHomePage(BuildContext context) {
  print('sign in as ${AuthController().userId}');
  final currentContext = context;
  Navigator.of(currentContext).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomePage()));
}
