import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../const/colors.dart';
import '../const/severaddress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewMyOrderScreen extends StatefulWidget {
  static const routeName = "/viewMyOrderScreen";
  @override
  _ViewMyOrderScreenState createState() => _ViewMyOrderScreenState();
}

class _ViewMyOrderScreenState extends State<ViewMyOrderScreen> {
  Map<String, dynamic> orderData = {}; // Store order data here
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOrderData();
  }

  Future<void> fetchOrderData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('action');

    final int orderId = ModalRoute.of(context).settings.arguments;

    try {
      String baseurl = BaseUrl().baseUrl;
      String apiUrl = '$baseurl/api/customer/my/order/view?order_id=$orderId';

      final response = await http.get(
        apiUrl,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        setState(() {
          orderData = responseData['Data'];
          isLoading = false;
        });

        print('Name: ${orderData['name']}');
      } else {
        print('Failed to load order data: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("View My Order"), backgroundColor: AppColor.purple),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order Details",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                title: Text(
                  "Name:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "${orderData['name'] ?? 'N/A'}",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "Price:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "${orderData['total'] ?? 'N/A'}",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "Quantity:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "${orderData['order_items']?.length ?? 'N/A'}",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "Date:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "${orderData['order_placed_at'] ?? 'N/A'}",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "Address:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "${orderData['customer_address'] ?? 'N/A'}",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "Note:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "${orderData['customer_note'] ?? 'N/A'}",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "Status:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "${orderData['order_status'] ?? 'N/A'}",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
