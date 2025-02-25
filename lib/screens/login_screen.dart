import 'package:flutter/material.dart';
import 'package:d_input/d_input.dart';
import 'package:gap/gap.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _executeLogin() {
    final email = _emailController.text;
    if (email == '') return _showInvalidMessage('Email must be filled');
    final password = _passwordController.text;
    if (password == '') return _showInvalidMessage('Password must be filled');

    Navigator.pushNamed(context, '/next-page');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 80,
                      child: Icon(Icons.lock, size: 80),
                    ),
                    Gap(30),
                    Text(
                      'Your Food',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Gap(70),
                    DInputMix(
                      controller: _emailController,
                      hint: 'Email',
                    ),
                    Gap(20),
                    DInputMix(
                      controller: _passwordController,
                      hint: 'Password',
                    ),
                    Gap(20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FilledButton(
                        style: ButtonStyle(
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, 'home');
                        },
                        child: Text('Login'),
                      ),
                    ),
                    Gap(20),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text('Register'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showInvalidMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }
}
