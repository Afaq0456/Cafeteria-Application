import 'package:flutter/material.dart';
import 'package:freshman.cafe/const/colors.dart';
import 'package:freshman.cafe/utils/helper.dart';
import 'package:freshman.cafe/widgets/customNavBar.dart';

class NotificationScreen extends StatelessWidget {
  static const routeName = "/termsAndConditionsScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Terms & Conditions",
          style: Helper.getTheme(context).headline5,
        ),
        actions: [
          Image.asset(
            Helper.getAssetName("cart.png", "virtual"),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1
            TermsAndConditionsCard(
              icon: Icons.info_outline, // Info icon
              title: "Welcome to Freshman Cafe!",
              content:
                  "Please read these Terms and Conditions carefully before using the Freshman Cafe app.",
            ),
            // Section 2
            TermsAndConditionsCard(
              icon: Icons.assignment_turned_in, // Check icon
              title: "1. Acceptance of Terms",
              content:
                  "By using the Freshman Cafe app, you agree to be bound by these Terms and Conditions. If you do not agree to these terms, please do not use the app.",
            ),
            // Section 3
            TermsAndConditionsCard(
              icon: Icons.business, // Business icon
              title: "2. Use of the App",
              content:
                  "You may use the Freshman Cafe app solely for personal and non-commercial purposes. You shall not modify, distribute, transmit, display, perform, reproduce, publish, license, create derivative works from, transfer, or sell any information, software, products, or services obtained from this app.",
            ),
            // Section 4
            TermsAndConditionsCard(
              icon: Icons.privacy_tip, // Privacy tip icon
              title: "3. Privacy Policy",
              content:
                  "Your privacy is important to us. Please review our Privacy Policy to understand how we collect, use, and disclose information about you.",
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        menu: true,
      ),
    );
  }
}

class TermsAndConditionsCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const TermsAndConditionsCard({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: AppColor.purple,
                ),
                SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primary),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
                color: AppColor.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
