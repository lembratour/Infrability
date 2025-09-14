import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Circular logo
              Image.asset('images/Logo_72.png', width: 100),
              // Email field
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              // Password field
              TextFormField(
                obscureText: true,
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 15),
              // Login button
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    // Sign in with email and password.
                    _signInWithEmailAndPassword();
                  },
                ),
              ),
              // Forgot password text
              const Text(
                'Forgot Password ?',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signInWithEmailAndPassword() async {
    try {
      // Sign in with email and password.
      final user = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // If sign in is successful, go to the home page.
      // ignore: unnecessary_null_comparison
      if (user != null) {
        // ignore: use_build_context_synchronously
        //Navigator.pushNamed(context, '/home');
        debugPrint('Login Success');
      }
    } catch (e) {
      // If sign in fails, show an error message.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
}
