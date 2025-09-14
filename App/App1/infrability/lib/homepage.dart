import 'package:flutter/material.dart';
import 'package:infrability/login_page.dart';
import 'package:infrability/signup_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to our app!',
              style: TextStyle(fontSize: 24),
            ),
            Image.asset('images/Logo_72.png'),
            const Text(
              'How do you wish to proceed?',
              style: TextStyle(fontSize: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    // Go to the create account page.
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const SignupPage();
                      }),
                    );
                  },
                  child: const Text('Create an account'),
                ),
                TextButton(
                  onPressed: () {
                    // Go to the login page.
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const LoginPage();
                      }),
                    );
                  },
                  child: const Text('Log in'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
