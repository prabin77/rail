import 'package:flutter/material.dart';
import 'package:railway_ticketing/model/reserve.dart';
import 'package:railway_ticketing/services/firebaseservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/schedule.dart';

class ReservedTickets extends StatefulWidget {
  ReservedTickets(this.res);
  Reserve res;

  @override
  _ReservedTicketsState createState() => _ReservedTicketsState();
}

class _ReservedTicketsState extends State<ReservedTickets> {
  String citizenship_number;
  String total_cost;
  String ticket_holder;

  @override
  void initState() {
    super.initState();
    get();
  }

  get() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print('citizenship_number');
    setState(() {
      citizenship_number = prefs.get("citizenship_number");
      ticket_holder = prefs.get('ticket_holder');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text(" Ticket Details"),
      ),
      body: FutureBuilder(
        future: FirebaseService().getscheduleforticket(widget.res.schedule_id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            Schedule t = snapshot.data;

            return ListView(
              padding: const EdgeInsets.all(10.0),
              children: [
                Container(
                  height: 60,
                  width: 400,
                  color: Colors.white,
                  child: Text("Train Name:  ${t.train_name}",
                      style: TextStyle(fontSize: 18)),
                ),
                Container(
                  height: 60,
                  width: 400,
                  color: Colors.white,
                  child: Text("Train Number:  ${t.train_no}",
                      style: TextStyle(fontSize: 18)),
                ),
                Container(
                  height: 60,
                  width: 400,
                  color: Colors.white,
                  child: Text("Departure Date:  ${t.date}",
                      style: TextStyle(fontSize: 18)),
                ),
                Container(
                  height: 60,
                  width: 400,
                  color: Colors.white,
                  child: Text("Departure Time:  ${t.time}",
                      style: TextStyle(fontSize: 18)),
                ),
                Container(
                  height: 60,
                  width: 400,
                  color: Colors.white,
                  child: Text("Citzenship Number:  ${citizenship_number}",
                      style: TextStyle(fontSize: 18)),
                ),
                Container(
                  height: 60,
                  width: 400,
                  color: Colors.white,
                  child:
                      Text("From:  ${t.from}", style: TextStyle(fontSize: 18)),
                ),
                Container(
                  height: 60,
                  width: 400,
                  color: Colors.white,
                  child: Text("To:  ${t.to}", style: TextStyle(fontSize: 18)),
                ),
                Container(
                  height: 60,
                  width: 400,
                  color: Colors.white,
                  child: Text("Ticket Holder:  ${ticket_holder}",
                      style: TextStyle(fontSize: 18)),
                ),
                Container(
                  height: 60,
                  width: 400,
                  color: Colors.white,
                  child: Text("Total Cost: NPR ${widget.res.total_cost} ",
                      style: TextStyle(fontSize: 18)),
                ),
                Container(
                  height: 60,
                  width: 400,
                  color: Colors.white,
                  child: Text("Class: ${widget.res.train_class} ",
                      style: TextStyle(fontSize: 18)),
                ),
                Container(
                  height: 60,
                  width: 400,
                  color: Colors.white,
                  child: Text("No of Tickets: ${widget.res.no_of_tickets} ",
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
