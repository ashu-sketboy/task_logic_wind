import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:task_login_wing/model/user.dart' as own;

class ProfileScreen extends StatelessWidget {
  final otherUser;
  final user = FirebaseAuth.instance.currentUser!;

  ProfileScreen({Key? key, this.otherUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(36, 59, 124, 1),
        title: const Text('Profile Screen'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Spacer(),
            CircleAvatar(
              radius: 65,
              // child: Icon(Icons.verified_user),
              backgroundImage: NetworkImage(
                  otherUser == null ? user.photoURL! : otherUser.image),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(otherUser == null ? user.displayName! : otherUser.name),
            const Spacer(),
            Text(otherUser == null
                ? user.providerData[0].email.toString()
                : otherUser.email),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
