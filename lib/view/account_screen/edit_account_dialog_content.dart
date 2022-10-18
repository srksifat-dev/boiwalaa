import 'package:animate_do/animate_do.dart';
import 'package:boiwalaa/controller/user_controller.dart';
import 'package:boiwalaa/model/user.dart';
import 'package:boiwalaa/services/database.dart';
import 'package:boiwalaa/view/global_widget/custom_snackbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import '/controller/auth_controller.dart';
import '/view/account_screen/account_screen.dart';
import '/view/global_widget/custom_text_field.dart';
import '/view/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:velocity_x/velocity_x.dart';

class EditAccountDialogContent extends StatefulWidget {
  const EditAccountDialogContent({Key? key}) : super(key: key);

  @override
  _EditAccountDialogContentState createState() =>
      _EditAccountDialogContentState();
}

class _EditAccountDialogContentState extends State<EditAccountDialogContent> {
  final authController = Get.find<AuthController>();
  final userController = Get.find<UserController>();

  final TextEditingController name = TextEditingController();
  final TextEditingController contactNumber = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final nameFocusNode = FocusNode();
  final contactNumberFocusNode = FocusNode();
  final emailFocusNode = FocusNode();

  final passwordFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ButtonState _buttonState = ButtonState.idle;

  bool _obscure = true;

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void initState() {
    name.text = userController.user!.name;
    contactNumber.text = userController.user!.contactNumber.toString();
    email.text = userController.user!.email;
    // if (authController.country != "") country.text = authController.country;
    // if (authController.state != "") state.text = authController.state;
    // if (authController.city != "") city.text = authController.city;
    // if (authController.detailAddress != "")
    //   detailsAddress.text = authController.detailAddress;
    super.initState();
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
              padding: EdgeInsets.only(
                left: context.percentWidth * 5,
                right: context.percentWidth * 5,
                top: context.percentWidth * 6,
              ),
              height: context.percentHeight * 35,
              width: context.percentWidth * 90,
              decoration: BoxDecoration(
                color: AppColors.lightAmber,
                borderRadius: BorderRadius.circular(context.percentWidth * 5),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    "Edit Account".text.xl2.bold.makeCentered(),
                    HeightBox(context.percentHeight * 2),
                    customTextField(
                      context: context,
                      controller: name,
                      focusNode: nameFocusNode,
                      validator: (val) {
                        authController.validateName(val!);
                      },
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(
                            context, nameFocusNode, contactNumberFocusNode);
                      },
                      hintText: "Name",
                      fillColor: AppColors.green.withOpacity(0.2),
                      borderColor: AppColors.green,
                    ),
                    HeightBox(context.percentHeight * 1),
                    // customTextField(
                    //   context: context,
                    //   controller: contactNumber,
                    //   focusNode: contactNumberFocusNode,
                    //   validator: (val) {
                    //     authController.validateContactNumber(val!);
                    //   },
                    //   onFieldSubmitted: (term) {
                    //     _fieldFocusChange(
                    //         context, contactNumberFocusNode, emailFocusNode);
                    //   },
                    //   hintText: "Contact No.",
                    //   fillColor: AppColors.green.withOpacity(0.2),
                    //   borderColor: AppColors.green,
                    //   textInputType: TextInputType.phone,
                    // ),
                    // HeightBox(context.percentHeight * 1),
                    customTextField(
                      context: context,
                      controller: email,
                      focusNode: emailFocusNode,
                      validator: (val) {
                        authController.validateEmail(val!);
                      },
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(
                            context, emailFocusNode, passwordFocusNode);
                      },
                      hintText: "Email Address",
                      fillColor: AppColors.green.withOpacity(0.2),
                      borderColor: AppColors.green,
                      textCapitalization: TextCapitalization.none,
                      textInputType: TextInputType.emailAddress,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: context.percentHeight * 35,
          left: context.percentWidth * 25,
          right: context.percentWidth * 25,
          child: ElasticIn(
            duration: const Duration(milliseconds: 1000),
            child: ProgressButton.icon(
              state: _buttonState,
              onPressed: () async {
                nameFocusNode.unfocus();
                // contactNumberFocusNode.unfocus();
                emailFocusNode.unfocus();

                setState(() {
                  _buttonState = ButtonState.loading;
                });
                if (_formKey.currentState!.validate()) {
                  await Database().updateName(name.text);
                  await Database().updateEmail(email.text);

                  setState(() {
                    _buttonState = ButtonState.success;
                  });
                  Get.back();
                } else {
                  Future.delayed(const Duration(seconds: 2))
                      .then((_) => setState(() {
                            _buttonState = ButtonState.fail;
                          }))
                      .then((_) =>
                          Future.delayed(const Duration(milliseconds: 500)))
                      .then((_) {
                    Get.back();
                    messageSnackbar(
                        "Updating Error", "Provide valid information");
                  });
                }
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
        Positioned(
          bottom: context.percentHeight * 25,
          child: ElasticIn(
            duration: const Duration(milliseconds: 1000),
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.5),
                radius: context.percentWidth * 6,
                child: const Center(
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
