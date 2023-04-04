import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'userLogin.dart';
import 'package:tib_talash/screens/user_screens/userHomePage.dart';
import 'package:tib_talash/constants.dart';

class signup extends StatefulWidget {
    static const SignID = "signup_screen";

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'This field is required*'),
    EmailValidator(errorText: 'Enter a valid email address*'),
  ]);
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'This field is required*'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 characters long*')
  ]);

  void updateUI(){
    setState((){
      showSpinner = false;
      Navigator.pop(context);
    });
  }

  bool validateAndSave(){
    final form = formKey.currentState;
    if (form!.validate()){
      form.save();
      return true;
    }
    else{
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave() == true) {
      setState(() {
        showSpinner = true;
      });
      try {
        final newUser = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        if (newUser != null) {
          Navigator.pushReplacementNamed(context, HomePage.homeID);
        }
        setState(() {
          showSpinner = false;
        });
      } on FirebaseAuthException catch (e) {
         if (e.code == 'session-cookie-expired') {
          Alert(context: context,
              title: "Session Expired",
              desc: "Your request took too long. Session has been expired",
              buttons: [
                DialogButton(
                  color: primColor,
                  child: Text(
                    'Retry',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ), onPressed: ()=>updateUI(),
                  width: 140,
                ),
              ]
          ).show();
        } else if (e.code == 'email-already-in-use') {
          Alert(context: context,
              type: AlertType.warning,
              title: "User Exists",
              desc: "Email already in use. Try using a different Email or Log In",
              buttons: [
                DialogButton(
                  color: primColor,
                  child: Text(
                    'Go Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ), onPressed: ()=>updateUI(),
                ),
                DialogButton(
                  color: primColor,
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ), onPressed: (){
                    updateUI();
                    Navigator.pushReplacementNamed(context, login.loginID);
                    },
                ),
              ]
          ).show();
        }else if(e.code=='network-request-failed'){
         Alert(context: context,
         title: "Connection Error",
         desc: "Host is Unreachable because of Network Error or Interrupted connection.\nCheck Your Internet Connection and Retry",
         buttons: [
         DialogButton(
         color: primColor,
         child: Text(
         'Go Back',
         style: TextStyle(
         color: Colors.white,
         fontSize: 20.0,
         ),
    ), onPressed: ()=>updateUI(),
    width: 140,
    ),
    ]).show();
         }
         else {
          Alert(context: context,
              title: "Unexpected Error",
              desc: "Tib Talash encountered an Unexpected error while trying to process your request. \nPlease Retry.",
              buttons: [
                DialogButton(
                  color: primColor,
                  child: Text(
                    'Go Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ), onPressed: ()=>updateUI(),
                  width: 140,
                ),
              ]).show();
        }
      }
      catch (e){}
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LoadingOverlay(
          isLoading: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Text(
                      'Sign Up To',
                  style: kHomeTitleTextStyle.copyWith(fontSize: 20.0),),
                ),
                Flexible(
                  child: Text(
                    'Tib Talash',
                    style: kHomeTitleTextStyle.copyWith(fontSize: 40.0),),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        onChanged: (value){
                          _email = value;
                        },
                        decoration: kloginInputFieldDecoration.copyWith(hintText: 'Enter your Email'),
                        validator: emailValidator,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        onChanged: (value){
                          _password = value;
                        },
                        decoration: kloginInputFieldDecoration.copyWith(hintText: 'Enter your Password'),
                        validator: passwordValidator,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Buttons('Sign Up', () {validateAndSubmit();}, primColor),
                      SizedBox(
                        height: 5.0,
                      ),
                      TextButton(onPressed: (){Navigator.pushReplacementNamed(context, login.loginID);}, child: Text('Already have an account? Log In'))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
