import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vsc/pages/login_page.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  late final AnimationController _controller;
  bool isDarkMode = false;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 9), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(''),
        Lottie.network(
          'https://lottie.host/62d455b4-3ade-4b88-873e-31a57336c005/7mVr2tR2th.json',
        ),
      ],
    ));
  }
}
