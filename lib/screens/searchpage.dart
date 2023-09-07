import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freshman.cafe/const/colors.dart';
import 'package:freshman.cafe/const/severaddress.dart';
import 'package:freshman.cafe/screens/homeScreen.dart';
import 'package:freshman.cafe/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class searchPage extends StatefulWidget {
  const searchPage({Key key}) : super(key: key);

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  Map<String, dynamic> productsData = {};

  Future<void> fetchProductsData() async {
    setState(() {
      productsData = {};
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('action');
    String baseurl = BaseUrl().baseUrl;

    try {
      var response = await http.get(
        Uri.parse('$baseurl/api/customer/get/products'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          productsData = data;
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> search_Data(name) async {
    setState(() {
      productsData = {};
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('action');
    String baseurl = BaseUrl().baseUrl;

    try {
      var response = await http.get(
        Uri.parse('$baseurl/api/customer/get/products?name=$name'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          productsData = data;
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  void initState() {
    fetchProductsData();
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
          "Search",
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    shape: StadiumBorder(),
                    color: AppColor.placeholderBg,
                  ),
                  child: TextField(
                    onSubmitted: ((value) async {
                      await search_Data(value);
                    }),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Image.asset(
                        Helper.getAssetName("search_filled.png", "virtual"),
                      ),
                      hintText: "Search",
                      hintStyle: TextStyle(
                        color: AppColor.placeholder,
                        fontSize: 18,
                      ),
                      contentPadding: const EdgeInsets.only(
                        top: 17,
                      ),
                    ),
                  ),
                ),
              ),
              ListView.builder(
                itemCount: productsData.isEmpty ? 0 : productsData["total"],
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (productsData.isEmpty) {
                    return Center(
                      child: Text("Sorry No Products Availible.!"),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RestaurantCard(
                      image: Image.network(
                        BaseUrl().baseUrl +
                            "/" +
                            productsData["data"][index]['image'].toString(),
                        fit: BoxFit.cover,
                      ),
                      name: productsData["data"][index]['name'].toString(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
