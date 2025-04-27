import 'package:flutter/material.dart';
import 'package:yeneta_flutter/screens/auth/login_screen.dart';
import 'package:yeneta_flutter/screens/auth/register_screen.dart';
import 'package:yeneta_flutter/screens/home/homescree.dart';
import 'package:yeneta_flutter/screens/home/splashscreen.dart';
import 'package:yeneta_flutter/screens/home/prelogin.dart';

class AppRoutes {
  static const String splash = '/';
  static const String preLogin = '/prelogin';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case preLogin:
        return MaterialPageRoute(builder: (_) => const PreLoginScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}