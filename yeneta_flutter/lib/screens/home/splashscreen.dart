import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:yeneta_flutter/screens/home/prelogin.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: AnimatedSplashScreen(
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset("assets/lottie/Animation_splash.json"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "የ",
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E3E3E),
                  ),
                ),
                Text(
                  "neta",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E3E3E),
                  ),
                ),
              ],
            ),
          ],
        ),
        nextScreen: const PreLoginScreen(),
        backgroundColor: Colors.transparent,
        duration: 3000, // 5 seconds
        splashIconSize: double.infinity,
        splashTransition: SplashTransition.scaleTransition,
        customTween: Tween<double>(begin: 0.8, end: 1.0),
      ),
    );
  }
}
