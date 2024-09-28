import 'dart:developer';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mentor_app/Components/api.dart';
import 'package:mentor_app/Models/login.dart';
import 'package:mentor_app/Packages/fade_transition/proste_route_animation.dart';
import 'package:mentor_app/Pages/profile.dart';
import 'package:mentor_app/Storage/storage_service.dart';
import 'package:mentor_app/Utils/color.dart';
import 'package:mentor_app/Pages/home.dart';
import 'package:mentor_app/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginModule? loginModule;
  @override
  void initState() {
    // redirect();
    super.initState();
  }

  redirect() async {
    String? token = await StorageService().getStringData('token');

    bool isTokenEmpty = token?.isEmpty ?? true;

    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) =>
              isTokenEmpty ? const LoginPage() : const HomePage(),
        ),
        (route) => false,
      );
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            color: mainColor,
          ),
          Center(
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: width,
              height: 50,
              margin: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
              child: ElevatedButton(
                onPressed: googleSignIn,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side:
                          BorderSide(color: Colors.grey.shade400, width: 0.6)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/google.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Sign In with Google",
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  googleSignIn() async {
    BotToast.showLoading();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      await googleSignIn.signOut();
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        print(googleUser.displayName);
        print(googleUser.email.toString());
      } else {
        print('Google Sign-In canceled or failed');
        BotToast.closeAllLoading();
        return;
      }

      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      log(googleAuth.accessToken.toString());

      await StorageService().saveStringData(
          key: 'accessToken', data: googleAuth.accessToken.toString());

      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        dynamic response = await apiPost(path: '/mentor/login', login: true);
        loginModule = LoginModule.fromJson(response['data']);

        await StorageService()
            .saveStringData(key: 'name', data: loginModule?.name ?? '');
        await StorageService().saveStringData(
            key: 'profile_img', data: loginModule?.profileImg ?? '');
        await StorageService()
            .saveStringData(key: 'email', data: googleUser.email ?? '');
        await StorageService()
            .saveStringData(key: 'id', data: loginModule?.id ?? '');
        await StorageService()
            .saveStringData(key: 'role', data: loginModule?.role ?? '');

        String? role = await StorageService().getStringData('role');
        String? id = await StorageService().getStringData('id');
        log(role!);
        BotToast.closeAllLoading();

        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            ProsteRouteAnimation(
              builder: (context) => role == 'Admin'
                  ? const HomePage()
                  : ProfilePage(rollno: '$id'),
            ),
            (route) => false,
          );
        }
        if (mounted) {
          setState(() {});
        }

        return;
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: 'User not found');
        log('User not found');
        setState(() {});

        return;
      }
    } catch (e) {
      BotToast.closeAllLoading();
      log(e.toString());
    }
  }
}
