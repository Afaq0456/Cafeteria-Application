import 'package:flutter/material.dart';
import 'package:clip_shadow/clip_shadow.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:freshman.cafe/const/colors.dart';
import 'package:freshman.cafe/utils/helper.dart';
import 'package:freshman.cafe/widgets/customNavBar.dart';
import 'cartScreen.dart';
import 'dart:convert';

class IndividualItem extends StatefulWidget {
  static const routeName = "/individualScreen";

  @override
  _IndividualItemState createState() => _IndividualItemState();
}

class _IndividualItemState extends State<IndividualItem> {
  int quantity = 1; // Initial quantity
  double unitPrice = 750.0; // Replace this with the actual unit price

  Future<List<CartItem>> _getCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItemsJson = prefs.getStringList('cart_items') ?? [];
    List<CartItem> cartItems = cartItemsJson
        .map((item) => CartItem.fromJson(json.decode(item)))
        .toList();
    return cartItems;
  }

  Future<void> _saveCartItems(List<CartItem> cartItems) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItemsJson =
        cartItems.map((item) => json.encode(item.toJson())).toList();
    await prefs.setStringList('cart_items', cartItemsJson);
  }

  void _addToCart(BuildContext context) async {
    // Get the product details (Replace these with your actual product details)
    String productId = "1";
    String productName = "Tandoori Chicken Pizza";
    String productDescription =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ornare leo non mollis id cursus. Eu euismod faucibus in leo malesuada";
    String productImage = "tandoori_chicken_pizza.jpg";

    // Create a cart item object
    CartItem cartItem = CartItem(
      productId: productId,
      productName: productName,
      productDescription: productDescription,
      unitPrice: unitPrice,
      productImage: productImage,
      quantity: quantity,
    );

    // Save the cart item to local storage
    List<CartItem> cartItems = await _getCartItems();
    cartItems.add(cartItem);
    await _saveCartItems(cartItems);

    // Navigate to the cart screen and pass the data
    Navigator.pushNamed(context, CartScreen.routeName, arguments: cartItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: Helper.getScreenHeight(context) * 0.5,
                          width: Helper.getScreenWidth(context),
                          child: Image.asset(
                            Helper.getAssetName("pizza3.jpg", "real"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          height: Helper.getScreenHeight(context) * 0.5,
                          width: Helper.getScreenWidth(context),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.0, 0.4],
                              colors: [
                                Colors.black.withOpacity(0.9),
                                Colors.black.withOpacity(0.0),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SafeArea(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Icon(
                                    Icons.arrow_back_ios_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                                Image.asset(
                                  Helper.getAssetName(
                                      "cart_white.png", "virtual"),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Helper.getScreenHeight(context) * 0.35,
                          ),
                          SizedBox(
                            height: 800,
                            width: double.infinity,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Container(
                                    height: 700,
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30),
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          topRight: Radius.circular(40),
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            "Tandoori Chicken Pizza",
                                            style: Helper.getTheme(context)
                                                .headline5,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        Helper.getAssetName(
                                                            "star_filled.png",
                                                            "virtual"),
                                                      ),
                                                      SizedBox(width: 8),
                                                      Image.asset(
                                                        Helper.getAssetName(
                                                            "star_filled.png",
                                                            "virtual"),
                                                      ),
                                                      SizedBox(width: 8),
                                                      Image.asset(
                                                        Helper.getAssetName(
                                                            "star_filled.png",
                                                            "virtual"),
                                                      ),
                                                      SizedBox(width: 8),
                                                      Image.asset(
                                                        Helper.getAssetName(
                                                            "star_filled.png",
                                                            "virtual"),
                                                      ),
                                                      SizedBox(width: 8),
                                                      Image.asset(
                                                        Helper.getAssetName(
                                                            "star.png",
                                                            "virtual"),
                                                      ),
                                                      SizedBox(width: 8),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    "4 Star Ratings",
                                                    style: TextStyle(
                                                      color: AppColor.purple,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    SizedBox(height: 20),
                                                    Text(
                                                      "Rs. ${unitPrice.toStringAsFixed(2)}",
                                                      style: TextStyle(
                                                        color: AppColor.primary,
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    Text("/per Portion"),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            "Description",
                                            style: Helper.getTheme(context)
                                                .headline4
                                                .copyWith(
                                                  fontSize: 16,
                                                ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ornare leo non mollis id cursus. Eu euismod faucibus in leo malesuada"),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Divider(
                                            color: AppColor.placeholder,
                                            thickness: 1.5,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            "Customize your Order",
                                            style: Helper.getTheme(context)
                                                .headline4
                                                .copyWith(
                                                  fontSize: 16,
                                                ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Container(
                                            height: 50,
                                            width: double.infinity,
                                            padding: const EdgeInsets.only(
                                                left: 30, right: 10),
                                            decoration: ShapeDecoration(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              color: AppColor.placeholderBg,
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                hint: Row(
                                                  children: [
                                                    Text(
                                                        "-Select the size of Item-"),
                                                  ],
                                                ),
                                                value: "default",
                                                onChanged: (_) {},
                                                items: [
                                                  DropdownMenuItem(
                                                    child: Text(
                                                        "-Select the size of Item-"),
                                                    value: "default",
                                                  ),
                                                ],
                                                icon: Image.asset(
                                                  Helper.getAssetName(
                                                    "dropdown.png",
                                                    "virtual",
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Container(
                                            height: 50,
                                            width: double.infinity,
                                            padding: const EdgeInsets.only(
                                                left: 30, right: 10),
                                            decoration: ShapeDecoration(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              color: AppColor.placeholderBg,
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                hint: Row(
                                                  children: [
                                                    Text(
                                                        "-Select the ingredients-"),
                                                  ],
                                                ),
                                                value: "default",
                                                onChanged: (_) {},
                                                items: [
                                                  DropdownMenuItem(
                                                    child: Text(
                                                        "-Select the ingredients-"),
                                                    value: "default",
                                                  ),
                                                ],
                                                icon: Image.asset(
                                                  Helper.getAssetName(
                                                    "dropdown.png",
                                                    "virtual",
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Number of Items",
                                                style: Helper.getTheme(context)
                                                    .headline4
                                                    .copyWith(
                                                      fontSize: 16,
                                                    ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    ElevatedButton(
                                                      style: ButtonStyle(
                                                          elevation:
                                                              MaterialStateProperty
                                                                  .all(5.0)),
                                                      onPressed: () {
                                                        if (quantity > 1) {
                                                          setState(() {
                                                            quantity--;
                                                          });
                                                        }
                                                      },
                                                      child: Text("-"),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Container(
                                                      height: 35,
                                                      width: 55,
                                                      decoration:
                                                          ShapeDecoration(
                                                        shape: StadiumBorder(
                                                          side: BorderSide(
                                                              color: AppColor
                                                                  .purple),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "$quantity",
                                                            style: TextStyle(
                                                              color: AppColor
                                                                  .purple,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    ElevatedButton(
                                                      style: ButtonStyle(
                                                          elevation:
                                                              MaterialStateProperty
                                                                  .all(5.0)),
                                                      onPressed: () {
                                                        setState(() {
                                                          quantity++;
                                                        });
                                                      },
                                                      child: Text("+"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 200,
                                          width: double.infinity,
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 120,
                                                decoration: ShapeDecoration(
                                                  color: AppColor.purple,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(40),
                                                      bottomRight:
                                                          Radius.circular(40),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 20,
                                                  ),
                                                  child: Container(
                                                    height: 160,
                                                    width: double.infinity,
                                                    margin:
                                                        const EdgeInsets.only(
                                                      left: 50,
                                                      right: 40,
                                                    ),
                                                    decoration: ShapeDecoration(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  40),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  40),
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10),
                                                        ),
                                                      ),
                                                      shadows: [
                                                        BoxShadow(
                                                          color: AppColor
                                                              .placeholder
                                                              .withOpacity(0.3),
                                                          offset: Offset(0, 5),
                                                          blurRadius: 5,
                                                        ),
                                                      ],
                                                      color: Colors.white,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "Total Price",
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          "PKR ${(unitPrice * quantity).toStringAsFixed(2)}",
                                                          style: TextStyle(
                                                            color: AppColor
                                                                .primary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                        SizedBox(height: 10),
                                                        SizedBox(
                                                          width: 200,
                                                          child: ElevatedButton(
                                                              onPressed: () {
                                                                _addToCart(
                                                                    context);
                                                              },
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Image.asset(
                                                                    Helper.getAssetName(
                                                                        "add_to_cart.png",
                                                                        "virtual"),
                                                                  ),
                                                                  Text(
                                                                    "Add to Cart",
                                                                  )
                                                                ],
                                                              )),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 20,
                                                ),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration: ShapeDecoration(
                                                      color: Colors.white,
                                                      shadows: [
                                                        BoxShadow(
                                                          color: AppColor
                                                              .placeholder
                                                              .withOpacity(0.3),
                                                          offset: Offset(0, 5),
                                                          blurRadius: 5,
                                                        ),
                                                      ],
                                                      shape: CircleBorder(),
                                                    ),
                                                    child: Image.asset(
                                                      Helper.getAssetName(
                                                          "cart_filled.png",
                                                          "virtual"),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 20,
                                  ),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: ClipShadow(
                                      clipper: CustomTriangle(),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColor.placeholder,
                                          offset: Offset(0, 5),
                                          blurRadius: 5,
                                        ),
                                      ],
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        color: Colors.white,
                                        child: Image.asset(
                                          Helper.getAssetName(
                                            "fav_filled.png",
                                            "virtual",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
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

class CustomTriangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Offset controlpoint = Offset(size.width * 0, size.height * 0.5);
    Offset endpoint = Offset(size.width * 0.2, size.height * 0.85);
    Offset controlpoint2 = Offset(size.width * 0.33, size.height);
    Offset endpoint2 = Offset(size.width * 0.6, size.height * 0.9);
    Offset controlpoint3 = Offset(size.width * 1.4, size.height * 0.5);
    Offset endpoint3 = Offset(size.width * 0.6, size.height * 0.1);
    Offset controlpoint4 = Offset(size.width * 0.33, size.height * 0);
    Offset endpoint4 = Offset(size.width * 0.2, size.height * 0.15);

    Path path = new Path()
      ..moveTo(size.width * 0.2, size.height * 0.15)
      ..quadraticBezierTo(
        controlpoint.dx,
        controlpoint.dy,
        endpoint.dx,
        endpoint.dy,
      )
      ..quadraticBezierTo(
        controlpoint2.dx,
        controlpoint2.dy,
        endpoint2.dx,
        endpoint2.dy,
      )
      ..quadraticBezierTo(
        controlpoint3.dx,
        controlpoint3.dy,
        endpoint3.dx,
        endpoint3.dy,
      )
      ..quadraticBezierTo(
        controlpoint4.dx,
        controlpoint4.dy,
        endpoint4.dx,
        endpoint4.dy,
      );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
