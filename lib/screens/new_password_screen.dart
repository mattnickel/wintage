import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../services/api_login.dart';



class NewPassword extends StatefulWidget {

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  bool isLoading = false;
  late String errorMessage;
  final newPassController = TextEditingController();
  final GlobalKey<FormBuilderState> _formCKey = GlobalKey<FormBuilderState>();
  @override

  Widget build(BuildContext context) {


    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/adventure3.png'),
                fit:BoxFit.cover
            )
        ),
        child: ListView(
          children: <Widget>[
            headerSection(context),
            formSection(),
            errorSection(),
            buttonSection(context),

          ],
        ),
      ),
    );
  }



  Container errorSection() {
    return Container(
      child:
      errorMessage != null
          ? Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline), SizedBox(width: 5.0),
                Text(
                    errorMessage
                ),
              ],
            ),
          ))
          : null,
    );
  }

  Container buttonSection(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 0),
      child: ElevatedButton(

        onPressed: newPassController.text==""? null :()async {
          setState(() {
            isLoading = true;
          });
          if (_formCKey.currentState?.validate() !=false) {
            await setPasswordAndLogin(newPassController.text, context);
          }else{
            setState(() {
              isLoading = false;
            });
          }
        },

        child: isLoading
            ? CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),)
            :Text("Change password and login", style: TextStyle(color: Colors.white)),

      ),
    );
  }

  Container formSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child:FormBuilder(
        key: _formCKey,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: FormBuilderTextField(
                controller: newPassController,
                validator:FormBuilderValidators.match(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$', errorText: "Invalid password: A capital letter, number, and symbol required"),
                onChanged: (val){
                  setState(() {

                  });
                },
                obscureText: true,
                cursorColor: Colors.black54,
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.black54),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
                  prefixIcon: Icon(Icons.lock, color: Colors.black54),
                  filled:true,
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  hintText: "New Password",
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
                ), name: 'New Password',
              ),
            ),


          ],
        ),
      ),
    );
  }

  Column headerSection(context) {
    return Column(
      children: [
        Container(
          padding:EdgeInsets.only(top:30),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              icon: Icon(Icons.arrow_back),
              label: Text("Back"),
              onPressed:(){
                Navigator.pop(context);
              },

            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 60.0),
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: [

              Align(
                alignment: Alignment.centerLeft,
                child: Text("New Password",
                    style: TextStyle(
                        color: Color(0xff606060),
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold
                    )
                ),
              ),
              Text("Enter a new password and we will automatically log you in. Password must have 6 characters, upper & lower case letters, numbers, and symbols.",
                  style: TextStyle(
                    color: Colors.black45,)
              )
            ],
          ),
        ),
      ],
    );
  }
}

