import 'package:flutter/material.dart';
import 'package:yeneta_flutter/screens/auth/login_screen.dart';
import 'package:yeneta_flutter/screens/auth/password_reset.dart';
import 'package:yeneta_flutter/screens/auth/register_screen.dart';
import 'package:yeneta_flutter/screens/events/event_details_screen.dart';
import 'package:yeneta_flutter/screens/events/event_list_screen.dart';
import 'package:yeneta_flutter/screens/events/eventhistory.dart';
import 'package:yeneta_flutter/screens/home/homescree.dart';
import 'package:yeneta_flutter/screens/home/splashscreen.dart';
import 'package:yeneta_flutter/screens/home/prelogin.dart';
import 'package:yeneta_flutter/screens/leaderboard/leadreboard.dart';
import 'package:yeneta_flutter/screens/profile/profilescree.dart';
import 'package:yeneta_flutter/screens/score/score_screen.dart';
import 'package:yeneta_flutter/screens/song/songs.dart';
import 'package:yeneta_flutter/screens/stickers/stickers_screen.dart';
import 'package:yeneta_flutter/screens/stories/story_list.dart';
import 'package:yeneta_flutter/screens/superstars/superstars%20_list.dart';

class AppRoutes {
  static const String splash = '/';
  static const String preLogin = '/prelogin';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String events = '/events_list';
  static const String eventDetails = '/event_details';
  static const String eventHistory = '/event_history';
  static const String resetPassword = '/resetPassword';
  static const String stories = '/stories';
  static const String song = '/songs';
  static const String quiz = '/quiz';
  static const String levels = '/levels';
  static const String superstars = '/superstars';
  static const String superstarDetails = '/superstarDetail';
  static const String leaderboard = '/leaders';
  static const String stickers = '/stickers';
  static const String certificates = '/certificates';
  static const String score = '/score';

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
      case profile:
        return MaterialPageRoute(builder: (_) => const Profilescreen());
      case events:
        return MaterialPageRoute(builder: (_) => const EventListScreen());
      case resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPassword());
      case eventDetails:
        return MaterialPageRoute(
          builder: (_) => const EventDetailScreen(event: null),
        );
      case eventHistory:
        return MaterialPageRoute(builder: (_) => const EventHistoryScreen());
      case stories:
        return MaterialPageRoute(builder: (_) => const StoryListScreen());
      case song:
        return MaterialPageRoute(builder: (_) => const SongsScreen());
      case superstars:
        return MaterialPageRoute(builder: (_) => const SuperstarsScreen());
      case superstarDetails:
        return MaterialPageRoute(builder: (_) => const SuperstarsScreen());
      case leaderboard:
        return MaterialPageRoute(builder: (_) => const LeaderboardScreen());
      case score:
        return MaterialPageRoute(builder: (_) => const StudentReportScreen());
      case stickers:
        return MaterialPageRoute(builder: (_) => const MyStickersScreen());

      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
