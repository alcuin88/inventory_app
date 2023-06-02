import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formkey = GlobalKey<FormState>();

  bool _hasAccount = true;
  bool _isAuthenticating = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _submit() async {
    final formState = _formkey.currentState!;

    if (!formState.validate()) {
      return;
    }

    try {
      setState(() {
        _isAuthenticating = true;
      });

      if (_hasAccount) {
        await _firebase.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
      } else {
        await _firebase.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
      }
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? "Authentication failed."),
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool darkMode = brightness == Brightness.dark;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 30, bottom: 20, left: 20, right: 20),
                width: 300,
                child: darkMode ? Image.asset("assets/logos/logo_dark_mode.png") : Image.asset("assets/logos/logo_light_mode.png"),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: "Email Address"),
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains("@")) {
                                return "Please enter a valid email address.";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Password",
                            ),
                            controller: _passwordController,
                            obscureText: _hasAccount ? true : false,
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return "Password must be at least 6 characters long.";
                              }
                              return null;
                            },
                          ),
                          if (!_hasAccount)
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Confrim Password",
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.trim() !=
                                        _passwordController.text.trim()) {
                                  return "Password does not match.";
                                }
                                return null;
                              },
                            ),
                          if (_isAuthenticating)
                            const CircularProgressIndicator(),
                          if (!_isAuthenticating)
                            ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              child: Text(_hasAccount ? "Login" : "Sign-up"),
                            ),
                          if (!_isAuthenticating)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _hasAccount = !_hasAccount;
                                });
                              },
                              child: Text(_hasAccount
                                  ? "Create an account"
                                  : "I already have an account."),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
