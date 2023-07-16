import 'package:flutter/material.dart';
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

  void _submitForm() async {
    if (_formKey.currentState.validate()) {
      String baseurl = BaseUrl().baseUrl;
      final Uri apiUrl = Uri.parse('$baseurl/api/customer/register');
      final response = await http.post(
        apiUrl,
        body: {
          'name': nameController.text,
          'email': emailController.text,
          'mobile': mobileController.text,
          'address': addressController.text,
          'password': passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        // Successful registration
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      } else {
        // Registration failed
        // Handle the error here
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
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Name",
                            ),
                            controller: nameController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Email",
                            ),
                            controller: emailController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your email';
                              } else if (!value.contains("@mul.edu.pk")) {
                                return 'Please enter your @mul.edu.pk address';
                              }

                              // You can add additional email validation if needed
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Mobile No",
                            ),
                            controller: mobileController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your mobile number';
                              }
                              // You can add additional mobile number validation if needed
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Address",
                            ),
                            controller: addressController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Password",
                            ),
                            obscureText: true,
                            controller: passwordController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Confirm Password",
                            ),
                            obscureText: true,
                            controller: confirmPasswordController,
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
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        child: Text("Sign Up"),
                      ),
                    ),
                    SizedBox(height: 20),
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
            ),
          ),
        ),
      ),
    );
  }
}
