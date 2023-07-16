import 'package:flutter/material.dart';
import 'package:freshman.cafe/const/colors.dart';
import 'package:freshman.cafe/utils/helper.dart';
import 'package:freshman.cafe/widgets/customNavBar.dart';
import 'package:freshman.cafe/widgets/customTextInput.dart';
import 'newPwScreen.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = "/profileScreen";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              height: Helper.getScreenHeight(context),
              width: Helper.getScreenWidth(context),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Profile",
                            style: Helper.getTheme(context).headline5,
                          ),
                          Image.asset(
                            Helper.getAssetName("cart.png", "virtual"),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ClipOval(
                        child: Stack(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              child: Image.asset(
                                Helper.getAssetName(
                                  "user1.jpg",
                                  "real",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                height: 20,
                                width: 80,
                                color: Colors.black.withOpacity(0.3),
                                child: Image.asset(
                                  Helper.getAssetName(
                                    "camera.png",
                                    "virtual",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      isEditing
                          ? SizedBox()
                          : Text(
                              "Hi there !",
                              style:
                                  Helper.getTheme(context).headline4.copyWith(
                                        color: AppColor.primary,
                                      ),
                            ),
                      SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: () {
                          // Handle sign out functionality here
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: Text(
                          "Sign Out",
                          style: TextStyle(color: AppColor.purple),
                        ),
                      ),
                      SizedBox(height: 40),
                      CustomFormInput(
                        label: "Name",
                        value: "",
                        isEditing: isEditing,
                      ),
                      SizedBox(height: 20),
                      CustomFormInput(
                        label: "Email",
                        value: "",
                        isEditing: false,
                      ),
                      SizedBox(height: 20),
                      CustomFormInput(
                        label: "Mobile No",
                        value: "",
                        isEditing: isEditing,
                      ),
                      SizedBox(height: 20),
                      CustomFormInput(
                        label: "Address",
                        value: "",
                        isEditing: isEditing,
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: isEditing
                            ? ElevatedButton(
                                onPressed: () {
                                  // Handle save functionality here
                                  setState(() {
                                    isEditing = false;
                                  });
                                },
                                child: Text("Save"),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    isEditing = true;
                                  });
                                },
                                child: Text("Edit Profile"),
                              ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to the NewPassScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewPwScreen(),
                              ),
                            );
                          },
                          child: Text("Change Password"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: CustomNavBar(
              profile: true,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomFormInput extends StatelessWidget {
  const CustomFormInput({
    Key key,
    @required this.label,
    @required this.value,
    this.isEditing = false,
  }) : super(key: key);

  final String label;
  final String value;
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.only(left: 40),
      decoration: ShapeDecoration(
        shape: StadiumBorder(),
        color: AppColor.placeholderBg,
      ),
      child: TextFormField(
        readOnly: !isEditing,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
          contentPadding: const EdgeInsets.only(top: 10, bottom: 10),
        ),
        initialValue: value,
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}
