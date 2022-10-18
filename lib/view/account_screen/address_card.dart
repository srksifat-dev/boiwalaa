import 'package:boiwalaa/controller/user_controller.dart';
import 'package:boiwalaa/model/address.dart';
import 'package:boiwalaa/services/database.dart';
import 'package:boiwalaa/view/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:velocity_x/velocity_x.dart';

Widget addressCard(
  BuildContext context,
  AddressModel address,
) {
  final userController = Get.find<UserController>();
  return Container(
    margin: EdgeInsets.only(bottom: context.percentWidth * 5),
    padding: EdgeInsets.only(
      left: context.percentWidth * 5,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(context.percentWidth * 3),
      color: Colors.grey[200],
    ),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            address.addressName.text.xl3.bold.make(),
            IconButton(
                onPressed: () async {
                  print("pressed");

                  await Database().deleteAddress(
                    GetStorage().read("contactNumber"),
                    address.addressName,
                  );

                  if (userController.obsAddressList.isEmpty) {
                    Get.back();
                  }

                  Fluttertoast.showToast(
                      msg: "${address.addressName} address deleted");

                  // ScaffoldMessenger.of(context)
                  //   ..hideCurrentSnackBar()
                  // ..showSnackBar(
                  //   SnackBar(
                  //     content:
                  //         "The item has been removed from cart"
                  //             .text
                  //             .make(),
                  //     action: SnackBarAction(
                  //       label: "Undo",
                  //       onPressed: () async {
                  //         // controller.cart.insert(index, cartItem);
                  //         await Database().addAddress(
                  //             "0${GetStorage().read("contactNumber")}",
                  //             address.addressName,
                  //             address.country,
                  //             address.state,
                  //             address.city,
                  //             address.detailAddress);
                  //       },
                  //     ),
                  //   ),
                  // );

                  // Get.defaultDialog(
                  //   backgroundColor: AppColors.lightAmber,
                  //   title:
                  //       "Do you want to delete ${address.addressName}?",
                  //   cancel: TextButton(
                  //       onPressed: () => Get.back(),
                  //       child: "No".text.make()),
                  //   confirm: TextButton(
                  //       onPressed: () async {
                  //         try {
                  //           await Database().deleteAddress(
                  //             GetStorage().read("contactNumber"),
                  //             address.addressName,
                  //           );
                  //           Get.back();
                  //         } on FirebaseException catch (e) {
                  //           Get.back();
                  //           messageSnackbar(
                  //               "Updating Error", e.message!);
                  //         }
                  //       },
                  //       child: "Yes".text.make()),
                  // );
                },
                icon: const Icon(Icons.delete)),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: context.percentWidth * 30,
              child: "Country".text.xl.bold.make(),
            ),
            Expanded(child: ": ${address.country}".text.xl.make()),
          ],
        ),
        HeightBox(context.percentWidth * 1),
        Row(
          children: [
            SizedBox(
              width: context.percentWidth * 30,
              child: "State".text.xl.bold.make(),
            ),
            Expanded(child: ": ${address.state}".text.xl.make()),
          ],
        ),
        HeightBox(context.percentWidth * 1),
        Row(
          children: [
            SizedBox(
              width: context.percentWidth * 30,
              child: "City".text.xl.bold.make(),
            ),
            Expanded(child: ": ${address.city}".text.xl.make()),
          ],
        ),
        HeightBox(context.percentWidth * 1),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: context.percentWidth * 30,
              child: "Detail Address".text.xl.bold.make(),
            ),
            Expanded(
                child: ": ${address.detailAddress}".text.xl.maxLines(5).make()),
          ],
        ),
        HeightBox(context.percentWidth * 5),
      ],
    ),
  );
}
