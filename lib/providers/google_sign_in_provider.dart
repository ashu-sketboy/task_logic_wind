import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:task_login_wing/constant.dart';

import 'package:task_login_wing/services/user_data_service.dart';

class GoogleSignInProvider with ChangeNotifier {
  Status? status;
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogIn() async {
    status = Status.Loading;
    notifyListeners();

    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      status = Status.Error;
      return;
    }

    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    await UserDataService().addUserData(
        uid: googleUser.id,
        emailId: googleUser.email,
        image: googleUser.photoUrl!,
        name: googleUser.displayName!);
    status = Status.Success;
    notifyListeners();
  }

  Future googleLogOut() async {
    status = Status.Loading;
    notifyListeners();
    await googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
    status = Status.Success;
  }
}
