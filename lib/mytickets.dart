import 'package:flutter/material.dart';
import 'package:railway_ticketing/services/firebaseservice.dart';
import 'model/ticket.dart';
import 'ticketsdetails.dart';

class MyTickets extends StatefulWidget {
  @override
  _MyTicketsState createState() => _MyTicketsState();
}

class _MyTicketsState extends State<MyTickets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text("My Tickets"),
      ),
      // body: _builtListView(),
      body: FutureBuilder(
        future: FirebaseService().getTicket(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            List<Ticket> t = snapshot.data;
            // Users u = snapshot.data;
            return _builtListView(t);
          } else {
            return Text("data");
          }
        },
      ),
    );
  }

  ListView _builtListView(List<Ticket> t) {
    return ListView.builder(
        itemCount: t.length,
        itemBuilder: (context, op) {
          return ListTile(
            title: Text(t[op].ticket_id),
            subtitle: Text(t[op].train_class),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TicketsDetails(t[op])));
            },
          );
        });
  }
}
