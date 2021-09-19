import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

// screens
import 'screen/home_screen.dart';
import 'screen/login_screen.dart';

// providers
import 'providers/google_sign_in_provider.dart';

// constant
import 'constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task LoginWind',

        home: FutureBuilder(
          future: _fbApp,
          builder: (context, snapShot) {
            if (snapShot.hasError) {
              return const Scaffold(
                body: Center(
                  child: Text('Something Went Wrong'),
                ),
              );
            } else if (snapShot.hasData) {
              // Navigator.pushNamed(context, HomeScreen.route);
              return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, stream) {
                  if (stream.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: circularLoading,
                    );
                  } else if (stream.hasError) {
                    return const Scaffold(
                      body: Center(
                        child: Text('Something Went Wrong'),
                      ),
                    );
                  } else if (stream.hasData) {
                    return const HomeScreen();
                  } else {
                    return LoginScreen();
                  }
                },
              );
              // return HomeScreen();
            } else {
              return const Center(
                child: circularLoading,
              );
            }
          },
        ),
        // initialRoute: LoginScreen.route,
        routes: {
          HomeScreen.route: (ctx) => HomeScreen(),
          LoginScreen.route: (ctx) => LoginScreen(),
        },
      ),
    );
  }
}
