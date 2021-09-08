import 'package:flutter/material.dart';
import 'package:railway_ticketing/notificationsettings.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              // padding: EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 8.0, bottom: 0),
              child: Container(
                height: 70,
                width: 400,
                decoration: BoxDecoration(color: Colors.green),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Colors.green;
                          return null; // Use the component's default.
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NotificationSettings()));
                    },
                    child: Text(
                      'App Notification',
                      style: TextStyle(fontSize: 20),
                    )),
              ),
            ),
            Padding(
              //padding: EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 8.0, bottom: 0),
              child: Container(
                height: 70,
                width: 400,
                decoration: BoxDecoration(color: Colors.black),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Colors.green;
                          return null;
                        },
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Check for Update',
                      style: TextStyle(fontSize: 20),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
