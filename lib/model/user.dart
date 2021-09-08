import 'package:flutter/material.dart';

class Users {
  Users(
      {@required this.full_name,
      @required this.email,
      @required this.phone_number,
      @required this.date_of_birth,
      @required this.father_name,
      @required this.citizenship_number,
      @required this.gender,
      @required this.address});

  Users.fromJson(Map<String, dynamic> jsssson)
      : this(
          full_name: jsssson['full_name'] as String,
          email: jsssson['email'] as String,
          phone_number: jsssson['phone_number'] as String,
          date_of_birth: jsssson['date_of_birth'] as String,
          father_name: jsssson['father_name'] as String,
          citizenship_number: jsssson['citizenship_number'] as String,
          address: jsssson['address'] as String,
          gender: jsssson['gender'] as String,
        );

  final String full_name;
  final String email;
  final String phone_number;
  final String date_of_birth;
  final String father_name;
  final String citizenship_number;
  final String address;
  final String gender;

  // Map<String, Object?> toJson() {
  //   return {
  //     'title': title,
  //     'genre': genre,
  //   };
  // }
}
