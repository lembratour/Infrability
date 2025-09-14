import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:infrability/login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  //initialising the database
  final _auth = FirebaseAuth.instance;
  final _database = FirebaseDatabase.instance.ref();

  //initializing the input fields controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Circular logo
              CircleAvatar(
                radius: 50.0,
                child: Image.asset('images/Logo_72.png'),
              ),
              const SizedBox(height: 20.0),
              // Text fields
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextFormField(
                controller: _lastnameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                ),
              ),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              TextFormField(
                controller: null,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20.0),
              // Sign up button
              OutlinedButton(
                child: const Text('Sign Up'),
                onPressed: () {
                  signUp();
                },
              ),
              const SizedBox(height: 20.0),
              // Social login buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.person),
                    onPressed: () {
                      debugPrint('person');
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.facebook),
                    onPressed: () {
                      debugPrint('facebook');
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.alarm),
                    onPressed: () {
                      debugPrint('alarm');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              // Already have an account? Log in text
              TextButton(
                onPressed: () {
                  // Go to the login page.
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const LoginPage();
                    }),
                  );
                },
                child: const Text(
                  'Already got an account? Log in',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Data Persistence code

  Future<void> signUp() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final name = _nameController.text;
    final lastname = _lastnameController.text;
    final username = _usernameController.text;
    final phone = _phoneNumberController.text;
    debugPrint(
        'name : $name lastname: $lastname username: $username phone: $phone email: $email password: $password');
    try {
      //creating the user
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = userCredential.user;

      // Persist the data
      final userRef = _database.child('users').child(user!.uid);
      debugPrint(userRef.toString());
      userRef.set({
        'name': _nameController.text,
        'lastname': _lastnameController.text,
        'username': _usernameController.text,
        'phone_number': _phoneNumberController.text,
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
