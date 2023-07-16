import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freshman.cafe/const/colors.dart';
import 'package:freshman.cafe/const/severaddress.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/helper.dart';
import '../widgets/customTextInput.dart';
import './introScreen.dart';
import 'package:http/http.dart' as http;

class NewPwScreen extends StatelessWidget {
  static const routeName = "/newPw";
  final TextEditingController newpass = TextEditingController();
  final TextEditingController oldpass1 = TextEditingController();
  final TextEditingController newpass2 = TextEditingController();

  Future<void> changePassword(newPassword, oldPassword) async {
    // Get the bearer token from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString(
        'action'); // Replace 'action' with your token key from shared preferences
    String baseurl = BaseUrl().baseUrl;
    String apiUrl = '$baseurl/api/customer/change/password';

    // Add the query parameters to the URL

    String url = '$apiUrl?new_password=$newPassword&old_password=$oldPassword';

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the data
        var data = json.decode(response.body);
        return data;
      } else {
        // If the server did not return a 200 OK response, handle the error
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      // Handle other exceptions if any
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Helper.getScreenWidth(context),
        height: Helper.getScreenHeight(context),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text("New Password", style: Helper.getTheme(context).headline6),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Please enter your email to receive a link to create a new password via email",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: AppColor.placeholderBg,
                    shape: StadiumBorder(),
                  ),
                  child: TextField(
                    controller: oldpass1,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Old Password",
                      hintStyle: TextStyle(
                        color: AppColor.placeholder,
                      ),
                      contentPadding: EdgeInsets.only(left: 40),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: AppColor.placeholderBg,
                    shape: StadiumBorder(),
                  ),
                  child: TextField(
                    controller: newpass,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "New Password",
                      hintStyle: TextStyle(
                        color: AppColor.placeholder,
                      ),
                      contentPadding: EdgeInsets.only(left: 40),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: AppColor.placeholderBg,
                    shape: StadiumBorder(),
                  ),
                  child: TextField(
                    controller: newpass2,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Comfirm New Password",
                      hintStyle: TextStyle(
                        color: AppColor.placeholder,
                      ),
                      contentPadding: EdgeInsets.only(left: 40),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (newpass.text == newpass2.text &&
                          newpass.text.isNotEmpty &&
                          newpass2.text.isNotEmpty) {
                        await changePassword(newpass, oldpass1);
                        Navigator.of(context)
                            .pushReplacementNamed(IntroScreen.routeName);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please Fill Fields Correctly.'),
                            duration: Duration(
                                seconds:
                                    3), // Optional: Set the duration for the Snackbar
                            action: SnackBarAction(
                              label: 'OK',
                              onPressed: () {
                                // Add any action you want to perform when the user taps on the action button.
                              },
                            ),
                          ),
                        );
                      }
                    },
                    child: Text("Next"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
