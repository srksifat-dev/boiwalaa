import 'package:animate_do/animate_do.dart';
import 'package:boiwalaa/controller/user_controller.dart';
import 'package:boiwalaa/model/user.dart';
import 'package:boiwalaa/services/database.dart';
import 'package:boiwalaa/view/global_widget/custom_snackbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import '/model/address.dart';
import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:velocity_x/velocity_x.dart';

import '/controller/auth_controller.dart';
import '/view/account_screen/address_book.dart';
import '/view/global_widget/custom_text_field.dart';
import '/view/theme/colors.dart';

class AddressDialogContent extends StatefulWidget {
  const AddressDialogContent({
    Key? key,
  }) : super(key: key);

  @override
  _AddressDialogContentState createState() => _AddressDialogContentState();
}

class _AddressDialogContentState extends State<AddressDialogContent> {
  final authController = Get.find<AuthController>();
  final userController = Get.find<UserController>();

  final TextEditingController addressName = TextEditingController();
  final TextEditingController country = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController detailAddress = TextEditingController();

  final FocusNode addressNameFocusNode = FocusNode();
  // final FocusNode countryFocusNode = FocusNode();
  // final FocusNode stateFocusNode = FocusNode();
  // final FocusNode cityFocusNode = FocusNode();
  final FocusNode detailAddressFocusNode = FocusNode();

  ButtonState _buttonState = ButtonState.idle;

  // _fieldFocusChange(
  //     BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  //   currentFocus.unfocus();
  //   FocusScope.of(context).requestFocus(nextFocus);
  // }

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
              height: context.percentHeight * 50,
              width: context.percentWidth * 90,
              decoration: BoxDecoration(
                color: AppColors.lightAmber,
                borderRadius: BorderRadius.circular(context.percentWidth * 5),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    "Address Info".text.xl2.bold.makeCentered(),
                    HeightBox(context.percentHeight * 2),
                    customTextField(
                      context: context,
                      controller: addressName,
                      focusNode: addressNameFocusNode,
                      onFieldSubmitted: (term) {
                        addressNameFocusNode.unfocus();
                      },
                      hintText: "Address Name",
                      fillColor: AppColors.green.withOpacity(0.2),
                      borderColor: AppColors.green,
                    ),
                    HeightBox(context.percentHeight * 1),
                    CountryStateCityPicker(
                      country: country,
                      state: state,
                      city: city,
                      textFieldInputBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.deepAmber),
                      ),
                    ),
                    // customTextField(
                    //   context: context,
                    //   controller: country,
                    //   focusNode: countryFocusNode,
                    //   onFieldSubmitted: (term) {
                    //     _fieldFocusChange(
                    //         context, countryFocusNode, stateFocusNode);
                    //   },
                    //   hintText: "Country",
                    //   fillColor: AppColors.green.withOpacity(0.2),
                    //   borderColor: AppColors.green,
                    // ),
                    // HeightBox(context.percentHeight * 1),
                    // customTextField(
                    //   context: context,
                    //   controller: state,
                    //   focusNode: stateFocusNode,
                    //   onFieldSubmitted: (term) {
                    //     _fieldFocusChange(
                    //         context, stateFocusNode, cityFocusNode);
                    //   },
                    //   hintText: "State",
                    //   fillColor: AppColors.green.withOpacity(0.2),
                    //   borderColor: AppColors.green,
                    // ),
                    // HeightBox(context.percentHeight * 1),
                    // customTextField(
                    //   context: context,
                    //   controller: city,
                    //   focusNode: cityFocusNode,
                    //   onFieldSubmitted: (term) {
                    //     _fieldFocusChange(
                    //         context, cityFocusNode, detailAddressFocusNode);
                    //   },
                    //   hintText: "City",
                    //   fillColor: AppColors.green.withOpacity(0.2),
                    //   borderColor: AppColors.green,
                    // ),
                    HeightBox(context.percentHeight * 1),
                    customTextField(
                      context: context,
                      controller: detailAddress,
                      focusNode: detailAddressFocusNode,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (term) {
                        detailAddressFocusNode.unfocus();
                      },
                      hintText: "Detail Address",
                      fillColor: AppColors.green.withOpacity(0.2),
                      borderColor: AppColors.green,
                    ),
                    HeightBox(context.percentHeight * 20),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: context.percentHeight * 20,
          left: context.percentWidth * 25,
          right: context.percentWidth * 25,
          child: ElasticIn(
            duration: const Duration(milliseconds: 1000),
            child: ProgressButton.icon(
              state: _buttonState,
              onPressed: () async {
                // nameFocusNode.unfocus();
                // contactNumberFocusNode.unfocus();
                // emailFocusNode.unfocus();

                try {
                  setState(() {
                    _buttonState = ButtonState.loading;
                  });
                  await Database().addAddress(
                    GetStorage().read("contactNumber"),
                    addressName.text,
                    country.text,
                    state.text,
                    city.text,
                    detailAddress.text,
                  );
                  setState(() {
                    _buttonState = ButtonState.success;
                  });
                  Get.back();
                  Get.to(() => AddressBook());
                } on FirebaseException catch (e) {
                  messageSnackbar("Updating Error", e.message!);
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
          bottom: context.percentHeight * 10,
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
