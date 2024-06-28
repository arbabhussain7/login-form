// ignore_for_file: prefer_final_fields, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:converter/reusable%20Code/reuseable.dart';
import 'package:converter/screen/Login.dart';
import 'package:converter/widgets/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Future<void> signUp() async {
    if (_usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _fullnamecontroller.text.isEmpty ||
        _contactController.text.isEmpty ||
        _passwordtextController.text.isEmpty) {
      VxToast.show(context,
          msg: 'Please fill in all fields.',
          bgColor: const Color.fromARGB(255, 255, 17, 0),
          textColor: Colors.white);
      return;
    }
    final url = apiurl +
        "Hdl_UserRegistration.ashx?username=${_fullnamecontroller.text}&name=${_usernameController.text}&email=${_emailController.text}&address=${_addressController.text}&contact=${_contactController.text}&password=${_passwordtextController.text}";
    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      _usernameController.text = '';
      _emailController.text = '';
      _addressController.text = '';
      _fullnamecontroller.text = '';
      _contactController.text = '';
      _passwordtextController.text = '';
      VxToast.show(context,
          msg: 'Registration Succesful Login Now',
          bgColor: Colors.green,
          textColor: Colors.white);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      VxToast.show(context,
          msg: 'Something Went Wrong! Please Try Again.',
          bgColor: const Color.fromARGB(255, 255, 17, 0),
          textColor: Colors.white);
    }
  }

  TextEditingController _passwordtextController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _fullnamecontroller = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              OutlinedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
            ],
            title: Text(
              "Sign Up ",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 194, 255, 82),
            Colors.amber,
            Color.fromARGB(255, 238, 251, 64),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(right: 22, left: 22, top: 122),
                child: Container(
                  width: 507,
                  height: 730,
                  child: Column(children: [
                    reusableTextfield("Enter Your name", Icons.person, false,
                        _usernameController),
                    SizedBox(
                      height: 24,
                    ),
                    reusableTextfield("Enter Your Email", Icons.email, false,
                        _emailController),
                    SizedBox(
                      height: 24,
                    ),
                    reusableTextfield(
                        "Enter Address", Icons.home, false, _addressController),
                    SizedBox(
                      height: 24,
                    ),
                    reusableTextfield("Enter Username", Icons.person, false,
                        _fullnamecontroller),
                    SizedBox(
                      height: 24,
                    ),
                    reusableTextfield("Enter Your Contact", Icons.phone, false,
                        _contactController),
                    SizedBox(
                      height: 24,
                    ),
                    reusableTextfield("Enter password", Icons.lock, true,
                        _passwordtextController),
                    SizedBox(
                      height: 24,
                    ),
                    SigninSignUpButton(context, false, () {
                      signUp();
                    })
                  ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
