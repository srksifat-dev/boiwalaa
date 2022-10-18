// import 'dart:math';

// import 'package:boiwalaa/view/auth_screen/otp_dialog.dart';
// import 'package:flutter_svg/svg.dart';

// import '/controller/auth_controller.dart';
// import '/view/auth_screen/signin_form.dart';
// import '/view/auth_screen/signup_form.dart';
// import '/view/theme/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:velocity_x/velocity_x.dart';

// class AuthScreen extends StatefulWidget {
//   const AuthScreen({Key? key}) : super(key: key);

//   @override
//   _AuthScreenState createState() => _AuthScreenState();
// }

// class _AuthScreenState extends State<AuthScreen>
//     with SingleTickerProviderStateMixin {
//   final authController = Get.put(AuthController());
//   late AnimationController _animationController;
//   late Animation<double> _animationTextRotate;
//   final contactNumberFocusNode = FocusNode();
//   final passwordFocusNode = FocusNode();
//   final nameFocusNode = FocusNode();
//   final confirmPasswordFocusNode = FocusNode();
//   final TextEditingController demoController = TextEditingController();

//   bool _isShowSignUp = false;

//   @override
//   void initState() {
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(
//         milliseconds: 300,
//       ),
//     );
//     _animationTextRotate =
//         Tween<double>(begin: 0, end: 90).animate(_animationController);
//     super.initState();
//   }

//   void updateView() {
//     setState(() {
//       _isShowSignUp = !_isShowSignUp;
//     });
//     _isShowSignUp
//         ? _animationController.forward()
//         : _animationController.reverse();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         contactNumberFocusNode.unfocus();
//         passwordFocusNode.unfocus();
//         confirmPasswordFocusNode.unfocus();
//         nameFocusNode.unfocus();
//       },
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: AnimatedBuilder(
//             animation: _animationController,
//             builder: (context, _) {
//               return Stack(
//                 children: [
//                   //Sign in Screen

//                   AnimatedPositioned(
//                     duration: const Duration(milliseconds: 300),
//                     width: context.percentWidth * 88,
//                     height: context.percentHeight * 100,
//                     left: _isShowSignUp ? -context.percentWidth * 76 : 0,
//                     child: Container(
//                       color: AppColors.mediumAmber,
//                       child: SignInForm(
//                         contactNumberFocusNode: contactNumberFocusNode,
//                         passwordFocusNode: passwordFocusNode,
//                       ),
//                     ),
//                   ),

//                   //Sign up screen

//                   AnimatedPositioned(
//                     duration: const Duration(milliseconds: 300),
//                     width: context.percentWidth * 88,
//                     height: context.percentHeight * 100,
//                     left: _isShowSignUp
//                         ? context.percentWidth * 12
//                         : context.percentWidth * 88,
//                     child: Container(
//                       color: AppColors.lightAmber,
//                       child: SignUpForm(
//                         contactNumberFocusNode: contactNumberFocusNode,
//                         passwordFocusNode: passwordFocusNode,
//                         confirmPasswordFocusNode: confirmPasswordFocusNode,
//                         nameFocusNode: nameFocusNode,
//                       ),
//                     ),
//                   ),

//                   //boiwalaa logo

//                   AnimatedPositioned(
//                     duration: const Duration(milliseconds: 300),
//                     top: context.percentHeight * 6,
//                     left: _isShowSignUp
//                         ? context.percentWidth * 30
//                         : context.percentWidth * 18,
//                     right: _isShowSignUp
//                         ? context.percentWidth * 18
//                         : context.percentWidth * 30,
//                     child: SvgPicture.asset(
//                       "assets/images/boiwalaa-svg.svg",
//                       alignment: Alignment.topCenter,
//                       height: context.percentHeight * 15,
//                     ),
//                   ),

//                   // Google and Facebook Sign In an Sign Up

//                   // AnimatedPositioned(
//                   //   duration: const Duration(milliseconds: 300),
//                   //   bottom: context.percentHeight * 5,
//                   //   left: _isShowSignUp
//                   //       ? context.percentWidth * 25
//                   //       : context.percentWidth * 13,
//                   //   right: _isShowSignUp
//                   //       ? context.percentWidth * 13
//                   //       : context.percentWidth * 25,
//                   //   child: SizedBox(
//                   //     height: context.percentHeight * 10,
//                   //     // width: context.percentWidth * 10,
//                   //     child: Column(
//                   //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //       children: [
//                   //         _isShowSignUp
//                   //             ? "or Sign Up with"
//                   //                 .text
//                   //                 .color(AppColors.green)
//                   //                 .makeCentered()
//                   //             : "or Sign In with"
//                   //                 .text
//                   //                 .color(AppColors.green)
//                   //                 .makeCentered(),
//                   //         Row(
//                   //           mainAxisAlignment: MainAxisAlignment.center,
//                   //           children: [
//                   //             CircleAvatar(
//                   //               backgroundColor: Colors.white,
//                   //               radius: context.percentWidth * 6,
//                   //               child: const Center(
//                   //                 child: FaIcon(
//                   //                   FontAwesomeIcons.google,
//                   //                   color: AppColors.green,
//                   //                 ),
//                   //               ),
//                   //             ),
//                   //             WidthBox(context.percentWidth * 5),
//                   //             CircleAvatar(
//                   //               backgroundColor: Colors.white,
//                   //               radius: context.percentWidth * 6,
//                   //               child: const Center(
//                   //                 child: FaIcon(
//                   //                   FontAwesomeIcons.facebook,
//                   //                   color: AppColors.green,
//                   //                 ),
//                   //               ),
//                   //             ),
//                   //           ],
//                   //         ),
//                   //       ],
//                   //     ),
//                   //   ),
//                   // ),

//                   // Sign In and Sign Up

//                   AnimatedPositioned(
//                     duration: const Duration(milliseconds: 300),
//                     top: _isShowSignUp
//                         ? context.percentHeight * 50 + 100
//                         : context.percentHeight * 25,
//                     left: _isShowSignUp
//                         ? context.percentWidth * 2
//                         : context.percentWidth * 44 - 100,
//                     child: AnimatedDefaultTextStyle(
//                       duration: const Duration(milliseconds: 300),
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: _isShowSignUp
//                             ? context.percentWidth * 6
//                             : context.percentWidth * 10,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                       child: Transform.rotate(
//                         angle: -_animationTextRotate.value * pi / 180,
//                         alignment: Alignment.topLeft,
//                         child: InkWell(
//                           onTap: updateView,
//                           child: const SizedBox(
//                             width: 200,
//                             child: Text("SIGN IN"),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),

//                   AnimatedPositioned(
//                     duration: const Duration(milliseconds: 300),
//                     top: !_isShowSignUp
//                         ? context.percentHeight * 50 + 100
//                         : context.percentHeight * 25,
//                     right: !_isShowSignUp
//                         ? context.percentWidth * 2
//                         : context.percentWidth * 44 - 100,
//                     child: AnimatedDefaultTextStyle(
//                       duration: const Duration(milliseconds: 300),
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: !_isShowSignUp
//                             ? context.percentWidth * 6
//                             : context.percentWidth * 10,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                       child: Transform.rotate(
//                         angle: (90 - _animationTextRotate.value) * pi / 180,
//                         alignment: Alignment.topRight,
//                         child: InkWell(
//                           onTap: updateView,
//                           child: const SizedBox(
//                             width: 200,
//                             child: Text("SIGN UP"),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             }),
//       ),
//     );
//   }
// }
