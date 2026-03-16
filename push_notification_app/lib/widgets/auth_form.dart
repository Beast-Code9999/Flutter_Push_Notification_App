import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final String title;
  final Function(String email, String password) onSubmit;
  final Widget bottomLink;

  const AuthForm({
    super.key,
    required this.title,
    required this.onSubmit,
    required this.bottomLink
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) { 
    return Scaffold( // Authentication form used for Login and Signup
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              // username
              controller: _usernameController,
              decoration: InputDecoration(
                label: Text("Username")
              ),
            ),
            TextField(
              // password
              controller: _passwordController,
              decoration: InputDecoration(
                label: Text("Password")
              ),
              obscureText: true,

            ),
            ElevatedButton(
              onPressed: () {
                widget.onSubmit(_usernameController.text, _passwordController.text);
              }, 
              child: Text(widget.title)
            ),
            
            SizedBox(height: 20,),

            widget.bottomLink,
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}