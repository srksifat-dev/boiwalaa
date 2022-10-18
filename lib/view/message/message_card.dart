import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

import '/view/theme/colors.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({
    Key? key,
    required this.title,
    required this.startingMessageBody,
    required this.endingMessageBody,
    required this.dateTime,
    required this.couponCode,
    required this.copyable,
  }) : super(key: key);

  final String title;
  final String startingMessageBody;
  final String endingMessageBody;
  final DateTime dateTime;
  final String couponCode;
  final bool copyable;

  @override
  Widget build(BuildContext context) {
    final f = DateFormat("yyyy-MM-dd hh:mm");
    final dateTimeStr = f.format(dateTime);
    return Container(
      padding: EdgeInsets.only(
        left: context.percentWidth * 3,
        right: context.percentWidth * 3,
        bottom: context.percentWidth * 3,
      ),
      margin: EdgeInsets.only(bottom: context.percentWidth * 3),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(context.percentWidth * 3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeightBox(context.percentWidth * 2),
          dateTimeStr.text.gray400.make(),
          Row(
            children: [
              SizedBox(
                  width: context.percentWidth * 72,
                  child: title.text.xl.ellipsis.bold.make()),
              if (copyable)
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    final data = ClipboardData(text: couponCode);
                    Clipboard.setData(data);
                    Fluttertoast.showToast(
                        msg: "Coupon code is copied in clipboard!");
                  },
                ),
            ],
          ),
          "$startingMessageBody '$couponCode' $endingMessageBody".text.make(),
        ],
      ),
    );
  }
}
