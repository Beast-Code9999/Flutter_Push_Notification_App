import 'package:flutter/material.dart';
import 'package:push_notification_app/models/app_user.dart';
import 'package:push_notification_app/screens/admin_home_screen.dart';
import 'package:push_notification_app/screens/student_home_screen.dart';
import 'package:push_notification_app/services/user_services.dart';

class RoleGate extends StatelessWidget {
  const RoleGate({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppUser>( // One time fetching and displaying of future data
      future: UserServices.getCurrentUser(), // 
      builder: (context, snapshot) {
        if (snapshot.hasError) { // If future or stream failed
          return Center(child: Text("Something went wrong"));
        }

        if (!snapshot.hasData) { // The future has not returned any data or has returned a null
          return const Center(child: CircularProgressIndicator(),);
        }

        final user = snapshot.data!;

        if (user.role == 'admin') { // show admin home page
          return AdminHomeScreen();
        }

        return StudentHomeScreen(); // Show student home page
      }
    );
  }
}

