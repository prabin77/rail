import 'package:flutter/material.dart';
import 'package:railway_ticketing/model/user.dart';
import 'package:railway_ticketing/services/firebaseservice.dart';

class MyDetails extends StatefulWidget {
  @override
  _MyDetailsState createState() => _MyDetailsState();
}

class _MyDetailsState extends State<MyDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          "My Details",
        ),
        
      ),
      body: FutureBuilder(
        future: FirebaseService().getUser(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            Users u = snapshot.data;
            return ListView(
              padding: const EdgeInsets.all(10.0),
              children: [
                Container(
                  height: 60,
                  width: 400,
                  color: Colors.white,
                  child: Text("Name:  ${u.full_name}",
                      style: TextStyle(fontSize: 18)),
                ),
                Container(
                  height: 60,
                  width: 400,
                  color: Colors.white,
                  child: Text("Email:  ${u.email}",
                      style: TextStyle(fontSize: 18)),
                ),
                Container(
                  height: 60,
                  width: 400,
                  color: Colors.white,
                  child: Text("Phone Number:  ${u.phone_number}",
                      style: TextStyle(fontSize: 18)),
                ),
                Container(
                  height: 60,
                  width: 400,
                  color: Colors.white,
                  child: Text("Father's Name:  ${u.father_name}",
                      style: TextStyle(fontSize: 18)),
                ),
                Container(
                  height: 60,
                  width: 400,
                  color: Colors.white,
                  child: Text("Citzenship Number:  ${u.citizenship_number}",
                      style: TextStyle(fontSize: 18)),
                ),
                Container(
                  height: 60,
                  width: 400,
                  color: Colors.white,
                  child: Text("Date of Birth:  ${u.date_of_birth}",
                      style: TextStyle(fontSize: 18)),
                ),
                Container(
                  height: 60,
                  width: 400,
                  color: Colors.white,
                  child: Text("Gender:  ${u.gender}",
                      style: TextStyle(fontSize: 18)),
                ),
                Container(
                  height: 60,
                  width: 400,
                  color: Colors.white,
                  child: Text("Address:  ${u.address}",
                      style: TextStyle(fontSize: 18)),
                ),
              ],
            );
          } else {
            return Text("loading");
          }
        },
      ),
    );
  }
}
