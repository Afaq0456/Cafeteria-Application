import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freshman.cafe/const/colors.dart';
import 'package:freshman.cafe/const/severaddress.dart';
import 'package:freshman.cafe/utils/helper.dart';
import 'package:freshman.cafe/widgets/customNavBar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = "/notiScreen";

  const NotificationScreen({Key key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    noti();
    super.initState();
  }

  final List<NotificationModel> notifications = [
    NotificationModel(
      title: "Your order has been picked up",
      time: "Now",
    ),
    NotificationModel(
      title: "Your order has been delivered",
      time: "1 h ago",
      color: AppColor.placeholderBg,
    ),
    NotificationModel(
      title: "Lorem ipsum dolor sit amet, consectetur",
      time: "3 h ago",
    ),
    NotificationModel(
      title: "Lorem ipsum dolor sit amet, consectetur",
      time: "5 h ago",
    ),
    NotificationModel(
      title: "Lorem ipsum dolor sit amet, consectetur",
      time: "05 Sep 2020",
      color: AppColor.placeholderBg,
    ),
    NotificationModel(
      title: "Lorem ipsum dolor sit amet, consectetur",
      time: "12 Aug 2020",
      color: AppColor.placeholderBg,
    ),
  ];

  Map<String, dynamic> notification = {};
  Future<void> noti() async {
    // Get the bearer token from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('action');
    String baseurl = BaseUrl().baseUrl;

    String apiUrl = '$baseurl/api/customer/notifications/';

    try {
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the response data
        final responseData = json.decode(response.body);
      } else {
        // If the server did not return a 200 OK response, handle the error
        print('Failed to fetch data: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      // Handle other exceptions if any
      print('Error: $error');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Notifications",
                          style: Helper.getTheme(context).headline5,
                        ),
                      ),
                      Image.asset(
                        Helper.getAssetName("cart.png", "virtual"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final notification = notifications[index];
                      return NotiCard(
                        title: notification.title,
                        time: notification.time,
                        color: AppColor.purple, // Set the card color to purple
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: CustomNavBar(
              menu: true,
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationModel {
  final String title;
  final String time;
  final Color color;

  NotificationModel({
    @required this.title,
    @required this.time,
    this.color = Colors.white,
  });
}

class NotiCard extends StatelessWidget {
  const NotiCard({
    Key key,
    String time,
    String title,
    Color color = Colors.white,
  })  : _time = time,
        _title = title,
        _color = color,
        super(key: key);

  final String _time;
  final String _title;
  final Color _color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _color,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: AppColor.purple,
              radius: 5,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _title,
                    style: TextStyle(
                      color: AppColor.placeholderBg,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    _time,
                    style: TextStyle(
                      color: AppColor.placeholderBg.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
