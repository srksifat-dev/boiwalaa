import '/model/message.dart';
import '/view/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:velocity_x/velocity_x.dart';

class MessageController extends GetxController {
  var messageList = List<Message>.empty(growable: true).obs;
  var clicked = false;

  void showMessageOnTheFly(
      {required String title,
      required String startingMessageBody,
      String endingMessageBody = "",
      String coupon = "",
      isCopyable = true}) {
    final messageID = Uuid().v4();
    final dateTime = DateTime.now();
    final message = Message(
      id: messageID,
      title: title,
      startingMessageBody: startingMessageBody,
      endingMessageBody: endingMessageBody,
      dateTime: dateTime,
      couponCode: coupon,
      copyable: isCopyable,
    );
    messageList.add(message);
    clicked = false;
    Get.snackbar("", "",
        titleText: "$title".text.color(AppColors.deepAmber).bold.make(),
        messageText: isCopyable ? "$startingMessageBody '$coupon' $endingMessageBody"
            .text
            .white
            .make() : "$startingMessageBody"
            .text
            .white
            .make(),
        backgroundColor: Colors.black,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        borderRadius: 0,
        margin: EdgeInsets.all(0),
        mainButton: isCopyable
            ? TextButton(
                onPressed: () {
                  final data = ClipboardData(text: coupon);
                  Clipboard.setData(data);
                  Fluttertoast.showToast(
                      msg: "Coupon code is copied in clipboard!");
                },
                child: "Copy".text.color(AppColors.deepAmber).bold.make())
            : null,
        duration: Duration(seconds: 5));

    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     action: SnackBarAction(
    //         label: "$snackLebel",
    //         onPressed: () {
    //           final data = ClipboardData(text: coupon);
    //           Clipboard.setData(data);
    //           Fluttertoast.showToast(
    //               msg: "Coupon code is copied in clipboard!");
    //         }),
    //     content:
    //         "$startingMessageBody '$coupon' $endingMessageBody".text.make()));
  }

  // void addMessage(
  //     {required Message message,
  //     required String title,
  //     required String startingMessageBody,
  //     required String endingMessageBody,
  //     required String coupon,
  //     isCopyable = true}) {
  //   for (Message newMessage in messageList) {
  //     if (newMessage.title == message.title &&
  //         message.dateTime.difference(newMessage.dateTime) <
  //             Duration(hours: 24)) {
  //       return;
  //     } else {
  //       messageList.add(message);
  //       Get.snackbar("", "",
  //           titleText: "$title".text.color(AppColors.deepRed).bold.make(),
  //           messageText: "$startingMessageBody '$coupon' $endingMessageBody"
  //               .text
  //               .white
  //               .make(),
  //           backgroundColor: Colors.black,
  //           colorText: Colors.white,
  //           snackPosition: SnackPosition.TOP,
  //           borderRadius: 0,
  //           margin: EdgeInsets.all(0),
  //           mainButton: isCopyable
  //               ? TextButton(
  //                   onPressed: () {
  //                     final data = ClipboardData(text: coupon);
  //                     Clipboard.setData(data);
  //                     Fluttertoast.showToast(
  //                         msg: "Coupon code is copied in clipboard!");
  //                   },
  //                   child: "Copy".text.color(AppColors.deepRed).bold.make())
  //               : null,
  //           duration: Duration(seconds: 5));
  //     }
  //   }
  // }
}
