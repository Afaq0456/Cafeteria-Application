import 'package:flutter/material.dart';

import '../const/colors.dart';
import '../utils/helper.dart';
import './newPwScreen.dart';

class SendOTPScreen extends StatefulWidget {
  static const routeName = "/sendOTP";

  @override
  _SendOTPScreenState createState() => _SendOTPScreenState();
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
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(NewPwScreen.routeName);
                  },
                  child: Text("Next"),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Didn't receive the OTP? "),
                  Text(
                    "Click Here",
                    style: TextStyle(
                      color: AppColor.purple,
                      fontWeight: FontWeight.bold,
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
