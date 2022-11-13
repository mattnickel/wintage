import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screen_widgets/signup_login_widgets.dart';

import '../popups/terms_popup.dart';
import '../services/api_login.dart';
import 'login_screen.dart';


class SignupScreen extends StatefulWidget {
  final String errorMessage;
  SignupScreen(this.errorMessage);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormBuilderState> _formBKey = GlobalKey<FormBuilderState>();
  late SharedPreferences prefs;
  late Image backgroundImage;
  bool _isLoading = false;
  bool accepted= true;
  late String privacyInfo;
  late String termsInfo;
  bool _showGroup = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  void initState() {
    super.initState();
    bool _isEnabled = false;
    // Start listening to changes.
    emailController.addListener(_enableSignin);
    passwordController.addListener( _enableSignin);
  }
  _enableSignin() {
    setState(() {
      bool _isEnabled = true;
    });
  }
  Future<String> loadAsset(String s) async {
    return await rootBundle.loadString(s);
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
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
                      child: Text("Signing Up...",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          )),
                    )
                  ],
                )) : ListView(
              children: <Widget>[
                headerSection(context, "Get Better."),
                returningUserSection(context),
                Padding(padding: EdgeInsets.only(top:300)),
                signupFormSection(),
                errorSection(widget.errorMessage),
                buttonSection(),

              ],
            ),
          ),
          checkboxSection(),
        ],
      ),
    );
  }

  Positioned checkboxSection(){
    return Positioned(
        bottom: 0,
        right: 0,
        child: Container(
            padding: EdgeInsets.only(top:20),
            width: MediaQuery.of(context).size.width,
            child: Stack(children: [
              Container(
                width:MediaQuery.of(context).size.width,
                color: Colors.black54,
                padding: EdgeInsets.only(top:5.0, bottom:15, left:50, right:10),
                child: RichText(
                  // textAlign: TextAlign.center,
                    text:TextSpan(
                        text: "I accept the ",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: "Terms of Use",
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () async {
                                  termsInfo = await rootBundle.loadString('assets/text/terms.txt');
                                  await showDialog(
                                      context:context,
                                      builder:(BuildContext context){
                                        return termsPopup("Terms of Use", termsInfo, context);
                                      }
                                  );
                                },
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              )
                          ),
                          TextSpan(
                            text: " and ",
                          ),
                          TextSpan(
                              text: "Privacy Policy,",
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () async{
                                  privacyInfo = await rootBundle.loadString('assets/text/privacy.txt');
                                  await showDialog(
                                      context:context,
                                      builder:(BuildContext context){
                                        return termsPopup("Privacy Policy", privacyInfo, context);
                                      }
                                  );

                                },
                              style: TextStyle(
                                decoration: TextDecoration.underline,)
                          ),
                          TextSpan(
                            text: " and I understand that there is no tolerance for objectionable content or abusive users.",
                          ),
                        ]
                    )
                ),
              ),

              Checkbox(
                  value: accepted,
                  onChanged: (val){
                    setState(() {
                      accepted=val!;
                    });
                  }),
            ],)
        )
    );
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        onPressed: emailController.text == "" || passwordController.text == "" || accepted== false ? null : () {

          if (_formBKey.currentState?.validate()!=null) {
            print("valid");
            signUp(emailController.text, passwordController.text, context);
            setState(() {
              _isLoading = true;
            });
          }
          else print("not valid");

        },

        child:
        _isLoading
            ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),)
            :Text("Sign Up", style: TextStyle(color: Colors.white)),
      ),
    );
  }
  Container passwordInfoSection(){
    return Container(
      // width: MediaQuery.of(context).size.width,
      // height: 40.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
              "Password must have 6 characters, upper & lower case letters, numbers, and symbols.",
              style: TextStyle(color: Colors.white70, fontSize: 10)
          ),
        )
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
  Container signupFormSection() {
    return Container(
      constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
      padding: EdgeInsets.only(top: 5, bottom: 10, left:20, right:20),
      child: FormBuilder(
        key: _formBKey,
        child: Column(
          children: <Widget>[

            Container(
              alignment: Alignment.center,
              child: FormBuilderTextField(
                controller: emailController,
                validator: FormBuilderValidators.email(),
                cursorColor: Colors.black54,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.black54),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
                  prefixIcon: Icon(Icons.email, color: Colors.black54),
                  filled:true,
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  hintText: "Email",
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    borderSide: BorderSide(color: Color(00000000)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    borderSide: BorderSide(color: Color(0xff00eebc)),
                  ),
                  hintStyle: TextStyle(color: Colors.black54),
                ), name: "email",
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              child: FormBuilderTextField(
                name:"password",
                controller: passwordController,
                validator:FormBuilderValidators.match(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#%\$&*~]).{8,}$', errorText: "Invalid password: A capital letter, number, and symbol required"),
                cursorColor: Colors.black54,
                obscureText: true,
                style: TextStyle(color: Colors.black54),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
                  prefixIcon: Icon(Icons.lock, color: Colors.black54),
                  filled:true,
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  hintText: "Password",
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    borderSide: BorderSide(color: Color(00000000)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    borderSide: BorderSide(color: Color(0xff00eebc)),
                  ),
                  hintStyle: TextStyle(color: Colors.black54),
                ),
              ),
            ),

            SizedBox(height: 10.0),
            passwordInfoSection(),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }


}

