import 'package:animate_do/animate_do.dart';
import 'package:boiwalaa/controller/user_controller.dart';
import 'package:boiwalaa/model/user.dart';
import 'package:boiwalaa/services/database.dart';
import 'package:boiwalaa/view/global_widget/custom_popup_card.dart';
import 'package:boiwalaa/view/global_widget/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:velocity_x/velocity_x.dart';

import '/controller/auth_controller.dart';
import '/view/global_widget/custom_text_field.dart';
import '/view/home_screen/home_screen.dart';
import '/view/theme/colors.dart';
import 'otp_dialog.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key? key,
    required this.contactNumberFocusNode,
  }) : super(key: key);
  final FocusNode contactNumberFocusNode;

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final authController = Get.find<AuthController>();
  // final userController = Get.find<UserController>();

  final contactNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final otpController = TextEditingController();

  final contactNumberFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final otpFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  ButtonState _buttonState = ButtonState.idle;

  String verificationId = "";

  @override
  void initState() {
    final initialNumber = GetStorage().read("contactNumber");
    contactNumberController.text = initialNumber ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          "Sign Up or Sign In with Mobile No.".text.xl2.bold.makeCentered(),
          HeightBox(context.percentHeight * 5),
          SizedBox(
            width: context.percentWidth * 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: context.percentHeight * 5,
                    width: context.percentWidth * 23.5,
                    color: AppColors.green.withOpacity(0.2),
                    child: "🇧🇩  +880".text.xl.makeCentered()),
                WidthBox(context.percentWidth * 3),
                SizedBox(
                  height: context.percentHeight * 7,
                  width: context.percentWidth * 50,
                  child: Center(
                    child: customTextField(
                      context: context,
                      focusNode: widget.contactNumberFocusNode,
                      controller: contactNumberController,
                      maxLength: 10,
                      validator: (val) {
                        return authController.validateContactNumber(val!);
                      },
                      onSaved: (val) {
                        GetStorage().write("contactNumber", val!);
                        // authController.contactNumberController.text = val;
                      },
                      hintText: "Contact Number",
                      fillColor: AppColors.green.withOpacity(0.2),
                      borderColor: AppColors.green,
                      textInputType: TextInputType.phone,
                    ),
                  ),
                ),
              ],
            ),
          ),
          HeightBox(context.percentHeight * 2),
          // customTextField(
          //   context: context,
          //   focusNode: passwordFocusNode,
          //   controller: passwordController,
          //   textInputAction: TextInputAction.done,
          //   textCapitalization: TextCapitalization.none,
          //   validator: (val) {
          //     return authController.validateSignInPassword(val!);
          //   },
          //   onFieldSubmitted: (term) {
          //     passwordFocusNode.unfocus();
          //   },
          //   hintText: "Password",
          //   fillColor: AppColors.green.withOpacity(0.2),
          //   borderColor: AppColors.green,
          //   obscureText: _obscure,
          //   suffixIcon: _obscure
          //       ? GestureDetector(
          //           onTap: () {
          //             setState(() {
          //               _obscure = false;
          //             });
          //           },
          //           child: ZoomIn(
          //             duration: const Duration(milliseconds: 300),
          //             child: const Icon(
          //               Icons.visibility_off,
          //               color: AppColors.green,
          //             ),
          //           ),
          //         )
          //       : GestureDetector(
          //           onTap: () {
          //             setState(() {
          //               _obscure = true;
          //             });
          //           },
          //           child: ZoomIn(
          //             duration: const Duration(milliseconds: 300),
          //             child: const Icon(
          //               Icons.visibility,
          //               color: AppColors.green,
          //             ),
          //           ),
          //         ),
          // ),
          // HeightBox(context.percentHeight * 2),
          // TextButton(
          //     onPressed: () {
          //       contactNumberFocusNode.unfocus();
          //       passwordFocusNode.unfocus();
          //     },
          //     child: "Forgot password?"
          //         .text
          //         .color(AppColors.green)
          //         .makeCentered()),
          ProgressButton.icon(
              iconedButtons: {
                ButtonState.idle: const IconedButton(
                    icon: Icon(Icons.arrow_forward, color: Colors.white),
                    color: AppColors.green),
                ButtonState.loading: IconedButton(color: AppColors.green),
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
              onPressed: () async {
                widget.contactNumberFocusNode.unfocus();

                setState(() {
                  _buttonState = ButtonState.loading;
                });
                _formKey.currentState!.validate()
                    ?

                    // Verify Phone Number

                    await _auth.verifyPhoneNumber(
                        phoneNumber: "+880${contactNumberController.text}",
                        verificationCompleted: (phoneAuthCredential) async {
                          // setState(() {
                          //   _verifyButtonState = ButtonState.success;
                          // });
                        },
                        verificationFailed: (verificationFailed) async {
                          setState(() {
                            _buttonState = ButtonState.fail;
                          });

                          messageSnackbar("Authentication Error",
                              "${verificationFailed.message}");
                        },
                        codeSent: (verificationId, resendToken) async {
                          setState(() {
                            _buttonState = ButtonState.success;
                          });
                          authController.verificationId = verificationId;
                          _formKey.currentState!.save();

                          // OTP Dialog
                          showOtpDialog(context: context);
                        },
                        codeAutoRetrievalTimeout: (verificationId) async {},
                        timeout: const Duration(seconds: 120),
                      )
                    : Future.delayed(const Duration(seconds: 2))
                        .then((_) {
                          setState(() {
                            _buttonState = ButtonState.fail;
                          });
                          messageSnackbar("Input Validation Error",
                              "Please provide valid information.");
                        })
                        .then((_) =>
                            Future.delayed(const Duration(milliseconds: 500)))
                        .then((_) => _buttonState = ButtonState.idle);
              },
              state: _buttonState),
          const Spacer(),
        ],
      ),
    );
  }
}
