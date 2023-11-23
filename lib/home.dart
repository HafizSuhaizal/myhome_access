import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myhome_access/login_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth= FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    String? _email=_auth.currentUser!.email;
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Logged In With: $_email"),
              SizedBox(height: 50,),
              ElevatedButton(onPressed:(){
                _auth.signOut();
                Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen(),
                )
                );
              },
                  child: Text('Sign Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
