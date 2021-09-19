import '/view/account_screen/address_editing_dialog_content.dart';
import 'package:flutter/material.dart';

Future showAddressEditingDialog(BuildContext context,int index) {
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext context, Animation animation,
        Animation secondaryAnimation) {
      return Material(
        color: Colors.transparent,
        child: AddressEditingDialogContent(index: index,),
      );
    },
  );
}
