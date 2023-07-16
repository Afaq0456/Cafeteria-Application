import 'package:flutter/material.dart';
import 'package:freshman.cafe/const/colors.dart';
import 'package:freshman.cafe/screens/checkoutScreen.dart';
import 'package:freshman.cafe/utils/helper.dart';
import 'package:freshman.cafe/widgets/customNavBar.dart';

class MyOrderScreen extends StatelessWidget {
  static const routeName = "/myOrderScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Row(
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
                        "My Order",
                        style: Helper.getTheme(context).headline5,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    height: 80,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 80,
                            width: 80,
                            child: Image.asset(
                              Helper.getAssetName("hamburger.jpg", "real"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Zinger Burgers",
                              style: Helper.getTheme(context).headline3,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  Helper.getAssetName(
                                    "star_filled.png",
                                    "virtual",
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "4.9",
                                  style: TextStyle(
                                    color: AppColor.purple,
                                  ),
                                ),
                                Text(" (124 ratings)"),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Burger"),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 5,
                                  ),
                                  child: Text(
                                    ".",
                                    style: TextStyle(
                                      color: AppColor.purple,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text("FreshMan"),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height: 15,
                                  child: Image.asset(
                                    Helper.getAssetName(
                                      "loc.png",
                                      "virtual",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("Minhaj University Lahore")
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  color: AppColor.placeholderBg,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        BurgerCard(
                          price: "PKR 400",
                          name: "Ziner Burger",
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColor.placeholder.withOpacity(0.25),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Delivery Instruction",
                                style: Helper.getTheme(context).headline3,
                              ),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: AppColor.purple,
                                    ),
                                    Text(
                                      "Add Notes",
                                      style: TextStyle(
                                        color: AppColor.purple,
                                      ),
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Sub Total",
                              style: Helper.getTheme(context).headline3,
                            ),
                          ),
                          Text(
                            "PKR 968",
                            style: Helper.getTheme(context).headline3.copyWith(
                                  color: AppColor.purple,
                                ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Delivery Cost",
                              style: Helper.getTheme(context).headline3,
                            ),
                          ),
                          Text(
                            "PKR 120",
                            style: Helper.getTheme(context).headline3.copyWith(
                                  color: AppColor.purple,
                                ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: AppColor.placeholder.withOpacity(0.25),
                        thickness: 1.5,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Total",
                              style: Helper.getTheme(context).headline3,
                            ),
                          ),
                          Text(
                            "PKR 1068",
                            style: Helper.getTheme(context).headline3.copyWith(
                                  color: AppColor.purple,
                                  fontSize: 22,
                                ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(CheckoutScreen.routeName);
                          },
                          child: Text("Checkout"),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: CustomNavBar(),
          ),
        ],
      ),
    );
  }
}

class BurgerCard extends StatelessWidget {
  const BurgerCard({
    Key key,
    String name,
    String price,
    bool isLast = false,
  })  : _name = name,
        _price = price,
        _isLast = isLast,
        super(key: key);

  final String _name;
  final String _price;
  final bool _isLast;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border(
          bottom: _isLast
              ? BorderSide.none
              : BorderSide(
                  color: AppColor.placeholder.withOpacity(0.25),
                ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "${_name} x1",
              style: TextStyle(
                color: AppColor.primary,
                fontSize: 16,
              ),
            ),
          ),
          Text(
            "\$$_price",
            style: TextStyle(
              color: AppColor.primary,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          )
        ],
      ),
    );
  }
}
