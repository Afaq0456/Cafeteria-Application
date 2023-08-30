import 'package:flutter/material.dart';
import 'package:freshman.cafe/const/colors.dart';
import 'package:freshman.cafe/utils/helper.dart';
import 'package:freshman.cafe/widgets/customNavBar.dart';
import 'checkoutScreen.dart';
import 'cartScreen.dart';
import '../const/severaddress.dart';

class MyOrderScreen extends StatelessWidget {
  static const routeName = "/myOrderScreen";

  // Create a TextEditingController for notes field
  TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;

    if (args == null ||
        args['cartItem'] == null ||
        args['totalAmount'] == null) {
      // Handle the case where arguments are null or not provided
      return Scaffold(
        body: Center(
          child: Text("Error: Missing product details and total amount."),
        ),
      );
    }

    CartItem cartItem = args['cartItem'];
    double totalAmount = args['totalAmount'];
    String baseurl = BaseUrl().baseUrl;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Order",
        ),
        backgroundColor: AppColor.purple,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Product Details",
                    style: Helper.getTheme(context).headline5,
                  ),
                  SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Image.network(
                        ("$baseurl/${cartItem.productImage}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    cartItem.productName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Image.asset(
                        Helper.getAssetName("star_filled.png", "virtual"),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "4.9",
                        style: TextStyle(
                          color: AppColor.purple,
                        ),
                      ),
                      Text(" (124 ratings)"),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(cartItem.productName),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Image.asset(
                        Helper.getAssetName("loc.png", "virtual"),
                        height: 15,
                      ),
                      SizedBox(width: 5),
                      Text("Minhaj University Lahore"),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              height: 30,
              thickness: 1.5,
              color: AppColor.placeholder.withOpacity(0.25),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Delivery Instruction",
                style: Helper.getTheme(context).headline5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: notesController,
                      decoration: InputDecoration(
                        hintText: "Add notes here...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // Do something with the notes entered by the user.
                      String notes = notesController.text;
                      // You can now use the "notes" variable to store or process the user's notes.
                    },
                    icon: Icon(
                      Icons.add,
                      color: AppColor.purple,
                    ),
                    label: Text(
                      "Add Notes",
                      style: TextStyle(
                        color: AppColor.purple,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              height: 30,
              thickness: 1.5,
              color: AppColor.placeholder.withOpacity(0.25),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Order Summary",
                style: Helper.getTheme(context).headline5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  BurgerCard(
                    name: cartItem.productName,
                    price: "PKR ${cartItem.unitPrice * cartItem.quantity}",
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Sub Total",
                          style: Helper.getTheme(context).headline6,
                        ),
                      ),
                      Text(
                        "PKR $totalAmount",
                        style: Helper.getTheme(context).headline6.copyWith(
                              color: AppColor.purple,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Delivery Cost",
                          style: Helper.getTheme(context).headline6,
                        ),
                      ),
                      Text(
                        "PKR 10",
                        style: Helper.getTheme(context).headline6.copyWith(
                              color: AppColor.purple,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(
                    color: AppColor.placeholder.withOpacity(0.25),
                    thickness: 1.5,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Total",
                          style: Helper.getTheme(context).headline6,
                        ),
                      ),
                      Text(
                        "PKR ${totalAmount + 10}",
                        style: Helper.getTheme(context).headline6.copyWith(
                              color: AppColor.purple,
                              fontSize: 22,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          CheckoutScreen.routeName,
                          arguments: {
                            'totalAmount': totalAmount,
                            'notesController': notesController,
                          },
                        );
                      },
                      child: Text("Checkout"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}

class BurgerCard extends StatelessWidget {
  const BurgerCard({
    Key key,
    @required this.name,
    @required this.price,
  }) : super(key: key);

  final String name;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              "$name x1",
              style: TextStyle(
                color: AppColor.primary,
                fontSize: 16,
              ),
            ),
          ),
          Text(
            price,
            style: TextStyle(
              color: AppColor.primary,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
