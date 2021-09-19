import '/controller/auth_controller.dart';
import '/view/account_screen/address_dialog.dart';
import '/view/account_screen/address_editing_dialog.dart';
import '/view/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AddressBook extends StatelessWidget {
  AddressBook({Key? key}) : super(key: key);
  final authController = Get.find<AuthController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Address Book".text.make(),
        backgroundColor: AppColors.green,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: GestureDetector(
                onTap: () => showAddressDialog(context),
                child: const Icon(Icons.add)),
          )
        ],
      ),
      body: Obx(
        () => Padding(
          padding: EdgeInsets.all(context.percentWidth * 5),
          child: ListView.builder(
            itemCount: authController.addressList.length,
            itemBuilder: (BuildContext context, index) {
              final address = authController.addressList[index];
              return Container(
                margin: EdgeInsets.only(bottom: context.percentWidth * 5),
                padding: EdgeInsets.only(
                  left: context.percentWidth * 5,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(context.percentWidth * 3),
                  color: AppColors.green.withOpacity(0.2),
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
                            onPressed: () =>
                                showAddressEditingDialog(context, index),
                            icon: const Icon(Icons.edit))
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
                            child: ": ${address.detailAddress}"
                                .text
                                .xl
                                .maxLines(5)
                                .make()),
                      ],
                    ),
                    HeightBox(context.percentWidth * 5),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
