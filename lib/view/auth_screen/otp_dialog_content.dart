import 'package:animate_do/animate_do.dart';
import 'package:boiwalaa/controller/auth_controller.dart';
import 'package:boiwalaa/controller/user_controller.dart';
import 'package:boiwalaa/model/user.dart';
import 'package:boiwalaa/services/database.dart';
import 'package:boiwalaa/view/global_widget/custom_snackbar.dart';
import 'package:boiwalaa/view/home_screen/home_screen.dart';
import 'package:boiwalaa/view/main_screen/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:boiwalaa/view/theme/colors.dart';

class OtpDialogContent extends StatefulWidget {
  const OtpDialogContent({
    Key? key,
  }) : super(key: key);

  @override
  _OtpDialogContentState createState() => _OtpDialogContentState();
}

class _OtpDialogContentState extends State<OtpDialogContent> {
  final authController = Get.find<AuthController>();
  final userController = Get.find<UserController>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final otpController = TextEditingController();
  final otpFocusNode = FocusNode();

  ButtonState _verifyButtonState = ButtonState.idle;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      _verifyButtonState = ButtonState.loading;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        await Database()
            .checkUserExist()
            .then((value) async {
              if(value == true){
                await Database()
                .fetchUser();
              }else{
                UserModel userModel = UserModel(
                userId: authController.auth.currentUser!.uid,
                contactNumber: "0${GetStorage().read("contactNumber")}");

            await Database().createUser(userModel);
              }
            });
        }

        setState(() {
          _verifyButtonState = ButtonState.success;
        });
        Future.delayed(const Duration(milliseconds: 800)).then((_) {
          // Get.back();
          Get.offAll(() => const MainScreen());
        });
    } on FirebaseAuthException catch (e) {
      setState(() {
        _verifyButtonState = ButtonState.fail;
      });
      Get.back();

      messageSnackbar("Verify Error", "${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          top: context.percentHeight * 27,
          child: ElasticIn(
            duration: const Duration(milliseconds: 1000),
            child: Container(
              height: context.percentHeight * 30,
              width: context.percentWidth * 90,
              decoration: BoxDecoration(
                color: AppColors.lightAmber,
                borderRadius: BorderRadius.circular(context.percentWidth * 5),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: context.percentWidth * 5,
                  right: context.percentWidth * 5,
                  top: context.percentWidth * 5,
                ),
                child: Column(
                  children: [
                    "Enter One Time Password(OTP)".text.xl2.bold.makeCentered(),
                    HeightBox(context.percentHeight * 2),
                    "One Time Password has been sent to your mobile number."
                        .text
                        .center
                        .makeCentered(),
                    HeightBox(context.percentHeight * 3),
                    PinPut(
                      fieldsCount: 6,
                      controller: otpController,
                      autofocus: true,
                      focusNode: otpFocusNode,
                      selectedFieldDecoration: BoxDecoration(
                        color: AppColors.deepAmber.withOpacity(0.2),
                        border: const Border(
                            bottom: BorderSide(
                                color: AppColors.deepAmber, width: 2)),
                      ),
                      followingFieldDecoration: BoxDecoration(
                        color: AppColors.deepAmber.withOpacity(0.2),
                        border: const Border(
                            bottom: BorderSide(
                                color: AppColors.deepAmber, width: 2)),
                      ),
                      submittedFieldDecoration: BoxDecoration(
                        color: AppColors.green.withOpacity(0.2),
                        border: const Border(
                            bottom:
                                BorderSide(color: AppColors.green, width: 2)),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      checkClipboard: true,
                      onClipboardFound: (val) {
                        otpController.text = val!;
                      },
                      eachFieldHeight: context.percentHeight * 5,
                    ),
                    HeightBox(context.percentHeight * 2),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: context.percentHeight * 40,
          left: context.percentWidth * 25,
          right: context.percentWidth * 25,
          child: ElasticIn(
            duration: const Duration(milliseconds: 1000),
            child: ProgressButton.icon(
              state: _verifyButtonState,
              onPressed: () async {
                setState(() {
                  _verifyButtonState = ButtonState.loading;
                });
                otpFocusNode.unfocus();
                PhoneAuthCredential phoneAuthCredential =
                    PhoneAuthProvider.credential(
                        verificationId: authController.verificationId,
                        smsCode: otpController.text);

                signInWithPhoneAuthCredential(phoneAuthCredential);
              },
              iconedButtons: {
                ButtonState.idle: const IconedButton(
                    icon: Icon(Icons.arrow_forward, color: Colors.white),
                    color: AppColors.green),
                ButtonState.loading: const IconedButton(color: AppColors.green),
                ButtonState.fail: IconedButton(
                    text: "Failed",
                    icon: const Icon(Icons.cancel, color: Colors.white),
                    color: Colors.red.shade400),
                ButtonState.success: const IconedButton(
                    text: "Success",
                    icon: Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                    color: AppColors.green)
              },
            ),
          ),
        ),
        // Positioned(
        //     bottom: context.percentHeight * buttonPosition,
        //     left: context.percentWidth * 5,
        //     right: context.percentWidth * 5,
        //     child: ElasticIn(
        //       duration: const Duration(milliseconds: 1000),
        //       child: GestureDetector(
        //         onTap: onTap,
        //         child: Container(
        //             decoration: BoxDecoration(
        //                 color: AppColors.deepAmber,
        //                 borderRadius: BorderRadius.circular(
        //                   context.percentWidth * 5,
        //                 )),
        //             height: context.percentWidth * 14,
        //             width: context.percentWidth * 90,
        //             child: TextButton(
        //                 onPressed: onTap,
        //                 child: "Confirm Order"
        //                     .text
        //                     .color(AppColors.backgroundWhite)
        //                     .xl2
        //                     .makeCentered())),
        //       ),
        //     ),),
      ],
    );
  }
}
