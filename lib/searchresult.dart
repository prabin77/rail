import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:railway_ticketing/model/schedule.dart';
import 'package:railway_ticketing/model/user.dart';
import 'package:railway_ticketing/payment.dart';
import 'package:railway_ticketing/services/firebaseservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchResult extends StatefulWidget {
  SearchResult({this.sc, this.u});
  @override
  _SearchResultState createState() => _SearchResultState();

  final Schedule sc;
  Users u;
}

class _SearchResultState extends State<SearchResult> {
  TextEditingController noofseats;
  int seatprice = 0;

  String valueChoose;
  List listItems = [
    '1A AC First Class',
    '2A AC 2-Tier',
    '3A AC 3-Tier',
    'FC First class',
  ];
  String citizenship_number;
  String ticket_holder;
  @override
  // ignore: missing_return
  Void initState() {
    super.initState();
    noofseats = TextEditingController(text: "0");
    get();
  }

  @override
  void dispose() {
    noofseats.dispose();
    super.dispose();
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
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text('Available Trains'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 1.0, right: 1.0, top: 1.0, bottom: 2.0),
            child: Container(
              height: 50,
              width: 390,
              alignment: Alignment.centerLeft,
              child: Text(
                "Train Name : ${widget.sc.train_name} ",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 1.0, right: 1.0, top: 1.0, bottom: 2.0),
            child: Container(
              height: 50,
              width: 390,
              alignment: Alignment.centerLeft,
              child: Text(
                "Train No : ${widget.sc.train_no}",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 1.0, right: 1.0, top: 1.0, bottom: 2.0),
            child: Container(
              height: 50,
              width: 390,
              alignment: Alignment.centerLeft,
              child: Text(
                "From :  ${widget.sc.from}",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 1.0, right: 1.0, top: 1.0, bottom: 2.0),
            child: Container(
              height: 50,
              width: 390,
              alignment: Alignment.centerLeft,
              child: Text(
                "To :  ${widget.sc.to}",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 1.0, right: 1.0, top: 1.0, bottom: 1.0),
            child: Container(
              height: 50,
              width: 390,
              alignment: Alignment.centerLeft,
              child: Text(
                "Time :  ${widget.sc.time}",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 1.0, right: 1.0, top: 1.0, bottom: 0),
            child: Container(
              height: 50,
              width: 390,
              alignment: Alignment.centerLeft,
              child: Text(
                "Date :  ${widget.sc.date}",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 0, right: 0, top: 1.0, bottom: 1.0),
                child: Container(
                  height: 50,
                  width: 130,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '  No of Seats :',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: .0, right: .0, top: 1.0, bottom: 1.0),
                child: Container(
                  height: 50,
                  width: 200,
                  child: TextFormField(
                    controller: noofseats,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'No of Seats'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 1.0, right: 1.0, top: 1.0, bottom: 1.0),
            child: Container(
              height: 50,
              width: 390,
              alignment: Alignment.centerLeft,
              child: Text(
                "Total Cost:${seatprice * int.parse(noofseats.text)}",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 1.0, right: 1.0, top: 0, bottom: 1.0),
            child: Container(
              height: 50,
              width: 390,
              child: DropdownButtonFormField(
                hint: Text('Class'),
                dropdownColor: Colors.grey,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 36,
                isExpanded: true,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
                value: valueChoose,
                onChanged: (newValue) {
                  setState(() {
                    if (newValue == '1A AC First Class') {
                      seatprice = widget.sc.ac_first_class.price;
                    } else if (newValue == '2A AC 2-Tier') {
                      seatprice = widget.sc.ac_2_tier.price;
                    } else if (newValue == '3A AC 3-Tier') {
                      seatprice = widget.sc.ac_3_tier.price;
                    } else if (newValue == 'FC First Class') {
                      seatprice = widget.sc.first_class.price;
                    } else {
                      return null;
                    }

                    valueChoose = newValue;
                  });
                },
                items: listItems.map((valueItem) {
                  return DropdownMenuItem(
                      value: valueItem, child: Text(valueItem));
                }).toList(),
              ),
            ),
          ),
          Row(children: [
            Padding(
              padding: const EdgeInsets.only(left: 70),
              child: Container(
                height: 88,
                width: 130,
                color: Colors.blue,
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
                    print(widget.sc.first_class.empty_seats);
                    print("object");
                    if (valueChoose == '1A AC First Class') {
                      widget.sc.ac_first_class.empty_seats >
                              int.parse(noofseats.text)
                          ? FirebaseService()
                              .updateTrains(
                                  widget.sc.document_id,
                                  valueChoose,
                                  widget.sc.ac_first_class.booked_seats +
                                      int.parse(noofseats.text),
                                  widget.sc.ac_first_class.empty_seats -
                                      int.parse(noofseats.text),
                                  widget.sc.ac_first_class.total_seats,
                                  widget.sc.ac_first_class.price)
                              .then((value) {
                              if (value) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Khaltipay(
                                          noofseats: noofseats.text,
                                          schedule_id: widget.sc.document_id,
                                          value: this.valueChoose,
                                          total_cost: seatprice *
                                              int.parse(noofseats.text),
                                        )));
                              }
                            })
                          : ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("not available")));
                    }
                    if (valueChoose == '2A AC 2-Tier') {
                      widget.sc.ac_2_tier.empty_seats >
                              int.parse(noofseats.text)
                          ? FirebaseService()
                              .updateTrains(
                                  widget.sc.document_id,
                                  valueChoose,
                                  widget.sc.ac_2_tier.booked_seats +
                                      int.parse(noofseats.text),
                                  widget.sc.ac_2_tier.empty_seats -
                                      int.parse(noofseats.text),
                                  widget.sc.ac_2_tier.total_seats,
                                  widget.sc.ac_2_tier.price)
                              .then((value) {
                              if (true) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Khaltipay(
                                        noofseats: noofseats.text,
                                        schedule_id: widget.sc.document_id,
                                        total_cost: seatprice *
                                            int.parse(noofseats.text),
                                        value: this.valueChoose)));
                              }
                            })
                          : ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("not available")));
                    }
                    if (valueChoose == '3A AC 3-Tier') {
                      widget.sc.ac_3_tier.empty_seats >
                              int.parse(noofseats.text)
                          ? FirebaseService()
                              .updateTrains(
                                  widget.sc.document_id,
                                  valueChoose,
                                  widget.sc.ac_3_tier.booked_seats +
                                      int.parse(noofseats.text),
                                  widget.sc.ac_3_tier.empty_seats -
                                      int.parse(noofseats.text),
                                  widget.sc.ac_3_tier.total_seats,
                                  widget.sc.ac_3_tier.price)
                              .then((value) {
                              if (true) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Khaltipay(
                                        noofseats: noofseats.text,
                                        schedule_id: widget.sc.document_id,
                                        total_cost: seatprice *
                                            int.parse(noofseats.text),
                                        value: this.valueChoose)));
                              }
                            })
                          : ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("not available")));
                    }
                    if (valueChoose == 'FC First class') {
                      widget.sc.first_class.empty_seats >
                              int.parse(noofseats.text)
                          ? FirebaseService()
                              .updateTrains(
                                  widget.sc.document_id,
                                  valueChoose,
                                  widget.sc.first_class.booked_seats +
                                      int.parse(noofseats.text),
                                  widget.sc.first_class.empty_seats -
                                      int.parse(noofseats.text),
                                  widget.sc.first_class.total_seats,
                                  widget.sc.first_class.price)
                              .then((value) {
                              if (true) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Khaltipay(
                                        noofseats: noofseats.text,
                                        schedule_id: widget.sc.document_id,
                                        total_cost: seatprice *
                                            int.parse(noofseats.text),
                                        value: this.valueChoose)));
                              }
                            })
                          : ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("not available")));
                    }
                  },
                  child: Text('Buy Ticket'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 88,
                width: 130,
                color: Colors.blue,
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
                    print(widget.sc.first_class.empty_seats);
                    if (valueChoose == '1A AC First Class') {
                      widget.sc.ac_first_class.empty_seats >
                              int.parse(noofseats.text)
                          ? FirebaseService()
                              .updateTrains(
                                  widget.sc.document_id,
                                  valueChoose,
                                  widget.sc.ac_first_class.booked_seats +
                                      int.parse(noofseats.text),
                                  widget.sc.ac_first_class.empty_seats -
                                      int.parse(noofseats.text),
                                  widget.sc.ac_first_class.total_seats,
                                  widget.sc.ac_first_class.price)
                              .then((value) {
                              if (true) {
                                showAlertDialog(context);
                              }
                            })
                          : ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("not available")));
                    }
                    if (valueChoose == '2A AC 2-Tier') {
                      widget.sc.ac_2_tier.empty_seats >
                              int.parse(noofseats.text)
                          ? FirebaseService()
                              .updateTrains(
                                  widget.sc.document_id,
                                  valueChoose,
                                  widget.sc.ac_2_tier.booked_seats +
                                      int.parse(noofseats.text),
                                  widget.sc.ac_2_tier.empty_seats -
                                      int.parse(noofseats.text),
                                  widget.sc.ac_2_tier.total_seats,
                                  widget.sc.ac_2_tier.price)
                              .then((value) {
                              if (true) {
                                showAlertDialog(context);
                              }
                            })
                          : ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("not available")));
                    }
                    if (valueChoose == '3A AC 3-Tier') {
                      widget.sc.ac_3_tier.empty_seats >
                              int.parse(noofseats.text)
                          ? FirebaseService()
                              .updateTrains(
                                  widget.sc.document_id,
                                  valueChoose,
                                  widget.sc.ac_3_tier.booked_seats +
                                      int.parse(noofseats.text),
                                  widget.sc.ac_3_tier.empty_seats -
                                      int.parse(noofseats.text),
                                  widget.sc.ac_3_tier.total_seats,
                                  widget.sc.ac_3_tier.price)
                              .then((value) {
                              if (true) {
                                showAlertDialog(context);
                              }
                            })
                          : ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("not available")));
                    }
                    if (valueChoose == 'FC First class') {
                      widget.sc.first_class.empty_seats >
                              int.parse(noofseats.text)
                          ? FirebaseService()
                              .updateTrains(
                                  widget.sc.document_id,
                                  valueChoose,
                                  widget.sc.first_class.booked_seats +
                                      int.parse(noofseats.text),
                                  widget.sc.first_class.empty_seats -
                                      int.parse(noofseats.text),
                                  widget.sc.first_class.total_seats,
                                  widget.sc.first_class.price)
                              .then((value) {
                              if (true) {
                                showAlertDialog(context);
                              }
                            })
                          : ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("not available")));
                    }
                  },
                  child: Text('Reserve Ticket'),
                ),
              ),
            ),
          ]),
        ],
      )),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {
        FirebaseService()
            .addreserve(
                no_of_tickets: noofseats.text,
                schedule_id: widget.sc.document_id,
                train_class: valueChoose,
                citizenship_number: citizenship_number,
                total_cost: (seatprice * int.parse(noofseats.text)).toString(),
                ticket_holder: ticket_holder)
            .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    backgroundColor: Colors.green,
                    content: Text("Reserved Successfully"))));
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Reserve Ticket"),
      content: Text("Would you like to reserve the ticket?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
