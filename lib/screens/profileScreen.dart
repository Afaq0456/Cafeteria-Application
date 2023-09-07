import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:freshman.cafe/const/colors.dart';
import 'package:freshman.cafe/const/severaddress.dart';
import 'package:freshman.cafe/screens/loginScreen.dart';
import 'package:freshman.cafe/utils/helper.dart';
import 'package:freshman.cafe/widgets/customNavBar.dart';
import 'package:freshman.cafe/widgets/customTextInput.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'newPwScreen.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = "/profileScreen";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;
  Map<String, dynamic> profileData = {};
  final TextEditingController user_name = TextEditingController();
  final TextEditingController email = TextEditingController();

  final TextEditingController cell_no = TextEditingController();
  final TextEditingController user_address = TextEditingController();

  Future<void> fetchProfileData() async {
    setState(() {
      profileData = {};
    });
    // Get the bearer token from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString('action');
    String baseurl = BaseUrl().baseUrl;
    try {
      var response = await http.get(
        Uri.parse('$baseurl/api/customer/get'),
        headers: {
          'Authorization':
              'Bearer $token', // Add the bearer token to the headers
        },
      );
      // log(response.body);

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the data
        var data = json.decode(response.body);
        setState(() {
          profileData = data;
          user_name.text = profileData["user"]["name"].toString();
          email.text = profileData["user"]["email"].toString();
          cell_no.text = profileData["user"]["phone"].toString();
          user_address.text = profileData["user"]["address"].toString();
        });
      } else {
        // If the server did not return a 200 OK response, handle the error
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      // Handle other exceptions if any
      print('Error: $error');
    }
  }

  Future<void> updateUser(name, address, cellno) async {
    setState(() {
      profileData = {};
    });
    // Get the bearer token from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString('action');
    String baseurl = BaseUrl().baseUrl;
    Map<String, String> formData = {
      'name': name,
      'address': address,
      'phone': cellno,
    };
    try {
      var response = await http.post(
        Uri.parse('$baseurl/api/customer/update'),
        headers: {
          'Authorization':
              'Bearer $token', // Add the bearer token to the headers
        },
        body: formData,
      );
      // log(response.body);

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the data
        fetchProfileData();
      } else {
        // If the server did not return a 200 OK response, handle the error
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      // Handle other exceptions if any
      print('Error: $error');
    }
  }

  Future<void> logout() async {
    // Get the bearer token from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString('action');
    String baseurl = BaseUrl().baseUrl;

    try {
      var response = await http.get(
        Uri.parse('$baseurl/api/customer/logout'),
        headers: {
          'Authorization':
              'Bearer $token', // Add the bearer token to the headers
        },
      );
      // log(response.body);

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the data
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
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
  void initState() {
    super.initState();
    fetchProfileData();
  }

  @override
  Widget build(BuildContext context) {
    String userName = user_name.text.trim().split(' ').first;
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   fetchProfileData();
      // }),
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              height: Helper.getScreenHeight(context),
              width: Helper.getScreenWidth(context),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Profile",
                            style: Helper.getTheme(context).headline5,
                          ),
                          Image.asset(
                            Helper.getAssetName("cart.png", "virtual"),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ClipOval(
                        child: Stack(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              child: Icon(
                                Icons.person,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      isEditing
                          ? SizedBox()
                          : Text(
                              "Hi there $userName",
                              style:
                                  Helper.getTheme(context).headline4.copyWith(
                                        color: AppColor.primary,
                                      ),
                            ),
                      SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: () {
                          logout();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: Text(
                          "Sign Out",
                          style: TextStyle(color: AppColor.purple),
                        ),
                      ),
                      SizedBox(height: 40),
                      CustomFormInput(
                        text: user_name,
                        label: "Name",
                        isEditing: isEditing,
                      ),
                      SizedBox(height: 20),
                      CustomFormInput(
                        text: email,
                        label: "Email",
                        isEditing: false,
                      ),
                      SizedBox(height: 20),
                      CustomFormInput(
                        text: cell_no,
                        label: "Mobile No",
                        isEditing: isEditing,
                      ),
                      SizedBox(height: 20),
                      CustomFormInput(
                        text: user_address,
                        label: "Address",
                        isEditing: isEditing,
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: isEditing
                            ? ElevatedButton(
                                onPressed: () {
                                  // Handle save functionality here
                                  setState(() {
                                    isEditing = false;
                                  });
                                  updateUser(user_name.text, user_address.text,
                                      cell_no.text);
                                },
                                child: Text("Save"),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    isEditing = true;
                                    // user_name.text = "";
                                    // email.text = "";
                                    // cell_no.text = "";
                                    // user_address.text = "";
                                  });
                                },
                                child: Text("Edit Profile"),
                              ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to the NewPassScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewPwScreen(),
                              ),
                            );
                          },
                          child: Text("Change Password"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: CustomNavBar(
              profile: true,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomFormInput extends StatelessWidget {
  const CustomFormInput({
    Key key,
    @required this.label,
    @required this.text,
    this.isEditing = false,
  }) : super(key: key);

  final String label;
  final bool isEditing;
  final TextEditingController text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.only(left: 40),
      decoration: ShapeDecoration(
        shape: StadiumBorder(),
        color: AppColor.placeholderBg,
      ),
      child: TextFormField(
        controller: text,
        readOnly: !isEditing,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
          contentPadding: const EdgeInsets.only(top: 10, bottom: 10),
        ),
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}
