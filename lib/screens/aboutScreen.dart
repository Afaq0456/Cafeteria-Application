import 'package:flutter/material.dart';
import 'package:freshman.cafe/const/colors.dart';
import 'package:freshman.cafe/utils/helper.dart';
import 'package:freshman.cafe/widgets/customNavBar.dart';

class AboutScreen extends StatefulWidget {
  static const routeName = "/aboutScreen";

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 0.75);
  int _currentPageIndex = 0;

  // Sample data for team members
  final List<TeamMember> teamMembers = [
    TeamMember(
      image: Helper.getAssetName("user1.jpg", "real"),
      name: 'Afaq Ahmad',
      contactNumber: '+92126246153',
      degree: 'Bachelor of Software Engineering',
      university: 'Minhaj University',
    ),
    TeamMember(
      image: Helper.getAssetName("user3.jpeg", "real"),
      name: 'Unzila Mughal',
      contactNumber: '+92356158888',
      degree: 'Bachelor of Software Engineering',
      university: 'Minhaj University',
    ),
    TeamMember(
      image: Helper.getAssetName("user4.png", "real"),
      name: 'Mr. Saif Ali',
      contactNumber: '+923465724512',
      degree: 'Lecturer, Department of Software Engineering',
      university: 'Minhaj University',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Start the auto-slider
    _startAutoSlider();
  }

  void _startAutoSlider() {
    Future.delayed(Duration(seconds: 3), () {
      if (_currentPageIndex < teamMembers.length - 1) {
        _pageController.animateToPage(_currentPageIndex + 1,
            duration: Duration(milliseconds: 4000), curve: Curves.ease);
      } else {
        _pageController.animateToPage(0,
            duration: Duration(milliseconds: 4000), curve: Curves.ease);
      }
    });
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Card(
                    elevation: 5, // You can adjust the elevation as needed
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          15), // You can adjust the border radius as needed
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(
                          16.0), // You can adjust the padding as needed
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Welcome to Freshman Cafe!",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColor.purple),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Freshman Cafe is a vibrant culinary destination, offering a delightful fusion of flavors and a warm ambiance. Explore a world of taste in a welcoming atmosphere.",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColor.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Our Team",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColor.purple,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 260,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: teamMembers.length,
                      itemBuilder: (context, index) {
                        final member = teamMembers[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: AboutCard(
                            image: AssetImage(member.image),
                            name: member.name,
                            contactNumber: member.contactNumber,
                            degree: member.degree,
                            university: member.university,
                          ),
                        );
                      },
                      onPageChanged: (index) {
                        setState(() {
                          _currentPageIndex = index;
                        });
                        _startAutoSlider();
                      },
                    ),
                  ),

                  // Add the "Contact Us" card with Flutter default icons
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Contact Us",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.purple,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Minhaj University Johar Town Lahore Punjab, Pakistan!",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColor.secondary,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Email: freshmancafe@mul.edu.pk",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Phone: +(042) 346 28281",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Icon(
                                  Icons.facebook,
                                  size: 30,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(width: 10),
                              Padding(
                                padding: const EdgeInsets.only(right: 90.0),
                                child: Icon(
                                  Icons.call,
                                  size: 24,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
      width: 200,
      decoration: BoxDecoration(
        color: AppColor.purple
            .withOpacity(0.8), // Use a semi-transparent color here
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Container(
              height: 80,
              width: 80,
              child: Image(
                image: image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
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
          SizedBox(height: 50),
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

class TeamMember {
  final String image;
  final String name;
  final String contactNumber;
  final String degree;
  final String university;

  TeamMember({
    @required this.image,
    @required this.name,
    @required this.contactNumber,
    @required this.degree,
    @required this.university,
  });
}
