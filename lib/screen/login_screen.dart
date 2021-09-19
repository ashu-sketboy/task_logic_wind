import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_login_wing/providers/google_sign_in_provider.dart';

// import 'package:trivia/providers/google_sign_in_provider.dart';

import 'package:task_login_wing/constant.dart';

class LoginScreen extends StatelessWidget {
  static const String route = '/login_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer(
          builder: (context, GoogleSignInProvider gp, child) {
            return SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  child!,
                  if (gp.status == Status.Loading) circularLoading,
                  if (gp.status != Status.Loading)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(36, 59, 124, 1),
                        onPrimary: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () {
                        Provider.of<GoogleSignInProvider>(context,
                                listen: false)
                            .googleLogIn();
                      },
                      child: const Text('Sign With Google'),
                    ),
                ],
              ),
            );
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
