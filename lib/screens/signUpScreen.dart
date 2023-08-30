import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:freshman.cafe/const/severaddress.dart';
import 'package:http/http.dart' as http;
import 'package:freshman.cafe/const/colors.dart';
import 'package:freshman.cafe/utils/helper.dart';
import '../screens/loginScreen.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signUpScreen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  File _image;

  Future _getImage() async {
    final picker = ImagePicker();
    try {
      final pickedImage = await picker.getImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  void _submitForm() async {
    if (_formKey.currentState.validate()) {
      String baseurl = BaseUrl().baseUrl;
      final Uri apiUrl = Uri.parse('$baseurl/api/customer/register');

      var request = http.MultipartRequest('POST', apiUrl);
      request.fields['name'] = nameController.text;
      request.fields['email'] = emailController.text;
      request.fields['mobile'] = mobileController.text;
      request.fields['address'] = addressController.text;
      request.fields['password'] = passwordController.text;

      if (_image != null) {
        request.files
            .add(await http.MultipartFile.fromPath('image', _image.path));
      }

      try {
        final response = await request.send();

        if (response.statusCode == 200) {
          var responseData = await response.stream.bytesToString();
          var data = json.decode(responseData);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data["Message"].toString()),
            ),
          );
          // Print the API response data to the console
          print("API Response Data: $data");
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("An error occurred during registration."),
            ),
          );
        }
      } catch (e) {
        print("Error submitting form: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: Helper.getScreenWidth(context),
          height: Helper.getScreenHeight(context),
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign Up",
                      style: Helper.getTheme(context).headline6,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Add your details to sign up",
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: GestureDetector(
                        onTap: _getImage,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              _image != null ? FileImage(_image) : null,
                          child: _image == null ? Icon(Icons.camera_alt) : null,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Circular border input field with icon
                          buildInputFieldWithIcon(
                            hintText: "Name",
                            controller: nameController,
                            icon: Icons.person,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          // Repeat for other input fields
                          buildInputFieldWithIcon(
                            hintText: "Email",
                            controller: emailController,
                            icon: Icons.email,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your email';
                              } else if (!value.contains("@mul.edu.pk")) {
                                return 'Please enter your @mul.edu.pk address';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          // Repeat for other input fields
                          buildInputFieldWithIcon(
                            hintText: "Mobile No",
                            controller: mobileController,
                            icon: Icons.phone,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your mobile number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          // Repeat for other input fields
                          buildInputFieldWithIcon(
                            hintText: "Address",
                            controller: addressController,
                            icon: Icons.location_on,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          // Repeat for other input fields
                          buildInputFieldWithIcon(
                            hintText: "Password",
                            controller: passwordController,
                            icon: Icons.lock,
                            obscureText: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          // Repeat for other input fields
                          buildInputFieldWithIcon(
                            hintText: "Confirm Password",
                            controller: confirmPasswordController,
                            icon: Icons.lock,
                            obscureText: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          // Sign Up button
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _submitForm,
                              child: Text("Sign Up"),
                            ),
                          ),
                          SizedBox(height: 20),

                          // Login text and link
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(LoginScreen.routeName);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Already have an Account?"),
                                Text(
                                  "Login",
                                  style: TextStyle(
                                    color: AppColor.purple,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputFieldWithIcon({
    String hintText,
    TextEditingController controller,
    IconData icon,
    bool obscureText = false,
    Function validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(icon),
          ),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
              controller: controller,
              obscureText: obscureText,
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SignUpScreen(),
  ));
}
