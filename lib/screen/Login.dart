// import 'dart:math';

import 'dart:convert';

import 'package:converter/reusable%20Code/reuseable.dart';
import 'package:converter/screen/Signup.dart';
import 'package:converter/screen/Translator.dart';
import 'package:converter/widgets/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future<void> signIN() async {
    if (_emailtextController.text.isEmpty ||
        _passwordtextController.text.isEmpty) {
      VxToast.show(
        context,
        msg: 'Please fill in all fields.',
        bgColor: const Color.fromARGB(255, 255, 17, 0),
        textColor: Colors.white,
      );
      return;
    }

    final url = apiurl +
        "Hdl_DemoLogin.ashx?username=${_emailtextController.text}&password=${_passwordtextController.text}";

    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData != null &&
          responseData is List &&
          responseData.isNotEmpty) {
        // Process the list or data as needed
        List<dynamic> dataList = responseData;

        // Example: Storing data and navigating to the next page
        // Your actual implementation might vary based on your data structure
        storeDataAndNavigate(dataList);
      } else {
        VxToast.show(
          context,
          msg: 'Wrong Username or Password',
          bgColor: const Color.fromARGB(255, 255, 17, 0),
          textColor: Colors.white,
        );
      }
    } else {
      VxToast.show(
        context,
        msg: 'Error during login',
        bgColor: const Color.fromARGB(255, 255, 17, 0),
        textColor: Colors.white,
      );
    }
  }

// Example function to store data and navigate to the next page
  void storeDataAndNavigate(List<dynamic> dataList) {
    // Your logic to store data and navigate to the next page
    // For example, you can use Navigator.push to move to the next page
    // and pass the data using arguments
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppTranslator(dataList: dataList),
      ),
    );
  }

  TextEditingController _passwordtextController = TextEditingController();
  TextEditingController _emailtextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 194, 255, 82),
            Colors.amber,
            Color.fromARGB(255, 238, 251, 64),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 82),
                child: Container(
                  child: Image.asset(
                    "Image/Logo.png",
                  ),
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Center(
                child: Text(
                  "Login!!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 66,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 22, left: 22),
                child: Container(
                  width: 507,
                  height: 730,
                  child: Column(children: [
                    reusableTextfield("Enter Username", Icons.person, false,
                        _emailtextController),
                    SizedBox(
                      height: 44,
                    ),
                    reusableTextfield("Enter password", Icons.lock, true,
                        _passwordtextController),
                    SizedBox(
                      height: 24,
                    ),
                    SigninSignUpButton(context, true, () {
                      FocusScope.of(context).unfocus();
                      signIN();
                    }),
                    SignUpOption(context)
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

Row SignUpOption(BuildContext context) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 72),
        child: Text(
          "Don't have a account? ",
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUpScreen()));
        },
        child: Text(
          "Sign Up",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      )
    ],
  );
}
