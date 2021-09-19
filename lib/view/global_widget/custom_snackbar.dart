import 'package:boiwalaa/view/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

void messageSnackbar(String title, String message){
  return Get.snackbar("", "",
          titleText: title.text.color(AppColors.deepAmber).bold.make(),
          messageText: message.text.white.make(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          isDismissible: false,
          borderRadius: 0,
          margin: const EdgeInsets.all(0),
          duration: const Duration(seconds: 5));
}