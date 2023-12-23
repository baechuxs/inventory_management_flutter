import 'dart:async';
import 'package:flutter/material.dart';
import 'package:storeit/pages/dashboard.dart';
import 'package:storeit/oop_pillars/abstract_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const Dashboard()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AccentColor().getColor(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/STOREIT!.png',
              height: 500,
            ),
            const SizedBox(
              height: 20,
            ),
            const CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
