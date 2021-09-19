import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:boiwalaa/view/theme/colors.dart';

class OtpDialogContent extends StatefulWidget {
  const OtpDialogContent({
    Key? key,
    required this.otpController,
    required this.otpFocusNode,
    required this.button,
  }) : super(key: key);
  final TextEditingController otpController;
  final FocusNode otpFocusNode;
  final Widget button;

  @override
  _OtpDialogContentState createState() => _OtpDialogContentState();
}

class _OtpDialogContentState extends State<OtpDialogContent> {
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
                      controller: widget.otpController,
                      autofocus: true,
                      focusNode: widget.otpFocusNode,
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
                        widget.otpController.text = val!;
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
            child: widget.button,
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
