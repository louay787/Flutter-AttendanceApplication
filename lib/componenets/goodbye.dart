import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vsc/pages/login_page.dart';

class GoodBye extends StatefulWidget {
  const GoodBye({super.key});

  @override
  State<GoodBye> createState() => _GoodBye();
}

class _GoodBye extends State<GoodBye> {
  late final AnimationController _controller;
  bool isDarkMode = false;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Lottie.network(
          'https://lottie.host/692ba18c-cade-4e83-87d4-2fc5662f7b64/gq1GfsS79K.json',
        ),
      ],
    ));
  }
}
