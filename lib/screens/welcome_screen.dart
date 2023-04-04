import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:tib_talash/constants.dart';
import 'package:tib_talash/screens/dr_screens/signup&login/dr_login.dart';
import 'package:tib_talash/screens/user_screens/signup&login/userLogin.dart';

class WelcomeScreen extends StatefulWidget {
  static const String welcomeID = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {

  late AnimationController controller2, controller3;
  late Animation animation2, animation3;

  @override
  void initState() {
    super.initState();
    controller2 =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    controller3 =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    controller2.forward();
    controller3.reverse(from: 1.0);

    animation2 = CurvedAnimation(parent: controller2, curve: Curves.decelerate);
    animation3 = CurvedAnimation(parent: controller3, curve: Curves.decelerate);

    controller2.addListener(() {
      setState(() {
        animation2.value;
      });
    });
    controller3.addListener(() {
      setState(() {
        animation3.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Welcome To',
                style: kHomeTitleTextStyle.copyWith(fontSize: 20.0,
                    color: Color.fromRGBO(139, 195, 74, animation2.value)),
              ),
              Text('Tib Talash',
                style: kHomeTitleTextStyle.copyWith(fontSize: (animation3.value*17.5)+48,
                    color: const Color.fromRGBO(139, 195, 74, 1.0)),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Column(
                children: [
                  const Text(
                      'Are you a Doctor?',
                    style: const TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                      color: primColor
                    ),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white
                    ),
                    onPressed: (){
                      Navigator.pushNamed(context, dr_login.dr_loginID);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: const Image(
                        image: const AssetImage('images/welcome_screen_logos/Doctor.png',),
                        width: 70.0,
                        height: 70.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                      'Or',
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    onPressed: (){
                      Navigator.pushNamed(context, login.loginID);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: const Image(
                        image: const AssetImage('images/welcome_screen_logos/Patient.png'),
                        height: 70.0,
                        width: 70.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  const Text(
                    'Are you a Patient?',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.0,
                      color: primColor
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}