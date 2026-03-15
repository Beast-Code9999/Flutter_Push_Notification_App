import 'package:flutter/material.dart';
import 'package:push_notification_app/models/app_user.dart';

class RoleGate extends StatelessWidget {
  const RoleGate({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppUser>(
      future: null, 
      builder: (context, snapshot) {
        if (snapshot.hasError) { // If future or stream failed
          return Center(child: Text("Something went wrong"));
        }


        if (!snapshot.hasData) { // The future has not returned any data or has returned a null
          return const Center(child: CircularProgressIndicator(),);
        }

        final user = snapshot.data!;

        if (user.role == 'admin') { // show admin home page
          return Text("Admin screen here");
        }

        return Text("Student home screen here"); // Show student home page

      }
    );
  }
}

