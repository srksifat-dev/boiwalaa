import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:boiwalaa/controller/network_controller.dart';
import 'package:flutter_svg/svg.dart';

import '/controller/auth_controller.dart';
import '/view/auth_screen/signin_form.dart';
import '/view/auth_screen/signup_form.dart';
import '/view/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final authController = Get.put(AuthController());
  final networkController = Get.find<NetworkController>();
  final contactNumberFocusNode = FocusNode();

  // @override
  // void dispose() {
  //   _animationController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        contactNumberFocusNode.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.mediumAmber,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: context.percentHeight * 10,
                left: 0,
                right: 0,
                child: SlideInUp(
                  duration: const Duration(milliseconds: 1000),
                  from: context.percentHeight * 40,
                  child: SvgPicture.asset(
                    "assets/images/boiwalaa-svg.svg",
                    alignment: Alignment.topCenter,
                    height: context.percentWidth * 50,
                  ),
                ),
              ),

              // Form
              Positioned(
                top: context.percentHeight * 35,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: context.percentHeight * 25,
                  width: context.percentWidth * 76,
                  child: ZoomIn(
                    delay: const Duration(milliseconds: 1000),
                    duration: const Duration(milliseconds: 600),
                    child: SignInForm(
                      contactNumberFocusNode: contactNumberFocusNode,
                    ),
                  ),
                ),
              ),
              Obx(() => Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: networkController.connectionStatus.value == 0
                      ? MaterialBanner(
                          leading: const Icon(
                            Icons.info,
                            color: Colors.black,
                          ),
                          backgroundColor: Colors.amber,
                          content: "You have no Internet Connection."
                              .text
                              .black
                              .make(),
                          actions: [
                              TextButton(onPressed: () {}, child: Text(""))
                            ])
                      : Container()))

              // Google and Facebook authentication
              // Positioned(
              //   bottom: context.percentHeight * 10,
              //   left: 0,
              //   right: 0,
              //   child: SizedBox(
              //     height: context.percentHeight * 10,
              //     // width: context.percentWidth * 10,
              //     child: ZoomIn(
              //       delay: const Duration(milliseconds: 1000),
              //       duration: const Duration(milliseconds: 600),
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           "or Continue with"
              //               .text
              //               .color(AppColors.green)
              //               .makeCentered(),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               GestureDetector(
              //                 onTap: (){},
              //                 child: CircleAvatar(
              //                   backgroundColor: Colors.white,
              //                   radius: context.percentWidth * 6,
              //                   child: const Center(
              //                     child: FaIcon(
              //                       FontAwesomeIcons.google,
              //                       color: AppColors.green,
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //               WidthBox(context.percentWidth * 5),
              //               CircleAvatar(
              //                 backgroundColor: Colors.white,
              //                 radius: context.percentWidth * 6,
              //                 child: const Center(
              //                   child: FaIcon(
              //                     FontAwesomeIcons.facebook,
              //                     color: AppColors.green,
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
