import 'package:flutter/material.dart';
import 'package:freshman.cafe/utils/helper.dart';
import 'package:freshman.cafe/const/colors.dart';
import 'checkoutScreen.dart';
import 'myOrderScreen.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../const/severaddress.dart';

class CartScreen extends StatefulWidget {
  static const routeName = "/cartScreen";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> cartItems;
  double totalAmount;

  void didChangeDependencies() {
    super.didChangeDependencies();
    cartItems = ModalRoute.of(context).settings.arguments as List<CartItem>;
    totalAmount = calculateTotalAmount();
  }

  double calculateTotalAmount() {
    double total = 0;
    for (var item in cartItems) {
      final unitPrice = item.unitPrice ?? 0;
      final quantity = item.quantity ?? 1;

      total += (unitPrice * quantity);
    }
    return total;
  }

  void _removeProductFromCart(BuildContext context, CartItem cartItem) {
    setState(() {
      cartItems.remove(cartItem);
      totalAmount = calculateTotalAmount();
      _saveCartItems(cartItems);
    });
  }

  Future<void> _saveCartItems(List<CartItem> cartItems) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItemsJson =
        cartItems.map((item) => json.encode(item.toJson())).toList();
    await prefs.setStringList('cart_items', cartItemsJson);
  }

  @override
  Widget build(BuildContext context) {
    String baseurl = BaseUrl().baseUrl;
    // print("${cartItems}");
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        actions: [
          Image.asset(
            Helper.getAssetName("cart.png", "virtual"),
          ),
        ],
        backgroundColor: AppColor.purple,
      ),
      body: cartItems == null || cartItems.isEmpty
          ? Center(
              child: Text("Your cart is empty."),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                CartItem cartItem = cartItems[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      MyOrderScreen.routeName,
                      arguments: {
                        'cartItem': cartItem,
                        'totalAmount': totalAmount,
                      },
                    );
                  },
                  child: Card(
                    elevation: 2,
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Image.network(
                              ("$baseurl/${cartItem.productImage}"),
                              height: 80,
                              width: 80,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cartItem.productName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  cartItem.productDescription,
                                  style: TextStyle(color: AppColor.placeholder),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Price: PKR ${cartItem.unitPrice}",
                                  style: TextStyle(
                                    color: AppColor.primary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          elevation:
                                              MaterialStateProperty.all(5.0)),
                                      onPressed: () {
                                        if (cartItem.quantity > 1) {
                                          setState(() {
                                            cartItem.quantity--;
                                            totalAmount =
                                                calculateTotalAmount();
                                          });
                                        }
                                      },
                                      child: Icon(Icons.remove),
                                    ),
                                    Text(
                                      cartItem.quantity.toString(),
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          elevation:
                                              MaterialStateProperty.all(5.0)),
                                      onPressed: () {
                                        setState(() {
                                          cartItem.quantity++;
                                          totalAmount = calculateTotalAmount();
                                        });
                                      },
                                      child: Icon(Icons.add),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "PKR ${cartItem.unitPrice * cartItem.quantity}",
                                  style: TextStyle(
                                    color: AppColor.primary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Subtotal",
                                  style: TextStyle(color: AppColor.placeholder),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Remove Item'),
                                  content: Text(
                                      'Are you sure you want to remove this item from the cart?'),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        _removeProductFromCart(
                                            context, cartItem);
                                        Navigator.pop(context);
                                      },
                                      child: Text('Remove'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: cartItems == null || cartItems.isEmpty
          ? null
          : Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Amount: PKR $totalAmount",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primary,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.pushNamed(
                        context,
                        CheckoutScreen.routeName,
                        arguments: {
                          'totalAmount': totalAmount,
                        },
                      );
                    },
                    child: Text("Checkout"),
                  )
                ],
              ),
            ),
    );
  }
}

class CartItem {
  String productId;
  String productName;
  String productDescription;
  double unitPrice;
  String productImage;
  int quantity;

  CartItem({
    @required this.productId,
    @required this.productName,
    @required this.productDescription,
    @required this.unitPrice,
    @required this.productImage,
    @required this.quantity,
  });

  CartItem.fromJson(Map<String, dynamic> json)
      : productId = json['productId'],
        productName = json['productName'],
        productDescription = json['productDescription'],
        unitPrice = double.parse(json['unitPrice'].toString()),
        productImage = json['productImage'],
        quantity = json['quantity'];

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'productName': productName,
        'productDescription': productDescription,
        'unitPrice': unitPrice,
        'productImage': productImage,
        'quantity': quantity,
      };
}
