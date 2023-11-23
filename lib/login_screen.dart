import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myhome_access/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key); // Updated for null safety

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(), // Using the controller's text
          password: _passwordController.text.trim(), // Using the controller's text
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User Logged In: ${userCredential.user!.email}')),
        );
        Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage(),),);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error During Login: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"), // const added for optimization
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16), // const added for optimization
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Your Email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Your Password";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _handleLogin,
                  child: const Text("Login"), // Corrected syntax error
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
