import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:push_notification_app/screens/signup_screen.dart';
import 'package:push_notification_app/widgets/auth_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return AuthForm( // Widget created for sing-in and sign-up forms
      title: "sing in", 
      onSubmit: (email, password) async {
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        }
        on FirebaseAuthException catch (e) {
          // handle any errors returned by Firebase
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message ?? "Login failed")),
          );
        }
        catch (e) {
          // handle any errors like network or runtime errors
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Network error. Please try again.")),
          );
        }
      },
      bottomLink: TextButton(
        onPressed: () {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => SignupScreen())
          );
        }, 
        child: Text("Sign up?")),
    );
  }
}