import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../const/colors.dart';
import '../const/severaddress.dart';
import 'vieworder.dart';
import 'package:freshman.cafe/utils/helper.dart';
import 'package:freshman.cafe/widgets/customNavBar.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = "/ordersScreen";

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order> orders = [];
  bool isLoading = true;

  Future<void> fetchUserOrders() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('action');
      String baseurl = BaseUrl().baseUrl;
      String apiUrl = '$baseurl/api/customer/my/orders';

      final response = await http.get(
        apiUrl,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['Data'] != null && responseData['Data'] is List) {
          List<dynamic> ordersData = responseData['Data'];

          setState(() {
            orders.clear();
            for (var data in ordersData) {
              orders.add(Order(
                id: data['id'],
                customerName: data['customer_name'],
                orderItems: List<OrderItem>.from(data['order_items'].map(
                  (item) => OrderItem(
                    orderId: item['order_id'],
                    id: item['id'],
                    name: item['name'],
                    createdAt: DateTime.parse(item['created_at']),
                  ),
                )),
              ));
            }
            isLoading = false;
          });
        } else {
          print('Data is null or not a list');
          isLoading = false;
        }
      } else {
        print('Failed to fetch orders: ${response.statusCode}');
        isLoading = false;
      }
    } catch (error) {
      print('Error: $error');
      isLoading = false;
    }
  }

  @override
  void initState() {
    fetchUserOrders();
    super.initState();
  }

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
          "My Orders",
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ViewMyOrderScreen.routeName,
                            arguments: order.id,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10.0,
                          ),
                          child: Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  for (var item in order.orderItems)
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.shopping_cart,
                                                color: AppColor.purple,
                                              ),
                                              Text(
                                                "Item: ${item.name}",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          Row(children: [
                                            Icon(
                                              Icons.confirmation_number,
                                              color: AppColor.purple,
                                            ),
                                            Text(
                                              "Order ID: ${item.orderId}",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ]),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.access_time,
                                                color: AppColor.purple,
                                              ),
                                              Text(
                                                "Created At: ${item.createdAt.toLocal()}",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}

class Order {
  final int id;
  final String customerName;
  final List<OrderItem> orderItems;

  Order({
    @required this.id,
    @required this.customerName,
    @required this.orderItems,
  });
}

class OrderItem {
  final int orderId;
  final int id;
  final String name;
  final DateTime createdAt;

  OrderItem({
    @required this.orderId,
    @required this.id,
    @required this.name,
    @required this.createdAt,
  });
}
