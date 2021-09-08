import 'package:flutter/material.dart';
import 'package:railway_ticketing/services/firebaseservice.dart';

import 'model/schedule.dart';
import 'model/user.dart';
import 'searchresult.dart';

class BookTicket extends StatefulWidget {
  BookTicket({this.u});
  @override
  _BookTicketState createState() => _BookTicketState();
  Users u;
}

class _BookTicketState extends State<BookTicket> {
  String valueChoose;
  String valueChoose1;
  final date = TextEditingController();
  List<Schedule> se = [];
  List listItems = [
    'Inarwa',
    'Khajuri',
    'Mahinathpur',
    'Sahib Sarojnagar, Duhabi',
    'Baidehi, Itaharwa',
    'Deuri Parbaha',
    'Janakpur',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Book Tickets"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0)),
                child: DropdownButtonFormField(
                  hint: Text('From'),
                  dropdownColor: Colors.grey,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 36,
                  isExpanded: true,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                  value: valueChoose,
                  onChanged: (newValue) {
                    setState(() {
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0)),
                child: DropdownButtonFormField(
                  hint: Text('TO'),
                  dropdownColor: Colors.grey,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 36,
                  isExpanded: true,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                  value: valueChoose1,
                  onChanged: (newValue) {
                    setState(() {
                      valueChoose1 = newValue;
                    });
                  },
                  items: listItems.map((valueItem) {
                    return DropdownMenuItem(
                        value: valueItem, child: Text(valueItem));
                  }).toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: date,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'YY-MM-DD',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () async {
                        String s = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2025))
                            .then((value) => value.toString().split(" ")[0]);

                        print(s);
                        setState(() {
                          date.text = s;
                        });
                      },
                    )),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  List<Schedule> found = await FirebaseService().searchtrain(
                      from: valueChoose, to: valueChoose1, date: date.text);
                  setState(() {
                    se = found;
                  });
                },
                child: Text(
                  'Search Train',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 3.0, right: 3.0, top: 20.0, bottom: 0.0),
                  child: Container(
                    height: 50,
                    width: 390,
                    color: Colors.blue,
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Available Trains",
                        style: TextStyle(fontSize: 30.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 480,
                  child: ListView.builder(
                    itemCount: se.length,
                    itemBuilder: (context, index) => Card(
                      child: ListTile(
                        leading: Icon(Icons.schedule),
                        title: Text(
                            '${se[index].train_name} , ${se[index].from} --> ${se[index].to}'),
                        subtitle: Text(
                            '${se[index].time} ,  ${se[index].date} ,  ${se[index].train_no} '),
                        onTap: () {
                          print(se[index].document_id);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SearchResult(
                                    sc: se[index],
                                  )));
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
