import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tib_talash/helpers/constants.dart';
import 'package:tib_talash/helpers/routes.dart';

class SplashView extends StatefulWidget {

  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin<SplashView> {

  late AnimationController controller2;
  late Animation<double> animation2;

  @override
  void initState() {
    super.initState();
    controller2 = AnimationController(vsync: this, duration: const Duration(seconds: 4));

    controller2.forward();

    animation2 = CurvedAnimation(parent: controller2, curve: Curves.easeInOut);

    controller2.addListener(() {
      setState(() {
        animation2.value;
        if(controller2.isCompleted) {
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        }
      });
    });
  }

  @override
  void dispose() {
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Theme.of(context).appBarTheme.systemOverlayStyle!,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        color: greenPalette.shade600,
        child: FadeTransition(
          opacity: animation2,
          child: Image.asset('assets/logos/logos.png', fit: BoxFit.fill,),
        ),
      ),
    );
  }
}