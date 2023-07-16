import 'package:flutter/material.dart';
import 'package:freshman.cafe/const/colors.dart';
import 'package:freshman.cafe/utils/helper.dart';
import 'package:freshman.cafe/widgets/customNavBar.dart';

class InboxScreen extends StatelessWidget {
  static const routeName = "/inboxScreen";

  final List<InboxMessage> inboxMessages = [
    InboxMessage(
      sender: "Unzila Mughal",
      subject: "Regarding your order",
      message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    ),
    InboxMessage(
      sender: "Unzila Mughal",
      subject: "Important announcement",
      message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    ),
    InboxMessage(
      sender: "Unzila Mughal",
      subject: "Meeting Reminder",
      message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
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
                        icon: Icon(Icons.arrow_back_ios_rounded),
                      ),
                      Expanded(
                        child: Text(
                          "Inbox",
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
                    itemCount: inboxMessages.length,
                    itemBuilder: (context, index) {
                      final message = inboxMessages[index];
                      return InboxMessageCard(
                        sender: message.sender,
                        subject: message.subject,
                        message: message.message,
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

class InboxMessage {
  final String sender;
  final String subject;
  final String message;

  InboxMessage({
    @required this.sender,
    @required this.subject,
    @required this.message,
  });
}

class InboxMessageCard extends StatelessWidget {
  final String sender;
  final String subject;
  final String message;

  const InboxMessageCard({
    Key key,
    @required this.sender,
    @required this.subject,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.purple, // Set the card color to purple
      elevation: 0,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sender,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              subject,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
