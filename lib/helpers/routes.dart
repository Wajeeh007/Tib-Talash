import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tib_talash/screens/auth/login/login_view.dart';

import '../screens/splash/splash_view.dart';

class AppRoutes {

  static const initialRoute = 'initial_route';
  static const login = 'login';
  static const signup = 'sign_up';

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case initialRoute:
        return _navigateAndAddProvider(screenWidget: const SplashView(),);
      case login:
        return _navigateAndAddProvider(screenWidget: const LoginView(),);
      default:
        return MaterialPageRoute(builder: (builder) => const Scaffold(
          body: Center(
            child: Text(
              'No Route Found'
            ),
          ),
        ));
    }
  }
  
  Route<dynamic> _navigateAndAddProvider({required Widget screenWidget, Bloc? bloc}) {
    return MaterialPageRoute(builder: (context) {
      if(bloc != null) {
        return BlocProvider(
            create: (_) => bloc,
          child: screenWidget,
        );
      } else {
        return screenWidget;
      }
    });
  }
}