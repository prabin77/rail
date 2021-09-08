import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:railway_ticketing/model/reserve.dart';
import 'package:railway_ticketing/model/schedule.dart';
import 'package:railway_ticketing/model/ticket.dart';
import 'dart:async';

import 'package:railway_ticketing/model/user.dart';

class FirebaseService {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference schedule =
      FirebaseFirestore.instance.collection('schedule');
  CollectionReference tickets =
      FirebaseFirestore.instance.collection('tickets');
  CollectionReference reserves =
      FirebaseFirestore.instance.collection('reserves');

  Future<bool> updateTrains(String docid, String classname, int booked,
      int empty, int total, int total_cost) {
    return schedule
        .doc(docid)
        .update({
          classname: {
            'booked_seats': booked,
            'empty_seats': empty,
            'total_seats': total,
            'price': total_cost
          }
        })
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<Schedule> getscheduleforticket(
    String docid,
  ) {
    return schedule
        .doc(docid)
        .get()
        .then((d) => Schedule.fromJson(d.data(), docid))
        .catchError((error) => false);
  }

  Future<Users> getUser() {
    // Call the user's CollectionReference to add a new user
    String uid = FirebaseAuth.instance.currentUser.uid;
    return users.where('uid', isEqualTo: uid).get().then((value) {
      return Users.fromJson(value.docs[0].data());
    }).catchError((error) => print("Failed to get user: $error"));
  }

  Future<List<Ticket>> getTicket() {
    // Call the user's CollectionReference to add a new user
    String uid = FirebaseAuth.instance.currentUser.uid;
    return tickets.where('uid', isEqualTo: uid).get().then((value) {
      return value.docs
          .map((e) => Ticket.fromJson(e.data(), e.reference.id))
          .toList();
    }).catchError((error) => print("Failed to get user: $error"));
  }

  Future<List<Reserve>> getReserve() {
    // Call the user's CollectionReference to add a new user
    String uid = FirebaseAuth.instance.currentUser.uid;
    return tickets.where('uid', isEqualTo: uid).get().then((value) {
      return value.docs
          .map((e) => Reserve.fromJson(e.data(), e.reference.id))
          .toList();
    }).catchError((error) => print("Failed to get user: $error"));
  }

  Future<List<Schedule>> getSchedule() {
    return schedule
        //  .where('date', isEqualTo: DateTime.now().toString().split(' ')[0])
        .get()
        .then((value) {
      print(value);
      var e = value.docs
          .map((e) => Schedule.fromJson(e.data(), e.reference.id))
          .toList();
      print('er');
      print(e);
      print(e[0]);
      return e;
    });
  }

  Future<List<Schedule>> searchtrain({
    String to,
    String from,
    String date,
  }) async {
    print(to + from);
    List<Schedule> s =
        await schedule.where('date', isEqualTo: date).get().then((value) {
      return value.docs
          .map((e) => Schedule.fromJson(e.data(), e.reference.id))
          .toList();
    });
    List<Schedule> e =
        s.where((element) => element.from == from && element.to == to).toList();
    print(e.toString());
    return e;
  }

  Future<void> addticket({
    String train_class,
    String no_of_tickets,
    String schedule_id,
    String ticket_id,
    String ticket_holder,
    String citizenship_number,
    String total_cost,
  }) {
    // Call the user's CollectionReference to add a new user

    String uid = FirebaseAuth.instance.currentUser.uid;
    return tickets
        .add({
          'uid': uid,
          'train_class': train_class,
          'no_of_tickets': no_of_tickets,
          'schedule_id': schedule_id,
          'ticket_id': ticket_id,
          'ticket_holder': ticket_holder,
          'citizenship_number': citizenship_number,
          'total_cost': total_cost,
        })
        .then((value) => print("ticket booked"))
        .catchError((error) => print("Failed to book ticket: $error"));
  }

  Future<void> addreserve(
      {String train_class,
      String no_of_tickets,
      String schedule_id,
      String ticket_id,
      String ticket_holder,
      String citizenship_number,
      String total_cost,
      }) {
    // Call the user's CollectionReference to add a new user

    String uid = FirebaseAuth.instance.currentUser.uid;
    return reserves
        .add({
          'uid': uid,
          'train_class': train_class,
          'no_of_tickets': no_of_tickets,
          'schedule_id': schedule_id,
          'ticket_id': ticket_id,
          'ticket_holder': ticket_holder,
          'citizenship_number': citizenship_number,
          'total_cost': total_cost,
          
        })
        .then((value) => print("ticket reserved"))
        .catchError((error) => print("Failed to book ticket: $error"));
  }

  Future<void> addUser(
      {String fullName,
      String fatherName,
      String phoneNumber,
      String dateOfBirth,
      String citizenNo,
      String address,
      String email,
      String gender}) {
    // Call the user's CollectionReference to add a new user

    String uid = FirebaseAuth.instance.currentUser.uid;
    return users
        .add({
          'uid': uid,
          'full_name': fullName,
          'father_name': fatherName,
          'phone_number': phoneNumber,
          'date_of_birth': dateOfBirth,
          'citizenship_number': citizenNo,
          'address': address,
          'email': email,
          'gender': gender,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<bool> signinano() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    if (userCredential.user.isAnonymous) {
      return true;
    }
    return false;
  }

  Future<bool> signin({String email, String pass}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      if (userCredential.user != null) {
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return false;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return false;
      }
      return false;
    }
  }

  Future<bool> signup({String email, String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
