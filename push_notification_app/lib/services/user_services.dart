import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:push_notification_app/models/app_user.dart';

class UserServices {
    // fetch user
    static Future<AppUser> getCurrentUser() async {
        // Get uid from current user
        final uid = FirebaseAuth.instance.currentUser!.uid; 

        // reads document from firestore
        final doc = await FirebaseFirestore.instance
        .collection('users') // goes to users collection
        .doc(uid) // within users collections get one specific user collection with matching uid
        .get(); // fetch

        // null check
        final data = doc.data();
        if (data == null) {
            throw Exception('User document not found');
        }
        return AppUser.fromMap(data);
    }
}