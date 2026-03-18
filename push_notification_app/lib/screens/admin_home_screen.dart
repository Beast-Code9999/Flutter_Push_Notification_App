import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:push_notification_app/models/app_notification.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  // create controller for inputs
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  Future<void> _sendNotifciation() async {
    try {
      // prevent empty submission
      if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please fill all fields")),
        );
        return;
      }

      // add a new notification item to collection("notifications")
      await FirebaseFirestore.instance.collection('notifications').add(
        AppNotification(
          id: '', 
          title: _titleController.text, 
          content: _contentController.text, 
          sentBy: FirebaseAuth.instance.currentUser!.email ?? '', 
          createdAt: DateTime.now(), 
          isRead: false
        ).toMap()
      );

      // clear fields after success
      _titleController.clear();
      _contentController.clear();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Notificaiton sent")),
      );
    }
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send notification")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton( // sign out button
            onPressed: () {
              FirebaseAuth.instance.signOut();
            }, 
            icon: Icon(Icons.logout)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField( // Title input
              controller: _titleController,
              decoration: InputDecoration(
                label: Text("Add title of Notification"),
                border: OutlineInputBorder()
              ),
            ),
        
            SizedBox(height: 20),
        
            TextField( // Content input
              controller: _contentController,
              decoration: InputDecoration(
                label: Text("Add content of Notification"),
                border: OutlineInputBorder()
              ),
            ),
        
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _sendNotifciation(); // call _sendNotifciation and saves to Firestore notification collection
                }, 
                child: Text("Send notification")
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}