import 'package:flutter/material.dart';
import 'package:freshman.cafe/const/colors.dart';
import 'package:freshman.cafe/utils/helper.dart';
import 'package:freshman.cafe/widgets/customNavBar.dart';
import 'package:freshman.cafe/screens/paymentScreen.dart';

class WalletScreen extends StatelessWidget {
  static const routeName = "/walletScreen";

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
                          "Wallet",
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
                  height: 30,
                ),
                Text(
                  "Your Balance",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primary,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "PKR 500",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primary,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, PaymentScreen.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: AppColor.purple,
                    ),
                    child: Text(
                      "+Add Balance",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Transaction History",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primary,
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        10, // Replace with actual transaction history count
                    itemBuilder: (context, index) {
                      return TransactionItem(
                        amount: "PKR 100",
                        date: "June 19, 2023",
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

class TransactionItem extends StatelessWidget {
  final String amount;
  final String date;

  const TransactionItem({
    Key key,
    @required this.amount,
    @required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.payment_rounded),
      title: Text(
        amount,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(date),
    );
  }
}
