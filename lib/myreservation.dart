import 'package:flutter/material.dart';
import 'package:railway_ticketing/model/reserve.dart';
import 'package:railway_ticketing/services/firebaseservice.dart';
import 'reservedticket.dart';

class MyReservation extends StatefulWidget {
  @override
  _MyReservationState createState() => _MyReservationState();
}

class _MyReservationState extends State<MyReservation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text("Reserved Tickets"),
      ),
      body: FutureBuilder(
        future: FirebaseService().getReserve(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            List<Reserve> r = snapshot.data;
            // Users u = snapshot.data;
            return _builtListView(r);
          } else {
            return Text("data");
          }
        },
      ),
    );
  }

  ListView _builtListView(List<Reserve> r) {
    return ListView.builder(
        itemCount: r.length,
        itemBuilder: (context, op) {
          return ListTile(
            title: Text(r[op].ticket_id),
            subtitle: Text(r[op].train_class),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ReservedTickets(r[op])));
            },
          );
        });
  }
}
