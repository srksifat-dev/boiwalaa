import 'package:animate_do/animate_do.dart';
import 'package:boiwalaa/controller/user_controller.dart';
import '/controller/auth_controller.dart';
import '../../controller/message_controller.dart';
import '/controller/order_controller.dart';
import '/view/account_screen/account_screen.dart';
import '/view/home_screen/footer.dart';
import '/view/message/message_screen.dart';
import '/view/theme/colors.dart';
import '/view/track_order_screen/track_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);
  final authController = Get.find<AuthController>();
  final orderController = Get.find<OrderController>();
  final userController = Get.find<UserController>();

  final messageController = Get.find<MessageController>();

  @override
  Widget build(BuildContext context) {
    return ElasticInRight(
      child: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                padding: const EdgeInsets.all(0),
                child: Column(
                  children: [
                    // Container(
                    //   margin: EdgeInsets.only(
                    //       top: context.percentWidth * 2,
                    //       right: context.percentWidth * 3),
                    //   alignment: Alignment.topRight,
                    //   height: context.percentWidth * 8,
                    //   width: double.infinity,
                    //   child: ElasticInRight(
                    //     delay: Duration(milliseconds: 100),
                    //     child: CircleAvatar(
                    //       backgroundColor: AppColors.backgroundWhite,
                    //       child: ElasticInRight(
                    //         delay: Duration(milliseconds: 200),
                    //         child: Icon(
                    //           Icons.edit,
                    //           color: AppColors.green,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: context.percentWidth * 30,
                      width: double.infinity,
                      child: Center(
                        child: ElasticInRight(
                          delay: const Duration(milliseconds: 100),
                          child: WidgetCircularAnimator(
                              innerColor: AppColors.green.withOpacity(0.5),
                              outerColor: AppColors.green.withOpacity(0.3),
                              size: context.percentWidth * 25,
                              child: ElasticInRight(
                                delay: const Duration(milliseconds: 200),
                                child: CircleAvatar(
                                  backgroundColor: AppColors.green,
                                  foregroundColor: Colors.white,
                                  child: ElasticInRight(
                                    delay: const Duration(milliseconds: 300),
                                    child: Icon(
                                      Icons.person,
                                      size: context.percentWidth * 12,
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ),
                    ElasticInRight(
                      delay: const Duration(milliseconds: 100),
                      child: SizedBox(
                          width: context.percentWidth * 60,
                          child: Obx(
                            () => userController.user!.name.text.ellipsis
                                .maxLines(1)
                                .xl
                                .makeCentered(),
                          )),
                    ),
                  ],
                )),
            ListTile(
              onTap: orderController.orderList.isEmpty
                  ? () {
                      Fluttertoast.showToast(
                          msg: "You have no order",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  : () {
                      Get.back();
                      Get.to(() => TrackOrder());
                    },
              leading: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..rotateY(3),
                child: ElasticInLeft(
                  child: Icon(
                    Icons.local_shipping_outlined,
                    color: AppColors.green,
                    size: context.percentWidth * 8,
                  ),
                ),
              ),
              title: ElasticInRight(
                  delay: const Duration(milliseconds: 100),
                  child: "Track Your Orders".text.xl.make()),
            ),
            const Divider(),
            // GestureDetector(
            //   onTap: () {
            //     Get.back();
            //     Get.to(() => PurchaseHistory());
            //   },
            //   child: ListTile(
            //     leading: ElasticInRight(
            //       delay: Duration(milliseconds: 100),
            //       child: Icon(
            //         Icons.history,
            //         color: AppColors.green,
            //         size: context.percentWidth * 8,
            //       ),
            //     ),
            //     title: ElasticInRight(
            //         delay: Duration(milliseconds: 200),
            //         child: "Your purchase History".text.xl.make()),
            //   ),
            // ),
            // Divider(),
            GestureDetector(
              onTap: () {
                print(userController.obsAddressList.length);
                Get.back();
                Get.to(() => AccountScreen());
              },
              child: ListTile(
                leading: ElasticInRight(
                  delay: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.person_outline,
                    color: AppColors.green,
                    size: context.percentWidth * 8,
                  ),
                ),
                title: ElasticInRight(
                    delay: const Duration(milliseconds: 300),
                    child: "Account Info".text.xl.make()),
              ),
            ),
            const Divider(),
            GestureDetector(
              onTap: () {
                Get.back();
                Get.to(() => MessageScreen());
                messageController.clicked = true;
              },
              child: ListTile(
                leading: ElasticInRight(
                  delay: const Duration(milliseconds: 300),
                  child: messageController.clicked
                      ? Icon(
                          Icons.chat_bubble_outline,
                          // Icons.mark_chat_unread,
                          color: AppColors.green,
                          size: context.percentWidth * 8,
                        )
                      : Icon(
                          Icons.mark_chat_unread_outlined,
                          // Icons.mark_chat_unread,
                          color: AppColors.deepAmber,
                          size: context.percentWidth * 8,
                        ),
                ),
                title: ElasticInRight(
                    delay: const Duration(milliseconds: 400),
                    child: "Messages".text.xl.make()),
              ),
            ),
            const Divider(),
            HeightBox(context.percentHeight * 40),
            const FooterSection(),
            // ElasticInRight(
            //     delay: Duration(milliseconds: 100),
            //     child: "Version 1.0.0".text.makeCentered()),
          ],
        ),
      ),
    );
  }
}
