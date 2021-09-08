import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:railway_ticketing/homepage.dart';
import 'package:railway_ticketing/main.dart';
import 'package:railway_ticketing/mapsample.dart';
import 'package:railway_ticketing/model/schedule.dart';
import 'package:railway_ticketing/searchresult.dart';
import 'package:railway_ticketing/services/firebaseservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bookticket.dart';
import 'notifcation.dart';
import 'passwordchange.dart';
import 'settings.dart';
import 'mydetails.dart';
import 'myreservation.dart';
import 'mytickets.dart';

class HomeWall extends StatefulWidget {
  @override
  _HomeWallState createState() => _HomeWallState();
}

class _HomeWallState extends State<HomeWall> {
 
  Widget cusSearchBar = Text('Home');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      print("objectkjhgfghj");
      if (message != null) {
        // Navigator.pushNamed(context, '/message',
        //     arguments: MessageArguments(message, true));
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'logo.png',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // Navigator.pushNamed(context, '/message',
      //     arguments: MessageArguments(message, true));
    });

    save();
  }

  save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // var token = await FirebaseMessaging.instance.getToken();

    FirebaseService().getUser().then((value) {
      if (value != null) {
        prefs.setString('citizenship_number', value.citizenship_number);
        prefs.setString('ticket_holder', value.full_name);
        prefs.setString('fcm', "token");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home'),
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NotificationPage()));
              }),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.notes),
                  title: Text('My Details'),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MyDetails()));
                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.event_seat),
                title: Text('My Reservation'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MyReservation()));
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.book_online),
                title: Text('My Ticket'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MyTickets()));
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.lock),
                title: Text('Change Password'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PasswordChange()));
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Settings()));
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.help_outline),
                title: Text('Help'),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () async {
                  await FirebaseAuth.instance.signOut().then((value) =>
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => HomePage()),
                          (route) => false));
                },
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 0, right: 5.0, top: 10.0, bottom: 0),
                child: Container(
                  height: 100,
                  width: 190,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
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
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BookTicket()));
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.book_online),
                        Text(
                          'Book tickets',
                          style: TextStyle(fontSize: 20.0),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 2.0, right: 0, top: 10.0, bottom: 0),
                child: Container(
                  height: 100,
                  width: 195,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
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
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => MapSample()));
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.map),
                        Text(
                          'Find Stations',
                          style: TextStyle(fontSize: 20.0),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 2.0, right: 2.0, top: 10.0, bottom: 0.0),
                child: Container(
                  height: 50,
                  width: 390,
                  color: Colors.blue,
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Today's Schedule",
                      style: TextStyle(fontSize: 30.0, color: Colors.white),
                    ),
                  ),
                ),
              ),
              FutureBuilder(
                future: FirebaseService().getSchedule(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print(snapshot.data);
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    List<Schedule> s = snapshot.data;
                    return Container(
                      height: 480,
                      child: ListView.builder(
                        itemCount: s.length,
                        itemBuilder: (context, index) => Card(
                          child: ListTile(
                            leading: Icon(Icons.schedule),
                            title: Text(
                                '${s[index].train_name} , ${s[index].from} --> ${s[index].to}'),
                            subtitle: Text(
                                '${s[index].time} ,  ${s[index].date} ,  ${s[index].train_no} '),
                            onTap: () {
                              print(s[index].document_id);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SearchResult(
                                        sc: s[index],
                                      )));
                            },
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Text("loading");
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
