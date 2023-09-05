import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../const/colors.dart';
import '../utils/helper.dart';
import '../const/severaddress.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = "/ordersScreen";

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order> orders = [];

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

        print('Fetched Data: $responseData');

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
          });
        } else {
          print('Data is null or not a list');
        }
      } else {
        print('Failed to fetch orders: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
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
        title: Text("My Orders"),
        backgroundColor: AppColor.purple,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple, // Purple shadow color
                          blurRadius: 10.0, // Adjust the blur radius
                          offset: Offset(0, 2), // Adjust the offset
                        ),
                      ],
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation:
                          0, // Set elevation to 0 to remove default shadow
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Customer: ${order.customerName}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 10),
                            for (var item in order.orderItems)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Item: ${item.name}",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    "Order ID: ${item.orderId}",
                                    style: TextStyle(fontSize: 14),
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
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
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
