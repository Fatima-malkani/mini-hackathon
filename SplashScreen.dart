
import 'package:flutter/material.dart';
import 'package:project/Screens/Sign_In_Screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate some initialization time, then navigate to the main app screen.
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) =>const SignInScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEB3738),
      body: Center(
        child: Image.asset('assets/images/splash.png'), // Replace with your splash screen image
      ),
    );
  }
}


