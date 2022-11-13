

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import '../framework.dart';

import '../screen_widgets/signup_login_widgets.dart';
import '../services/api_login.dart';



class LoginScreen extends StatefulWidget {
  final String errorMessage;
  const LoginScreen(this.errorMessage);
  @override

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late SharedPreferences prefs;
  late Image backgroundImage;
  bool _isLoading = false;
  bool _isEnabled = false;

  late String privacyInfo;
  late String termsInfo;
  Future<String> loadAsset(String s) async {
    return await rootBundle.loadString(s);
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getEmail();
    // Start listening to changes.
    emailController.addListener(_enableSignin);
    passwordController.addListener(_enableSignin);
  }
  _getEmail() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString("email");
    if (email != null) {
      print("here");
      setState(() {
        emailController.text = email;
      });

    }
  }
  _enableSignin() {
    setState(() {
      _isEnabled = true;
    });
  }
  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 0),
      child: ElevatedButton(
        onPressed:  emailController.text == "" || passwordController.text == "" ? null : () {
          setState(() {
            _isLoading = true;
          });
          signIn(emailController.text, passwordController.text, context, prefs);
        },

        child: Text("Sign In", style: TextStyle(color: Colors.white)),

      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(

            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/gobig.png'),
                    fit:BoxFit.cover
                )
            ),
            child: _isLoading ? Center (
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black54),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("Logging In...",
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                          )),
                    )
                  ],
                )) : ListView(
              children: <Widget>[
                headerSection(context, "Get back to it."),
                newUserSection(context),
                Padding(padding: EdgeInsets.only(top:300)),
                formSection(emailController, passwordController),
                errorSection(widget.errorMessage),
                buttonSection(),
                forgotPasswordSection(context),

              ],
            ),

          ),
          termsSection(privacyInfo, termsInfo, context),
        ],
      ),

    );
  }







  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }



}




