import 'package:animate_do/animate_do.dart';
import 'package:boiwalaa/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:boiwalaa/view/global_widget/custom_popup_card.dart';
import 'package:boiwalaa/view/global_widget/custom_snackbar.dart';

import '/controller/auth_controller.dart';
import '/view/global_widget/custom_text_field.dart';
import '/view/home_screen/home_screen.dart';
import '/view/theme/colors.dart';
import 'otp_dialog.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
    required this.contactNumberFocusNode,
    required this.passwordFocusNode,
    required this.nameFocusNode,
    required this.confirmPasswordFocusNode,
  }) : super(key: key);
  final FocusNode contactNumberFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode nameFocusNode;
  final FocusNode confirmPasswordFocusNode;

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final authController = Get.find<AuthController>();
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  final nameText = TextEditingController();
  // final emailText = TextEditingController();
  final contactNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final otpController = TextEditingController();

  final nameFocusNode = FocusNode();

  // final emailFocusNode = FocusNode();

  final confirmPasswordFocusNode = FocusNode();
  final otpFocusNode = FocusNode();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  ButtonState _buttonState = ButtonState.idle;
  ButtonState _verifyButtonState = ButtonState.idle;

  bool _obscure = true;
  String verificationId = "";

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      _verifyButtonState = ButtonState.loading;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        setState(() {
          _verifyButtonState = ButtonState.success;
        });
        _signUpFormKey.currentState!.save();
        authController.addUser(UserModel(
            userId: authController.contactNumber,
            name: authController.name,
            contactNumber: int.parse(authController.contactNumber)));

        Future.delayed(const Duration(milliseconds: 800)).then((_) {
          // Get.back();
          Get.offAll(() => const HomeScreen());
        });
      }
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.percentWidth * 13),
      child: Form(
        key: _signUpFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),

            // Name TextField

            customTextField(
              context: context,
              controller: nameText,
              focusNode: nameFocusNode,
              validator: (val) {
                if (nameText.text.isEmpty) {
                  return "Enter your name";
                } else if (nameText.text.length < 3) {
                  return "Enter your real name please";
                } else {
                  return null;
                }
              },
              onSaved: (val) {
                authController.name = val!;
              },
              onFieldSubmitted: (term) {
                _fieldFocusChange(
                    context, nameFocusNode, widget.contactNumberFocusNode);
              },
              hintText: "Full Name",
              fillColor: AppColors.green.withOpacity(0.2),
              borderColor: AppColors.green,
              textCapitalization: TextCapitalization.words,
            ),
            HeightBox(context.percentHeight * 2),

            // Contact Number TextField

            customTextField(
              context: context,
              controller: contactNumberController,
              focusNode: widget.contactNumberFocusNode,
              maxLength: 11,
              validator: (val) {
                return authController.validateContactNumber(val!);
              },
              onSaved: (val) {
                GetStorage().write("contactNumber", val!);
              },
              onFieldSubmitted: (term) {
                _fieldFocusChange(context, widget.contactNumberFocusNode,
                    widget.passwordFocusNode);
              },
              hintText: "Contact Number",
              fillColor: AppColors.green.withOpacity(0.2),
              borderColor: AppColors.green,
              textInputType: TextInputType.phone,
            ),
            HeightBox(context.percentHeight * 1),

            // Password TextField

            customTextField(
              context: context,
              focusNode: widget.passwordFocusNode,
              controller: passwordController,
              textCapitalization: TextCapitalization.none,
              validator: (val) {
                return authController.validateSignUpPassword(val!);
              },
              onFieldSubmitted: (term) {
                _fieldFocusChange(context, widget.passwordFocusNode,
                    confirmPasswordFocusNode);
              },
              onSaved: (val) {
                GetStorage().write("password", val!);
              },
              hintText: "Password",
              fillColor: AppColors.green.withOpacity(0.2),
              borderColor: AppColors.green,
              obscureText: _obscure,
              suffixIcon: _obscure
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscure = false;
                        });
                      },
                      child: ZoomIn(
                        duration: const Duration(milliseconds: 300),
                        child: const Icon(
                          Icons.visibility_off,
                          color: AppColors.green,
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscure = true;
                        });
                      },
                      child: ZoomIn(
                        duration: const Duration(milliseconds: 300),
                        child: const Icon(
                          Icons.visibility,
                          color: AppColors.green,
                        ),
                      ),
                    ),
            ),
            HeightBox(context.percentHeight * 1.5),

            // Confirm Password TextField

            customTextField(
              context: context,
              focusNode: confirmPasswordFocusNode,
              controller: confirmPasswordController,
              textInputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.none,
              validator: (val) {
                if (passwordController.text != confirmPasswordController.text) {
                  return "Password doesn't match";
                }
                return null;
              },
              onFieldSubmitted: (term) {
                confirmPasswordFocusNode.unfocus();
              },
              hintText: "Confirm Password",
              fillColor: AppColors.green.withOpacity(0.2),
              borderColor: AppColors.green,
              obscureText: _obscure,
              suffixIcon: _obscure
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscure = false;
                        });
                      },
                      child: ZoomIn(
                        duration: const Duration(milliseconds: 300),
                        child: const Icon(
                          Icons.visibility_off,
                          color: AppColors.green,
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscure = true;
                        });
                      },
                      child: ZoomIn(
                        duration: const Duration(milliseconds: 300),
                        child: const Icon(
                          Icons.visibility,
                          color: AppColors.green,
                        ),
                      ),
                    ),
            ),
            HeightBox(context.percentHeight * 2),
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
                  widget.nameFocusNode.unfocus();
                  widget.contactNumberFocusNode.unfocus();
                  widget.passwordFocusNode.unfocus();
                  widget.confirmPasswordFocusNode.unfocus();

                  setState(() {
                    _buttonState = ButtonState.loading;
                  });
                  _signUpFormKey.currentState!.validate()
                      ?

                      // Verify Phone Number

                      await _auth.verifyPhoneNumber(
                          phoneNumber: "+88${contactNumberController.text}",
                          verificationCompleted: (phoneAuthCredential) async {
                            // setState(() {
                            //   _verifyButtonState = ButtonState.success;
                            // });
                          },
                          verificationFailed: (verificationFailed) async {
                            setState(() {
                              _buttonState = ButtonState.fail;
                            });

                            messageSnackbar("Sign Up Error",
                                "${verificationFailed.message}");
                          },
                          codeSent: (verificationId, resendToken) async {
                            setState(() {
                              _buttonState = ButtonState.success;
                              this.verificationId = verificationId;
                            });

                            // OTP Dialog

                            showOtpDialog(
                              context: context,
                              otpController: otpController,
                              otpFocusNode: otpFocusNode,

                              // OTP TextField

                              // Verify Button

                              button: ProgressButton.icon(
                                state: _verifyButtonState,
                                onPressed: () async {
                                  setState(() {
                                    _verifyButtonState = ButtonState.loading;
                                  });
                                  otpFocusNode.unfocus();
                                  PhoneAuthCredential phoneAuthCredential =
                                      PhoneAuthProvider.credential(
                                          verificationId: verificationId,
                                          smsCode: otpController.text);

                                  signInWithPhoneAuthCredential(
                                      phoneAuthCredential);
                                },
                                iconedButtons: {
                                  ButtonState.idle: const IconedButton(
                                      icon: Icon(Icons.arrow_forward,
                                          color: Colors.white),
                                      color: AppColors.green),
                                  ButtonState.loading: const IconedButton(
                                      color: AppColors.green),
                                  ButtonState.fail: IconedButton(
                                      text: "Failed",
                                      icon: const Icon(Icons.cancel,
                                          color: Colors.white),
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
                            );
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
                  // Future.delayed(const Duration(seconds: 2))
                  //     .then((_) => setState(() {
                  //           _buttonState = ButtonState.success;
                  //           authController.name = nameText.text;
                  //           // authController.email = emailText.text;
                  //           authController.contactNumber =
                  //               contactNumberText.text;
                  //           authController.password = passwordText.text;
                  //         }))
                  //     .then((_) =>
                  //         Future.delayed(const Duration(milliseconds: 800)))
                  //     .then((_) => Get.off(() => const HomeScreen()))
                },
                state: _buttonState),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
