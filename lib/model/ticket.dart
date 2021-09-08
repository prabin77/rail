import 'package:flutter/material.dart';

class Ticket {
  Ticket(
      {@required this.train_class,
      @required this.no_of_tickets,
      @required this.schedule_id,
      @required this.ticket_id,
      @required this.uid,
      @required this.total_cost,
       @required this.ticket_holder,
        @required this.citizenship_number,

      });
 final String train_class;
  final String no_of_tickets;
  final String schedule_id;
  final String ticket_id;
  final String uid;
  final String total_cost;
  final String ticket_holder;
  final String citizenship_number;

  Ticket.fromJson(Map<String, dynamic> jsssson ,String docid)
      : this(
          train_class: jsssson['train_class'] as String,
          no_of_tickets: jsssson['no_of_tickets'] as String,
          schedule_id: jsssson['schedule_id'] as String,
          ticket_id: docid,
          uid: jsssson['uid'] as String,
          total_cost: jsssson['total_cost'] as String,
          ticket_holder: jsssson['ticket_number'] as String,
          citizenship_number: jsssson['citizenship_number'] as String,
         
        );

 
  // Map<String, Object?> toJson() {
  //   return {
  //     'title': title,
  //     'genre': genre,
  //   };
  // }
}
