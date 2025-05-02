import 'package:flutter/material.dart';

class PreLoginScreen extends StatelessWidget {
  const PreLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          children: [
            Image.asset(
              "assets/images/welcome_image.png",
              width: 500,
              height: 400,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed:
                  () => {Navigator.pushReplacementNamed(context, '/login')},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFCB7C), // Button color
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ), // Button padding
                textStyle: const TextStyle(fontSize: 20), // Button text style
              ),
              child: const Text("Login"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  () => {Navigator.pushReplacementNamed(context, '/register')},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(
                  color: const Color(0xFF2CA2B0),
                ), // Button border
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ), // Button padding
                textStyle: const TextStyle(fontSize: 20), // Button text style
              ),
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
