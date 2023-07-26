import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medicine_reminder/constants/assets.dart';
import 'package:medicine_reminder/constants/colors.dart';

import '../home/home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      text: "Your Personal\n",
                      style: TextStyle(
                        color: AppColor.whiteColor,
                        fontFamily: 'PM',
                        fontSize: 30,
                      ),
                      children: [
                        TextSpan(text: "Drug Cabinet"),
                      ])),
            ),
            Lottie.asset(Images.welcomeLottie),
            const Text(
              "Be in control of your meds",
              style: TextStyle(
                  color: AppColor.whiteColor, fontSize: 20, fontFamily: 'PR'),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: AppColor.cardColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                        text: "Get Started  ",
                        style: TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 22,
                          fontFamily: 'PM',
                        ),
                        children: [
                          WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 3),
                              child: Icon(
                                Icons.arrow_forward_sharp,
                                color: AppColor.whiteColor,
                              ),
                            ),
                          )
                        ]),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
