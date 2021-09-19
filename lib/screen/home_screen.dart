import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import 'package:task_login_wing/providers/google_sign_in_provider.dart';

// Screens
import 'profile_screen.dart';

import 'package:task_login_wing/widget/user_list.dart';

// services
import 'package:task_login_wing/services/user_data_service.dart';

// model
import 'package:task_login_wing/model/user.dart';

import 'package:task_login_wing/constant.dart';

class HomeScreen extends StatelessWidget {
  static const String route = '/home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget _drawer = Drawer(
      child: Column(
        children: [
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (context) => ProfileScreen()),
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              height: 50,
              width: double.infinity,
              alignment: Alignment.centerLeft,
              color: const Color.fromRGBO(224, 230, 241, 1),
              child: const Text('My Profile'),
            ),
          ),
        ],
      ),
    );

    final _appBar = AppBar(
      backgroundColor: const Color.fromRGBO(36, 59, 124, 1),
      title: const Text('Task'),
      actions: [
        TextButton(
          onPressed: () {
            Provider.of<GoogleSignInProvider>(context, listen: false)
                .googleLogOut();
          },
          child: const Text(
            'Log Out',
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );

    return SafeArea(
      child: StreamProvider<List<User>?>.value(
        initialData: [],
        value: UserDataService().users,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: _appBar,
            body: Consumer(
              builder: (context, GoogleSignInProvider model, _) {
                if (model.status == Status.Loading) {
                  return circularLoading;
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: UserList(),
                  );
                }
              },
            ),
            drawer: _drawer,
          );
        },
      ),
    );
  }
}
