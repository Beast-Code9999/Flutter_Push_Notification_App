import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:push_notification_app/screens/login_screen.dart';
import 'package:push_notification_app/services/user_services.dart';
import 'package:push_notification_app/widgets/auth_form.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return AuthForm(
      title: "sing up",
      onSubmit: (email, password) async {
        try { 
          // Attempt to create a new user with email and password
          final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          // save user to firestore
          await UserServices.createUser(
            userCredential.user!.uid,
            email,
            'student',
          );

          Navigator.pop(context); // go back to auth gate after successful sign up, which handles the screen navigation

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
            MaterialPageRoute(builder: (context) => LoginScreen())
          );
        }, 
        child: Text("Sign in if you already have an account.")
      ),
    );
  }
}