import 'package:boiwalaa/view/auth_screen/otp_dialog_content.dart';

import '/view/account_screen/address_dialog_content.dart';
import 'package:flutter/material.dart';

Future showOtpDialog({
  required BuildContext context,
  required Widget button,
  required TextEditingController otpController,
  required FocusNode otpFocusNode,
}) {
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext context, Animation animation,
        Animation secondaryAnimation) {
      return Material(
        color: Colors.transparent,
        child: OtpDialogContent(
          button: button,
          otpController: otpController,
          otpFocusNode: otpFocusNode,
        ),
      );
    },
  );
}
