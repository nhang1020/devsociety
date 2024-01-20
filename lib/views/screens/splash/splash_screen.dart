import 'dart:async';

import 'package:devsociety/controllers/AuthController.dart';
import 'package:devsociety/views/utils/variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    continueLogin();
  }

  Future continueLogin() async {
    Timer(Duration(seconds: 1), () {
      AuthController(context: context).continueLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Logo(),
            SizedBox(height: 10),
            SpinKitThreeBounce(
              color: myColor.withOpacity(.5),
              size: 30,
            )
          ],
        ),
      ),
    );
  }
}
