import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Notifications'),
          centerTitle: true,
          backgroundColor: Colors.green),
      body: _builtListView(),
    );
  }

  ListView _builtListView() {
    return ListView.builder(
        itemCount: 15,
        itemBuilder: (_, index) {
          return ListTile(
            title: Text("Notification #$index"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              //   Navigator.of(context).push(MaterialPageRoute(
              //       builder: (context) => ReservedTickets(index)));
            },
          );
        });
  }
}
