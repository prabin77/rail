import 'dart:ffi';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:railway_ticketing/homepage.dart';
import 'package:railway_ticketing/services/firebaseservice.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

bool _secureText = true;

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController passwordController;
  TextEditingController emailController;
  TextEditingController fullc;
  TextEditingController fatherna;
  TextEditingController phonenumber;
  TextEditingController dateofbirth;
  TextEditingController citizenno;
  TextEditingController address;

  String valueChoose;
  List listItem = [
    'Male',
    'Female',
    'Other',
  ];

  @override
  // ignore: missing_return
  Void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    fullc = TextEditingController();
    fatherna = TextEditingController();
    phonenumber = TextEditingController();
    dateofbirth = TextEditingController();

    citizenno = TextEditingController();
    address = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fullc.dispose();
    fatherna.dispose();
    phonenumber.dispose();
    dateofbirth.dispose();
    citizenno.dispose();

    address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sign up"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              Padding(
                  // padding: EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 10.0, bottom: 0),
                  child: TextFormField(
                    controller: fullc,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a valid name' ;
                      } else {
                        return  null;
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Full Name',
                    ),
                  )),
              Padding(
                  // padding: EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 10.0, bottom: 0),
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (!value.contains('@')) {
                        return "Enter Valid Email";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  )),
              Padding(
                // padding: EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 10.0, bottom: 0),
                child: TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value.length < 8) {
                      return ('password must be more then 8 characters');
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        onPressed: () {
                          setState(() {
                            _secureText = !_secureText;
                          });
                        },
                      )),
                  obscureText: _secureText,
                ),
              ),
              Padding(
                // padding: EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 10.0, bottom: 0.0),
                child: TextFormField(
                  controller: phonenumber,
                  validator: (value) {
                    if (value.isEmpty) {
                      return ("invalid phone number");
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: CountryCodePicker(
                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                      initialSelection: '+977',
                      favorite: ['+977', 'NE'],
                      textStyle: TextStyle(color: Colors.black),
                      showFlag: false,

                      //showFlagDialog: true,
                      //comparator: (a, b) => b.name.compareTo(a.name),
                      //Get the country information relevant to the initial selection
                      //onInit: (code) => print("${code.name} ${code.dialCode}"),
                    ),
                    labelText: 'Phone Number',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              Padding(
                // padding: EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 10.0, bottom: 0.0),
                child: TextFormField(
                  controller: dateofbirth,
                  validator: (value) {
                    if (value.isEmpty) {
                      return ("invalid date of birth");
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Date of Birth',
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
                            dateofbirth.text = s;
                          });
                        },
                      )),
                ),
              ),
              Padding(
                // padding: EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 10.0, bottom: 0.0),
                child: TextFormField(
                  controller: citizenno,
                  validator: (value) {
                    if (value.isEmpty) {
                      return ("invalid citizenship number");
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Citizenship Number',
                  ),
                ),
              ),
              Padding(
                // padding: EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 10.0, bottom: 0.0),
                child: TextFormField(
                  controller: fatherna,
                  validator: (value) {
                    if (value.isEmpty) {
                      return ("invalid father's name");
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Father's Name",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 10.0, bottom: 0.0),
                child: Container(
                  padding: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0)),
                  child: DropdownButtonFormField(
                    hint: Text('Gender'),
                    dropdownColor: Colors.grey,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 30,
                    isExpanded: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return ("invalid gender");
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    value: valueChoose,
                    onChanged: (newValue) {
                      setState(() {
                        valueChoose = newValue;
                      });
                    },
                    items: listItem.map((valueItem) {
                      return DropdownMenuItem(
                          value: valueItem, child: Text(valueItem));
                    }).toList(),
                  ),
                ),
              ),
              Padding(
                // padding: EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 10.0, bottom: 20.0),
                child: TextFormField(
                  controller: address,
                  validator: (value) {
                    if (value.isEmpty) {
                      return ("invalid address");
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Address',
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () async {
                    if (_formkey.currentState.validate()) {
                      bool issignup = await FirebaseService()
                          .signup(
                              email: emailController.text,
                              password: passwordController.text)
                          .then((value) {
                        if (value)
                          FirebaseService().addUser(
                              fullName: fullc.text,
                              fatherName: fatherna.text,
                              phoneNumber: phonenumber.text,
                              dateOfBirth: dateofbirth.text,
                              citizenNo: citizenno.text,
                              address: address.text,
                              email: emailController.text,
                              gender: valueChoose);
                        return true;
                      });
                      if (issignup) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomePage()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("Not a valid user")));
                      }
                    }
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
