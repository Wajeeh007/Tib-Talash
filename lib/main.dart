import 'package:flutter/material.dart';
import 'package:tib_talash/screens/user_screens/feature_screens/doctorsList.dart';
import 'screens/user_screens/feature_screens/pharmacy.dart';
import 'screens/user_screens/HomePage.dart';
import 'constants.dart';
import 'screens/user_screens/signup&login/login.dart';
import 'screens/user_screens/signup&login/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/welcome_screen.dart';
import 'screens/user_screens/feature_screens/findSpecialist.dart';
import 'screens/dr_screens/signup&login/dr_login.dart';
import 'screens/dr_screens/signup&login/dr_signup_1.dart';
import 'screens/dr_screens/HomePage.dart';
import 'screens/dr_screens/feature_screens/ChatScreen.dart';
import 'screens/dr_screens/signup&login/dr_signup_2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCkohub0Aj3NK4vejpn0d3cUD1fYK2-IUQ",
          appId: "com.example.tib_talash",
          messagingSenderId: "12531180510",
          projectId: "tib-talash-4fac9",
          storageBucket: "tib-talash-4fac9.appspot.com"
      )
  );
  runApp(TibTalash());
}

class TibTalash extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: primColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: WelcomeScreen.welcomeID,
      routes: {
        WelcomeScreen.welcomeID: (context) => WelcomeScreen(),
        HomePage.homeID: (context) => HomePage(),
        signup.SignID: (context) => signup(),
        dr_login.dr_loginID: (context) => dr_login(),
        login.loginID: (context) => login(),
        pharmacy.pharmacyID: (context) => pharmacy(),
        findSpecialist.findSpecialistID: (context) => findSpecialist(),
        doctorsList.doctorsListID: (context) => doctorsList(''),
        dr_signup_1.dr_signupID: (context) => dr_signup_1(),
        dr_homePage.dr_homePageID: (context) => dr_homePage(),
        chatScreen.chatScreenID: (context) => chatScreen('', '', ''),
        dr_signup_2.signup_2ID: (context) => dr_signup_2(),
      },
    );
  }
}
