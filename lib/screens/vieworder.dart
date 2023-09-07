import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../const/colors.dart';
import 'package:freshman.cafe/utils/helper.dart';
import 'package:freshman.cafe/widgets/customNavBar.dart';
import '../const/severaddress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewMyOrderScreen extends StatefulWidget {
  static const routeName = "/viewMyOrderScreen";
  @override
  _ViewMyOrderScreenState createState() => _ViewMyOrderScreenState();
}

class _ViewMyOrderScreenState extends State<ViewMyOrderScreen> {
  Map<String, dynamic> orderData = {};
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

  Widget buildDataCard(String title, dynamic data, IconData icon) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Icon(icon, color: AppColor.purple),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          data != null ? data.toString() : 'N/A',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ),
    );
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
          "View My Order",
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
          : SingleChildScrollView(
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
                        color: Colors.black,
                      ),
                    ),
                    Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildDataCard(
                              "Order Status",
                              orderData['order_status'],
                              Icons.info_outline,
                            ),
                            buildDataCard(
                              "Customer Address",
                              orderData['customer_address'],
                              Icons.location_on,
                            ),
                            buildDataCard(
                              "Customer Note",
                              orderData['customer_note'],
                              Icons.note,
                            ),
                            buildDataCard(
                              "Order Placed At",
                              orderData['order_placed_at'],
                              Icons.access_time,
                            ),
                            buildDataCard(
                              "Total",
                              orderData['total'],
                              Icons.attach_money,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      "Order Items",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    if (orderData['order_items'] != null)
                      for (var item in orderData['order_items'])
                        Card(
                          elevation: 3,
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildDataCard(
                                "Item Name",
                                item['name'],
                                Icons.shopping_cart,
                              ),
                              buildDataCard(
                                "Quantity",
                                item['quantity'],
                                Icons.shopping_basket,
                              ),
                              buildDataCard(
                                "Price",
                                item['unit_price'],
                                Icons.attach_money,
                              ),
                              buildDataCard(
                                "Description",
                                item['description'],
                                Icons.description,
                              ),
                            ],
                          ),
                        ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
