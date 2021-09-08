import 'dart:ffi';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:railway_ticketing/phoneveerify.dart';
import 'phoneveerify.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailpw;
  GlobalKey<FormState> _formkeys = GlobalKey<FormState>();

  void initState() {
    super.initState();
    emailpw = TextEditingController();
  }

  @override
  void dispose() {
    emailpw.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Change Password"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkeys,
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 15.0, top: 15, bottom: 10),
                  // padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Enter your email address to reset password",
                    style: TextStyle(fontSize: 18),
                  )),
              Padding(
                // padding: EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 10.0, bottom: 20.0),
                child: TextFormField(
                  controller: emailpw,
                  validator: (value) {
                    if (value.isEmpty) {
                      return ("invalid email");
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email Address',
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    (_formkeys.currentState.validate());
                    FirebaseAuth.instance
                        .sendPasswordResetEmail(email: emailpw.text)
                        .then((value) => ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                                backgroundColor: Colors.green,
                                content: Text("Sent Successfully"))));
                  },
                  child: Text(
                    'Send',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
