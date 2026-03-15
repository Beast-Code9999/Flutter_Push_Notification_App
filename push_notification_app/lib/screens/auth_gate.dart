import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // Listens to Firebase Auth state change
      stream: FirebaseAuth.instance.authStateChanges(), 
      builder: (context, snapshot) {
        // handle stream errors
        if ( snapshot.hasError ) {
          return Center(
            child: Text("Something went wrong!"),
          );
        }

        // loading when auth state is resolving
        if ( snapshot.connectionState == ConnectionState.waiting ) {
          return CircularProgressIndicator();
        }
        // if has data i.e. non-null, it means logged in
        if ( snapshot.hasData ) {
          // check role and display appropriate screens
          return Text("Logged in");
        }
        return Text("Hello world");
      }
    );
  }
}