import 'package:converter/screen/Login.dart';
import 'package:converter/widgets/config.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class AppTranslator extends StatefulWidget {
  const AppTranslator({super.key, required this.dataList});
  final List<dynamic> dataList;

  @override
  State<AppTranslator> createState() => _AppTranslatorState();
}

class _AppTranslatorState extends State<AppTranslator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: Text(
          'Home Page',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: widget.dataList.isNotEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Username: ${widget.dataList[0]['Username']}'),
                Text('Full Name: ${widget.dataList[0]['Fullname']}'),
                Text('Email: ${widget.dataList[0]['Email']}'),
                Text('Address: ${widget.dataList[0]['Address']}'),
                Text('Contact: ${widget.dataList[0]['Contact']}'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateProfileScreen(
                          username: widget.dataList[0]['Username'],
                          fullName: widget.dataList[0]['Fullname'],
                          email: widget.dataList[0]['Email'],
                          address: widget.dataList[0]['Address'],
                          contact: widget.dataList[0]['Contact'],
                        ),
                      ),
                    );
                  },
                  child: Text('UpdateProfile'),
                ),
              ],
            ).p20()
          : Center(
              child: Text('No data available'),
            ),
    );
  }
}

class UpdateProfileScreen extends StatefulWidget {
  final String username;
  final String fullName;
  final String email;
  final String address;
  final String contact;

  UpdateProfileScreen({
    required this.username,
    required this.fullName,
    required this.email,
    required this.address,
    required this.contact,
  });

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController password = TextEditingController();
  void _updateProfile() async {
    if (widget.username.isEmpty ||
        widget.fullName.isEmpty ||
        widget.email.isEmpty ||
        widget.address.isEmpty ||
        widget.contact.isEmpty ||
        password.text.isEmpty) {
      VxToast.show(
        context,
        msg: "Please fill in all fields",
        bgColor: Colors.red,
      );
      return;
    }

    final url = apiurl +
        "Hdl_DemoUpdateUser.ashx?userId=1&username=${usernameController.text}&name=${fullNameController.text}&email=${emailController.text}&address=${addressController.text}&contact=${contactController.text}&password=${password.text}";
    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      VxToast.show(context,
          msg: 'Updated Succesfully',
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

  @override
  Widget build(BuildContext context) {
    usernameController.text = widget.username;
    fullNameController.text = widget.fullName;
    emailController.text = widget.email;
    addressController.text = widget.address;
    contactController.text = widget.contact;
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                enabled: false,
              ),
              TextFormField(
                controller: fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              TextFormField(
                controller: contactController,
                decoration: InputDecoration(labelText: 'Contact'),
              ),
              TextFormField(
                controller: password,
                decoration: InputDecoration(labelText: 'New Password'),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    _updateProfile();
                  },
                  child: Text('Update'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
