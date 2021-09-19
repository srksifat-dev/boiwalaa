import '/controller/messaage_controller.dart';
import '/view/message/message_card.dart';
import '/view/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen({Key? key}) : super(key: key);

  final messageController = Get.find<MessageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Messages".text.make(),
        backgroundColor: AppColors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(context.percentWidth * 5),
        child: messageController.messageList.isEmpty
            ? "You have no message".text.makeCentered()
            : ListView.builder(
                itemCount: messageController.messageList.length,
                itemBuilder: (context, index) {
                  final message = messageController.messageList[index];
                  return MessageCard(
                      title: message.title,
                      startingMessageBody: message.startingMessageBody,
                      endingMessageBody: message.endingMessageBody,
                      dateTime: message.dateTime,
                      couponCode: message.couponCode,copyable: message.copyable,);
                }),
      ),
    );
  }
}
