import 'package:flutter/material.dart';
import 'package:railway_ticketing/model/schedule.dart';
import 'package:railway_ticketing/model/ticket.dart';
import 'package:railway_ticketing/services/firebaseservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicketsDetails extends StatefulWidget {
  TicketsDetails(this.tic);
  Ticket tic;

  @override
  _TicketsDetailsState createState() => _TicketsDetailsState();
}

class _TicketsDetailsState extends State<TicketsDetails> {
  String citizenship_number;

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
        title: Text("Ticket Details"),
      ),
      body: FutureBuilder(
        future: FirebaseService().getscheduleforticket(widget.tic.schedule_id),
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
                  child: Text("class:  ${widget.tic.train_class}",
                      style: TextStyle(fontSize: 18)),
                ),
                Container(
                  height: 60,
                  width: 400,
                  color: Colors.white,
                  child: Text("No of Tickets:  ${widget.tic.no_of_tickets}",
                      style: TextStyle(fontSize: 18)),
                ),
                Container(
                  height: 60,
                  width: 400,
                  color: Colors.white,
                  child: Text("Total Cost:NPR ${widget.tic.total_cost}",
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
