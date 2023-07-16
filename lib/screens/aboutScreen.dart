import 'package:flutter/material.dart';
import 'package:freshman.cafe/const/colors.dart';
import 'package:freshman.cafe/utils/helper.dart';
import 'package:freshman.cafe/widgets/customNavBar.dart';
import 'dart:convert';
import 'package:freshman.cafe/const/severaddress.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AboutScreen extends StatefulWidget {
  static const routeName = "/aboutScreen";

  const AboutScreen({Key key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  Map<String, dynamic> about = {};
  Future<void> About() async {
    // Get the bearer token from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('action');
    String baseurl = BaseUrl().baseUrl;

    String apiUrl = '$baseurl/api/about_us';

    try {
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the response data
        final responseData = json.decode(response.body);
        setState(() {
          about = responseData;
        });
      } else {
        // If the server did not return a 200 OK response, handle the error
        print('Failed to fetch data: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      // Handle other exceptions if any
      print('Error: $error');
      return null;
    }
  }

  @override
  void initState() {
    About();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                          "About Us",
                          style: Helper.getTheme(context).headline5,
                        ),
                      ),
                      Image.asset(
                        Helper.getAssetName("cart.png", "virtual"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          about.isEmpty
                              ? ""
                              : about["Data"]["about_us"].toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        )
                        // AboutCard(
                        //   image: AssetImage('assets/virtual/user1.png'),
                        //   name: 'Afaq Ahmad ',
                        //   contactNumber: '+92126246153',
                        //   degree: 'Bachelor of Softwear Engineeering',
                        //   university: 'Minhaj University',
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // AboutCard(
                        //   image: AssetImage('assets/virtual/avatar2.png'),
                        //   name: 'Unzila Mughal',
                        //   contactNumber: '+92356158888',
                        //   degree: 'Bachelor of Softwear Engineeering',
                        //   university: 'Minhaj University',
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: CustomNavBar(
              menu: true,
            ),
          ),
        ],
      ),
    );
  }
}

class AboutCard extends StatelessWidget {
  final ImageProvider image;
  final String name;
  final String contactNumber;
  final String degree;
  final String university;

  const AboutCard({
    Key key,
    @required this.image,
    @required this.name,
    @required this.contactNumber,
    @required this.degree,
    @required this.university,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.purple,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: image,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    contactNumber,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            degree,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Text(
            university,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
