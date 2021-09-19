import '/view/account_screen/edit_account_dialog_content.dart';
import 'package:flutter/material.dart';

Future showEditAccountDialog(
  BuildContext context
) {
  return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return const Material(
          color: Colors.transparent,
          child: EditAccountDialogContent(),
        );
      });
}
