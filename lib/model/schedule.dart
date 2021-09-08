import 'package:flutter/material.dart';

class Schedule {
  Schedule(
      {@required this.train_name,
      @required this.time,
      @required this.from,
      @required this.date,
      @required this.to,
      @required this.document_id,
      @required this.train_no,
      this.first_class,
      this.ac_first_class,
      this.ac_2_tier,
      this.ac_3_tier});

  final String train_name;
  final String time;
  final String from;
  final String date;
  final String to;
  final String train_no;
  final String document_id;
  final SeatInfo first_class;
  final SeatInfo ac_first_class;
  final SeatInfo ac_2_tier;
  final SeatInfo ac_3_tier;
  @override
  String toString() {
    return "${this.train_name},${this.from},${this.to}";
  }

  factory Schedule.fromJson(Map<String, dynamic> json, String did) {
    print(json);
    print(did);
    Schedule s = Schedule(
        train_name: json['train_name'],
        time: json['time'],
        from: json['from'],
        date: json['date'],
        to: json['to'],
        first_class: SeatInfo.fromJson(json['FC First class']),
        ac_first_class: SeatInfo.fromJson(json['1A AC First Class']),
        ac_2_tier: SeatInfo.fromJson(json['2A AC 2-Tier']),
        ac_3_tier: SeatInfo.fromJson(json['3A AC 3-Tier']),
        train_no: json['train_no'],
        document_id: did);
    print(s);
    return s;
  }
}

class SeatInfo {
  int total_seats;
  int empty_seats;
  int booked_seats;
  int price;
  SeatInfo({this.booked_seats, this.empty_seats, this.total_seats, this.price});
  factory SeatInfo.fromJson(Map<String, dynamic> json) {
    print(json);
    SeatInfo s = SeatInfo(
        total_seats: json['total_seats'],
        booked_seats: json['booked_seats'],
        empty_seats: json['empty_seats'],
        price: json['price']);
    print(s);
    return s;
  }
}
