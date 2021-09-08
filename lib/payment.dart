import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_khalti/flutter_khalti.dart';
import 'package:railway_ticketing/services/firebaseservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Khaltipay extends StatefulWidget {
  Khaltipay({
    this.noofseats,
    this.value,
    this.schedule_id,
    this.total_cost,
  });

  @override
  _KhaltipayState createState() => _KhaltipayState();
  String noofseats;
  String value;
  String schedule_id;
  int total_cost;
}

class _KhaltipayState extends State<Khaltipay> {
  FlutterKhalti _flutterKhalti = FlutterKhalti.configure(
      publicKey: "test_public_key_eacadfb91994475d8bebfa577b0bca68",
      urlSchemeIOS: "KhaltiPayFlutterExampleScheme",
      paymentPreferences: [KhaltiPaymentPreference.KHALTI]);
  String citizenship_number;
  String ticket_holder;
  String _token;
  @override
  void initState() {
    super.initState();
    print(double.parse(widget.total_cost.toString()));
    get();
  }

  get() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('citizenship_number');
    setState(() {
      citizenship_number = prefs.getString("citizenship_number");
      ticket_holder = prefs.getString('ticket_holder');
      _token = prefs.getString("fcm");
    });
  }

  KhaltiProduct product() => KhaltiProduct(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        amount: double.parse(widget.total_cost.toString()) * 100,
        name: widget.schedule_id + widget.value,
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: new Text(
            "Pay by Khalti",
            style: TextStyle(fontSize: 20),
          ),
          onPressed: () {
            _flutterKhalti.startPayment(
              product: product(),
              onSuccess: (data) {},
              onFaliure: (error) {
                print("Error message here");

                FirebaseService()
                    .addticket(
                        no_of_tickets: widget.noofseats,
                        schedule_id: widget.schedule_id,
                        train_class: widget.value,
                        citizenship_number: citizenship_number,
                        ticket_holder: ticket_holder,
                        total_cost: widget.total_cost.toString())
                    .then((value) {
                  sendPushMessage();
                });
                return true;
              },
            );
          },
        ),
      ),
    );
  }

  String constructFCMPayload(String token) {
    return jsonEncode({
      'token': token,
      'data': {
        'via': 'FlutterFire Cloud Messaging!!!',
      },
      'notification': {
        'title': 'Hello FlutterFire!',
        'body': 'This notification  was created via FCM!',
      },
    });
  }

  Future<void> sendPushMessage() async {
    if (_token == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }

    try {
      await http.post(
        Uri.parse('https://api.rnfirebase.io/messaging/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: constructFCMPayload(_token),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }
}
