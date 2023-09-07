import 'package:flutter/material.dart';
import 'package:freshman.cafe/const/colors.dart';
import 'package:freshman.cafe/utils/helper.dart';
import 'package:freshman.cafe/widgets/customNavBar.dart';

class InboxScreen extends StatelessWidget {
  static const routeName = "/faqsScreen";

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
          "FAQs",
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
            FaqCard(
              icon: Icons.question_answer,
              question: "What is Freshman Cafe?",
              answer:
                  "Freshman Cafe is a mobile app that allows you to order food and drinks from your favorite cafes and restaurants.",
            ),
            Divider(),
            FaqCard(
              icon: Icons.info,
              question: "How do I place an order?",
              answer:
                  "To place an order, simply select the items you want, add them to your cart, and proceed to checkout. You can then choose your preferred payment method and confirm your order.",
            ),
            Divider(),
            FaqCard(
              icon: Icons.track_changes,
              question: "Can I track my order?",
              answer: "This feature is comming soon.",
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

class FaqCard extends StatelessWidget {
  final IconData icon;
  final String question;
  final String answer;

  const FaqCard({
    Key key,
    @required this.icon,
    @required this.question,
    @required this.answer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  question,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              answer,
              style: TextStyle(
                fontSize: 16,
                color: AppColor.primary,
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
