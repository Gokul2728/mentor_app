import 'package:flutter/material.dart';
import 'package:mentor_app/Auth/login.dart';
import 'package:mentor_app/Utils/color.dart';
import 'package:mentor_app/Pages/home.dart';

import 'Packages/fade_transition/proste_route_animation.dart';
import 'Storage/storage_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    redirect();
    super.initState();
  }

  redirect() async {
    // String? accessToken = await StorageService().getStringData('accessToken');
    String? token = await StorageService().getStringData('token');
    //
    if (token == null || token == '' || token.toString().isEmpty) {
      await Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
            context,
            ProsteRouteAnimation(
              builder: (context) => const LoginPage(),
            ),
            (route) => false);
      });
    } else {
      await Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
            context,
            ProsteRouteAnimation(
              builder: (context) => const HomePage(),
            ),
            (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
          child: Container(
        height: 150,
        width: 150,
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: Image.asset(
            'assets/images/bit.jpg',
            fit: BoxFit.contain,
          ),
        ),
      )),
    );
  }
}
