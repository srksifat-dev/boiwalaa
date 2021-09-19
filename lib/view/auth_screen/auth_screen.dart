// import 'dart:math';

// import 'package:animate_do/animate_do.dart';
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

// class _AuthScreenState extends State<AuthScreen> {
//   final authController = Get.put(AuthController());
//   final contactNumberFocusNode = FocusNode();
//   final passwordFocusNode = FocusNode();
//   bool _onlyLogo = true;

//   @override
//   void initState() {
//     Future.delayed(const Duration(milliseconds: 2000)).then((_) {
//       setState(() {
//         _onlyLogo = false;
//       });
//     });
//     // _animationLogoPosition =
//     //     Tween<double>(begin: 0, end: 90).animate(_animationController);
//     super.initState();
//   }

//   // @override
//   // void dispose() {
//   //   _animationController.dispose();
//   //   super.dispose();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         contactNumberFocusNode.unfocus();
//         passwordFocusNode.unfocus();
//       },
//       child: Scaffold(
//           resizeToAvoidBottomInset: false,
//           backgroundColor: AppColors.mediumAmber,
//           body: Stack(
//             children: [
//               AnimatedPositioned(
//                 top: _onlyLogo
//                     ? context.percentHeight * 40
//                     : context.percentHeight * 10,
//                 left: 0,
//                 right: 0,
//                 child: SvgPicture.asset(
//                   "assets/images/boiwalaa-svg.svg",
//                   alignment: Alignment.topCenter,
//                   height: context.percentWidth * 45,
//                 ),
//                 duration: const Duration(milliseconds: 1000),
//               ),
//               _onlyLogo
//                   ? Container()
//                   : Positioned(
//                       top: context.percentHeight * 35,
//                       left: 0,
//                       right: 0,
//                       child: SizedBox(
//                           height: context.percentHeight * 25,
//                           width: context.percentWidth * 76,
//                           child: FadeInUp(
//                               child: SignUpForm(
//                             contactNumberFocusNode: contactNumberFocusNode,
//                             passwordFocusNode: passwordFocusNode,
//                           ))))
//             ],
//           )),
//     );
//   }
// }
