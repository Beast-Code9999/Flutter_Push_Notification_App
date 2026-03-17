import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:push_notification_app/models/app_notification.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton( // logout button
            onPressed: () {
              FirebaseAuth.instance.signOut();
            }, 
            icon: Icon(Icons.logout)
          )
        ],
      ),
      body: StreamBuilder( // listen to notification collection and display each notification in a listview
        stream: FirebaseFirestore.instance.collection("notifications").snapshots(), 
        builder: (context, snapshot) {
          // loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),);
          }
          // Error state
          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong!"),);
          }
          // handgle no data/notification
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No notification"),);
          }
          // Data/notification exists
          final docs = snapshot.data!.docs; // list of firestore documents, each doc is a snapshot from firebase firestore

          return ListView.builder( // display list of notifcations
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data(); // each document on the specific index in extracted format
              final notification = AppNotification.fromMap(data); // convert extracted format to dart object

              return ListTile(
                title: Text(notification.title),
                subtitle: Text(notification.content),
              );
            }
          );
        }
      ),
    );
  }
}