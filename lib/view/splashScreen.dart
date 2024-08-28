// ignore_for_file: file_names

import 'dart:async';

import 'package:animated_background/animated_background.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_list_firebase/view/readScreen.dart';
import '../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Get.offAll(const ReadScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appbg,
      body: AnimatedBackground(
        behaviour: BubblesBehaviour(
            options: const BubbleOptions(
          bubbleCount: 20,
        )),
        vsync: this,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset("assets/images/Animation.json",
                  width: Get.width / 2, fit: BoxFit.cover),
              ClayContainer(
                color: AppConstants.appbg,
                borderRadius: 10,
                depth: 20,
                spread: 10,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ClayText(
                    'ToDo List',
                    emboss: true,
                    size: 40,
                    style: headingText(AppConstants.textColor2, 48,
                        shadowColor: AppConstants.textColor),
                    textColor: AppConstants.headingColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
