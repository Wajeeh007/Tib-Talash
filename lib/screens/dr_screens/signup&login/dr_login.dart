import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tib_talash/constants.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dr_signup_1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../docHomePage.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class dr_login extends StatefulWidget {
  static const dr_loginID = "dr_login screen";

  @override
  State<dr_login> createState() => _dr_loginState();
}

class _dr_loginState extends State<dr_login> {
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

  dynamic validateAndSubmit() async {
    if (validateAndSave() == true) {
      setState(() {
        showSpinner = true;
      });
      try {
        DocumentSnapshot ds = await _firestore.collection('doctors_data').doc(_email).get();
        if(ds.exists){
          var pass = ds.get('Password');
          if(_password == pass){
            Myid = _email;
            Navigator.pushReplacementNamed(context, dr_homePage.dr_homePageID);
          }
          else{
            return Alert(
                type: AlertType.warning,
                title: "Invalid Password",
                desc: "You entered an incorrect Password",
                context: context,
              buttons: [
               DialogButton(child: Text("Go Back"), onPressed: ()=>updateUI(), width: 140,),
              ]
            ).show();
          }
        }
        else{
          return Alert(
            type: AlertType.info,
            title: "Invalid Email",
            desc: "User doesnot exist. Check if the Email is correct",
            context: context,
            buttons: [
              DialogButton(
                color: primColor,
                child: Text('Retry'),
                onPressed: ()=>updateUI(),
                width: 150,)
            ]
          ).show();
        }
        setState(() {
          userEmail = _email;
          showSpinner = false;
        });
      }
      on FirebaseException catch (e) {
        if (e.code == 'unavailable'){
          return Alert(
            type: AlertType.error,
              title: "Network Error",
              desc: "There seens to be problem with the Nwtwork.\nPlease check your connection and try again",
              context: context,
            buttons: [
              DialogButton(
                color: primColor,
                child: Text('Retry'),
                onPressed: (){
                  updateUI();
                  validateAndSubmit();
                  },
                width: 150,)
            ]
          ).show();
        }
        else{
          return Alert(
            type: AlertType.error,
            title: "Unexpected Error",
            desc: "Tib Talash encountered an Unexpected error. Please retry in a few seconds",
            context: context,
            buttons: [
              DialogButton(child: Text('Retry'), onPressed: (){
                updateUI();
                validateAndSubmit();
              },
                width: 150, color: primColor,)
            ]
          ).show();
        }
      }
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
                      'Log In To',
                      style: kHomeTitleTextStyle.copyWith(fontSize: 20.0),),
                  ),
                  Flexible(
                    child: Text(
                      'Tib Talash',
                      style: kHomeTitleTextStyle.copyWith(fontSize: 40.0),),
                  ),
                  SizedBox(
                    height: 20.0,
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
                        Buttons(
                            'Login',
                                () {
                              validateAndSubmit();
                            },
                            primColor),
                        TextButton(
                            onPressed: ()async{
                               Navigator.pushReplacementNamed(context, dr_signup_1.dr_signupID);
                            },
                            child: Text('Don\'t have an account? Create One.')),
                        TextButton(onPressed: null, child: Text(
                            'Forgot Password?'
                        )),
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

