import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:freshman.cafe/screens/loginScreen.dart';
import 'package:http/http.dart' as http;
import '../const/colors.dart';
import '../const/severaddress.dart';
import '../utils/helper.dart';
import './newPwScreen.dart';

class SendOTPScreen extends StatefulWidget {
  static const routeName = "/sendOTP";
  final email;
  SendOTPScreen({Key key, @required this.email}) : super(key: key);

  @override
  State<SendOTPScreen> createState() => _SendOTPScreenState();
}

class _SendOTPScreenState extends State<SendOTPScreen> {
  List<FocusNode> _focusNodes;
  List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(4, (index) => FocusNode());
    _controllers = List.generate(4, (index) => TextEditingController());
    _addFocusListeners();
  }

  void _submitForm() async {
    String baseurl = BaseUrl().baseUrl;
    final Uri apiUrl = Uri.parse('$baseurl/api/customer/verify_email');
    final response = await http.post(
      apiUrl,
      body: {
        'email': "${widget.email}",
        "otp":
            "${_controllers[0].text}${_controllers[1].text}${_controllers[2].text}${_controllers[3].text}"
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data["Message"].toString()),
        ),
      );
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    } else {
      var data = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data["Message"].toString()),
        ),
      );
    }
  }

  @override
  void dispose() {
    _removeFocusListeners();
    super.dispose();
  }

  void _addFocusListeners() {
    for (int i = 0; i < 3; i++) {
      _controllers[i].addListener(() {
        _onTextChanged(i);
      });
    }
  }

  void _removeFocusListeners() {
    for (int i = 0; i < 3; i++) {
      _controllers[i].removeListener(() {
        _onTextChanged(i);
      });
    }
  }

  void _onTextChanged(int index) {
    String value = _controllers[index].text;
    if (value.length == 1) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                'We have sent you an OTP to your Mobile',
                style: Helper.getTheme(context).headline6,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                "Please check your mobile number 312****153 to continue resetting your password",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 0; i < 4; i++)
                    OTPInput(
                      focusNode: _focusNodes[i],
                      nextFocusNode: i < 3 ? _focusNodes[i + 1] : null,
                      controller: _controllers[i],
                    ),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await _submitForm();
                  },
                  child: Text("Next"),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Go To The login screen? "),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName);
                    },
                    child: Text(
                      "Click Here",
                      style: TextStyle(
                        color: AppColor.purple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OTPInput extends StatelessWidget {
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final TextEditingController controller;

  const OTPInput({
    Key key,
    this.focusNode,
    this.nextFocusNode,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: ShapeDecoration(
        color: AppColor.placeholderBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(border: InputBorder.none),
        onChanged: (String value) {
          if (value.isEmpty) {
            focusNode.requestFocus();
          }
        },
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
      ),
    );
  }
}
