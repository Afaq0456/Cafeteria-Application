import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:freshman.cafe/const/severaddress.dart';
import 'package:freshman.cafe/screens/sentOTPScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freshman.cafe/screens/forgetPwScreen.dart';
import 'package:freshman.cafe/screens/introScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/colors.dart';
import '../screens/forgetPwScreen.dart';
import '../screens/signUpScreen.dart';
import '../utils/helper.dart';
import '../widgets/customTextInput.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/loginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final storage = new FlutterSecureStorage();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  String email = '';
  String password = '';

  void _login(BuildContext context) async {
    String baseurl = BaseUrl().baseUrl;
    final apiUrl = Uri.parse(
        '$baseurl/api/customer/login?email=$email&password=$password');

    final response = await http.get(apiUrl);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['statusCode'].toString() != "200") {
        print('Login failed: ${response.body}');
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login Failed.'),
            duration: Duration(
                seconds: 3), // Optional: Set the duration for the Snackbar
            action: SnackBarAction(
              label: 'OK',
              onPressed: () {
                // Add any action you want to perform when the user taps on the action button.
              },
            ),
          ),
        );
        return;
      }
    }

    final data = json.decode(response.body);
    if (data["email_verify"].toString() == "0") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => SendOTPScreen(email: email),
        ),
      );
    }

    if (response.statusCode == 200) {
      // Login successful
      // Extract the bearer token from the response
      final data = json.decode(response.body);

      var token = data['access_token'];

      // Print the token
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      try {
        prefs.remove('action');
      } catch (e) {}
      String encodedMap = json.encode(data);
      await prefs.setString('all', '$encodedMap');
      await prefs.setString('action', '$token');
      // Store the token securely
      await storage.write(key: 'token', value: token);
      Navigator.pushReplacementNamed(context, IntroScreen.routeName);
      // Make subsequent API requests with the bearer token
      // await _fetchData(token);
    } else {
      // Login failed
      print('Login failed: ${response.body}');
      // Show error message
      _showErrorMessage('Login failed');
    }
  }

  void _fetchData(String token) async {
    // Use the bearer token to make authenticated API requests
    String baseurl = BaseUrl().baseUrl;
    final apiUrl = Uri.parse('$baseurl/api/data');

    final response = await http.get(
      apiUrl,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      // Data fetched successfully
      // Handle the response here
    } else {
      // Data fetch failed
      print('Data fetch failed: ${response.body}');
      // Handle the error here
    }
  }

  bool _validateInputs(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      return false;
    }
    return true;
  }

  void _showErrorMessage(String message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Helper.getScreenHeight(context),
        width: Helper.getScreenWidth(context),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 30,
            ),
            child: Column(
              children: [
                Text(
                  "Login",
                  style: Helper.getTheme(context).headline6,
                ),
                Spacer(),
                Text('Add your details to login'),
                Spacer(),
                CustomTextInput(
                  hintText: "Your email",
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                Spacer(),
                CustomTextInput(
                  hintText: "Password",
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                Spacer(),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.pushReplacementNamed(
                      //     context, IntroScreen.routeName);

                      if (_validateInputs(email, password)) {
                        _login(context);
                      } else {
                        // Show validation error message
                        print('Invalid email or password');
                      }
                    },
                    child: Text("Login"),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(ForgetPwScreen.routeName);
                  },
                  child: Text("Forget your password?"),
                ),
                Spacer(
                  flex: 2,
                ),
                Text("or Login With"),
                Spacer(),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(
                          0xFF367FC0,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Helper.getAssetName(
                            "fb.png",
                            "virtual",
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text("Login with Facebook")
                      ],
                    ),
                  ),
                ),
                Spacer(),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(
                          0xFFDD4B39,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Helper.getAssetName(
                            "google.png",
                            "virtual",
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text("Login with Google")
                      ],
                    ),
                  ),
                ),
                Spacer(
                  flex: 4,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(SignUpScreen.routeName);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an Account?"),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          color: AppColor.purple,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
