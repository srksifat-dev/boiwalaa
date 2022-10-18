import 'package:boiwalaa/controller/user_controller.dart';
import 'package:boiwalaa/view/account_screen/address_card.dart';
import '/view/account_screen/address_dialog.dart';
import '/view/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AddressBook extends StatelessWidget {
  AddressBook({Key? key}) : super(key: key);
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Address Book".text.make(),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GestureDetector(
                onTap: () => showAddressDialog(context),
                child: const Icon(Icons.add)),
          )
        ],
      ),
      body: Padding(
              padding: EdgeInsets.all(context.percentWidth * 5),
              child: Obx(
                () => ListView.builder(
                  itemCount: userController.obsAddressList.length,
                  itemBuilder: (BuildContext context, index) {
                    final address = userController.obsAddressList[index];
                    return addressCard(context, address);
                  },
                ),
              ),
            ),
    );
  }
}
