import 'package:flutter/material.dart';
import 'package:freshman.cafe/const/colors.dart';
import 'package:freshman.cafe/screens/aboutScreen.dart';
import 'package:freshman.cafe/screens/WalletScreen.dart';
import 'package:freshman.cafe/screens/inboxScreen.dart';
import 'package:freshman.cafe/screens/myOrderScreen.dart';
import 'package:freshman.cafe/screens/orderScreen.dart';
import 'package:freshman.cafe/screens/notificationScreen.dart';
import 'package:freshman.cafe/screens/paymentScreen.dart';
import 'package:freshman.cafe/utils/helper.dart';
import 'package:freshman.cafe/widgets/customNavBar.dart';

class MoreScreen extends StatelessWidget {
  static const routeName = "/moreScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              height: Helper.getScreenHeight(context),
              width: Helper.getScreenWidth(context),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "More",
                          style: Helper.getTheme(context).headline5,
                        ),
                        Image.asset(
                          Helper.getAssetName("cart.png", "virtual"),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    MoreCard(
                      image: Image.asset(
                        Helper.getAssetName("income.png", "virtual"),
                      ),
                      name: "Payment Details",
                      handler: () {
                        Navigator.of(context)
                            .pushNamed(PaymentScreen.routeName);
                      },
                    ),
                    SizedBox(height: 10),
                    MoreCard(
                      image: Image.asset(
                        Helper.getAssetName("shopping_bag.png", "virtual"),
                      ),
                      name: "View Order",
                      handler: () {
                        Navigator.of(context).pushNamed(OrdersScreen.routeName);
                      },
                    ),
                    SizedBox(height: 10),
                    MoreCard(
                      image: Image.asset(
                        Helper.getAssetName("noti.png", "virtual"),
                      ),
                      name: "Notification",
                      isNoti: true,
                      handler: () {
                        Navigator.of(context)
                            .pushNamed(NotificationScreen.routeName);
                      },
                    ),
                    SizedBox(height: 10),
                    MoreCard(
                      image: Image.asset(
                        Helper.getAssetName("mail.png", "virtual"),
                      ),
                      name: "Inbox",
                      handler: () {
                        Navigator.of(context).pushNamed(InboxScreen.routeName);
                      },
                    ),
                    SizedBox(height: 10),
                    MoreCard(
                      image: Image.asset(
                        Helper.getAssetName("info.png", "virtual"),
                      ),
                      name: "About Us",
                      handler: () {
                        Navigator.of(context).pushNamed(AboutScreen.routeName);
                      },
                    ),
                    SizedBox(height: 10),
                    MoreCard(
                      image: Image.asset(
                        Helper.getAssetName("mail.png", "virtual"),
                      ),
                      name: "Wallet",
                      handler: () {
                        Navigator.of(context).pushNamed(WalletScreen.routeName);
                      },
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: CustomNavBar(
              more: true,
            ),
          )
        ],
      ),
    );
  }
}

class MoreCard extends StatelessWidget {
  const MoreCard({
    Key key,
    String name,
    Image image,
    bool isNoti = false,
    Function handler,
  })  : _name = name,
        _image = image,
        _isNoti = isNoti,
        _handler = handler,
        super(key: key);

  final String _name;
  final Image _image;
  final bool _isNoti;
  final Function _handler;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handler,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        color: AppColor.placeholderBg,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.placeholder,
                ),
                child: _image,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  _name,
                  style: TextStyle(
                    color: AppColor.primary,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColor.secondary,
                size: 17,
              ),
              if (_isNoti)
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Text(
                    "6",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
