import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:railway_ticketing/homepage.dart';
import 'package:railway_ticketing/homewall.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, data) {
        
          if (data.connectionState == ConnectionState.active &&
              data.data != null &&
              data.data.uid.isNotEmpty) {
            return HomeWall();
          } else if (data.connectionState == ConnectionState.active &&
                  data.data == null ||
              data.data.uid.isEmpty) {
            return HomePage();
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
