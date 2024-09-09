import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tib_talash/helpers/routes.dart';
import 'package:tib_talash/helpers/theme_helpers.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCkohub0Aj3NK4vejpn0d3cUD1fYK2-IUQ",
          appId: "com.example.tib_talash",
          messagingSenderId: "12531180510",
          projectId: "tib-talash-4fac9",
          storageBucket: "tib-talash-4fac9.appspot.com"
      )
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const TibTalash());
}

class TibTalash extends StatelessWidget {

  const TibTalash({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeHelpers.lightTheme,
      darkTheme: ThemeHelpers.darkTheme,
      initialRoute: AppRoutes.initialRoute,
      onGenerateRoute: AppRoutes().generateRoute,
    );
  }
}
