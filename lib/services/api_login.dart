import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:async' show Future;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


import '../framework.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';

import '../main.dart';
import 'api_url.dart';


Future setLocals(response) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var jsonResponse = json.decode(response.body);
  String userId = jsonResponse["id"].toString();
  print("setting locals");
  String authToken = jsonResponse["authentication_token"] as String;
  String userEmail = jsonResponse["email"] as String;
  String username = jsonResponse["username"] as String;
  print (username);
  final storage = FlutterSecureStorage();
  await storage.write(key:"token", value: authToken);
  await storage.write(key:"email", value: userEmail);
  prefs.setString("userId", userId);
  prefs.setString("username", username);
  prefs.setString("email", userEmail);
  return null;
}
Future signIn(String email, String pass, context, prefs) async {

  String errorMessage;
  Uri loginUrl =  Uri.parse("$apiUrl/api/v1/login");
  print(loginUrl);
  final response = await http.post(

    loginUrl,
    headers: {"Accept": "Application/json"},
    body: {"email": email, "password": pass},

  );
  if(response.statusCode == 200){
    print(response.body);
    await setLocals(response);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Framework()), (Route<dynamic> route) => false);
  }else{
    print("nope");
    errorMessage = "Oops... incorrect email or password";
    print(response.body);
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LoginScreen(errorMessage)));
  }
}


Future signUp(String email, String pass, context) async {

  Uri signUpUrl = Uri.parse('$apiUrl/api/v1/signup');
  final response = await http.post(
    signUpUrl,
    headers: {"Accept": "Application/json"},
    body: {"email":email, "password":pass,},
  );
  if(response.statusCode == 200) {
    await setLocals(response);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Framework()), (Route<dynamic> route) => false);

  }else{
    print("nope");
    print(response.body);
    var jsonMessage = json.decode(response.body);
    String error = jsonMessage["error"].toString();
    print(error);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupScreen(error)));
  }
}
Future signOut(context) async {

  final storage = FlutterSecureStorage();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userEmail = await storage.read(key: "email");
  Uri signoutUrl = Uri.parse('$apiUrl/logout');
  await http.post(
    signoutUrl,
    headers: {"Accept": "Application/json"},
    body: {"email":userEmail},
  );
  await storage.deleteAll();
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MyApp()), (Route<dynamic> route) => false);
}

Future createVerificationCode(email)async{
  String params = "email="+email;
  Uri url = Uri.parse('$apiUrl' + 'passwords/forgot?'+params);
  var response = await http.get(
    url,
    headers: {"Accept": "Application/json"},
  );
  if(response.statusCode == 200) {
    print(response.body);
    return true;
  }else{
    print("nope");
    print(response.body);
    return false;
  }
}

Future confirmReset(code)async{
  final storage = FlutterSecureStorage();


  String params = "verify="+code;

  Uri url = Uri.parse(apiUrl + 'passwords/confirm?'+params);
  var response = await http.get(
    url,
    headers: {"Accept": "Application/json"},
  );
  if(response.statusCode == 200) {
    await storage.write(key:"resetToken", value: code);
    print(response.body);
    return true;
  }else{
    print("nope");
    print(response.body);
    return false;
  }
}
Future setPasswordAndLogin(password, context) async{
  final storage = FlutterSecureStorage();
  String? resetToken= await storage.read(key:"resetToken");
  Uri url = Uri.parse(apiUrl + 'passwords/reset');

  final response = await http.put(
    url,
    headers: {"Accept": "Application/json"},
    body: {"reset":resetToken, "password":password},
  );
  if(response.statusCode == 200) {
    await setLocals(response);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Framework()), (Route<dynamic> route) => false);
    print(response.body);
    return true;
  }else{
    print("nope");
    print(response.body);
    return false;
  }
}