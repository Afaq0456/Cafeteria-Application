import 'package:flutter/material.dart';
import 'package:freshman.cafe/const/colors.dart';
import 'package:freshman.cafe/utils/helper.dart';
import 'package:freshman.cafe/widgets/customNavBar.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = "/aboutScreen";

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
                  Column(
                    children: [
                      AboutCard(
                        image: AssetImage('assets/virtual/user1.png'),
                        name: 'Afaq Ahmad ',
                        contactNumber: '+92126246153',
                        degree: 'Bachelor of Softwear Engineeering',
                        university: 'Minhaj University',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      AboutCard(
                        image: AssetImage('assets/virtual/avatar2.png'),
                        name: 'Unzila Mughal',
                        contactNumber: '+92356158888',
                        degree: 'Bachelor of Softwear Engineeering',
                        university: 'Minhaj University',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
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
