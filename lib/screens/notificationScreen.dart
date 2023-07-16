import 'package:flutter/material.dart';
import 'package:freshman.cafe/const/colors.dart';
import 'package:freshman.cafe/utils/helper.dart';
import 'package:freshman.cafe/widgets/customNavBar.dart';

class NotificationScreen extends StatelessWidget {
  static const routeName = "/notiScreen";

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
