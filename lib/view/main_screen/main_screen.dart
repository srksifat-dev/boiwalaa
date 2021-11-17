import 'package:badges/badges.dart';
import 'package:boiwalaa/controller/auth_controller.dart';
import 'package:boiwalaa/controller/cart_controller.dart';
import 'package:boiwalaa/controller/message_controller.dart';
import 'package:boiwalaa/controller/network_controller.dart';
import 'package:boiwalaa/controller/order_controller.dart';
import 'package:boiwalaa/controller/user_controller.dart';
import 'package:boiwalaa/model/section.dart';
import 'package:boiwalaa/services/database.dart';
import 'package:boiwalaa/view/account_screen/account_screen.dart';
import 'package:boiwalaa/view/author_screen/author_screen.dart';
import 'package:boiwalaa/view/cart_screen/cart_screen.dart';
import 'package:boiwalaa/view/category_screen/category_screen.dart';
import 'package:boiwalaa/view/global_widget/image_slider.dart';
import 'package:boiwalaa/view/global_widget/product_section.dart';
import 'package:boiwalaa/view/home_screen/new_home_screen.dart';
import 'package:boiwalaa/view/message/message_screen.dart';
import 'package:boiwalaa/view/offer_screen/offer_screen.dart';
import 'package:boiwalaa/view/publication_screen/publication_screen.dart';
import 'package:boiwalaa/view/search_screen/demo_search.dart';
import 'package:boiwalaa/view/search_screen/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:velocity_x/velocity_x.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final cartController = Get.put(CartController());
  final orderController = Get.put(OrderController());
  final messageController = Get.put(MessageController());
  final authController = Get.put(AuthController());
  final userController = Get.put(UserController());
  final networkController = Get.find<NetworkController>();

  final ScrollController _scrollController = ScrollController();

  bool scrollUp = false;

  DateTime? lastPressed;

  @override
  void initState() {
    userController.obsUser.bindStream(Database().getUser());
    userController.obsAddressList.bindStream(Database().getAddressList());
    final initScreen = GetStorage().read("initScreen");
    initScreen == 0 || initScreen == null
        ? Future.delayed(Duration(seconds: 2)).then((_) {
            messageController.showMessageOnTheFly(
              title: userController.user.name == "Your name"
                  ? "Welcome to Boiwalaa"
                  : "Welcome ${userController.user.name} to Boiwalaa",
              startingMessageBody:
                  "Get extra 50% discount in your first purchase! Just use ",
              endingMessageBody: "coupon code.",
              coupon: "newUser",
            );
          })
        : Future.delayed(const Duration(seconds: 2)).then((_) {
            messageController.showMessageOnTheFly(
                title: userController.user.name == "Your name"
                    ? "Welcome back to Boiwalaa"
                    : "Welcome back ${userController.user.name}",
                startingMessageBody:
                    "You get 10% extra discount offer! Just use ",
                endingMessageBody: " coupon code",
                coupon: "wbo10");
            super.initState();
          });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();
        const maxDuration = Duration(seconds: 2);
        final isWarning =
            lastPressed == null || now.difference(lastPressed!) > maxDuration;

        if (isWarning) {
          lastPressed = DateTime.now();

          await Future.delayed(const Duration(milliseconds: 100));
          SchedulerBinding.instance?.addPostFrameCallback((_) {
            _scrollController.animateTo(
                _scrollController.position.minScrollExtent,
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn);
          });

          Fluttertoast.showToast(
              msg: "Press back again to close the app",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              // backgroundColor: AppColors.deepRed,
              textColor: Colors.white,
              fontSize: 16.0);

          // final snackBar = SnackBar(
          //   content: Text('Double Tap To Close App'),
          //   duration: maxDuration,
          // );

          // ScaffoldMessenger.of(context)
          //   ..removeCurrentSnackBar()
          //   ..showSnackBar(snackBar);

          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            // showSearch(context: context, delegate: SearchScreen());
            Get.to(() => DemoSearchScreen());
          },
          child: SvgPicture.asset(
            "assets/images/search.svg",
            height: 30,
          ),
        ),
        body: SafeArea(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                title: "Boiwalaa".text.black.make(),
                floating: true,
                snap: true,
                actions: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                        CupertinoPageRoute(builder: (_) => AccountScreen())),
                    child: SvgPicture.asset(
                      "assets/images/user.svg",
                      height: 30,
                    ),
                  ),
                  WidthBox(context.percentWidth * 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          CupertinoPageRoute(builder: (_) => MessageScreen()));
                      messageController.clicked = true;
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/chat.svg",
                          height: 30,
                        ),
                        Positioned(
                          top: 5,
                          right: 0,
                          child: Badge(
                            animationType: BadgeAnimationType.scale,
                            elevation: 0,
                            badgeColor: messageController.clicked
                                ? Colors.transparent
                                : Colors.red,
                          ),
                        )
                      ],
                    ),
                  ),
                  WidthBox(context.percentWidth * 5),
                  GestureDetector(
                    onTap:
                        // cartController.cart.isEmpty
                        //     ? () {
                        //         Fluttertoast.showToast(
                        //             msg: "You have no item in cart");
                        //       }
                        //     :
                        () => Navigator.of(context).push(
                            CupertinoPageRoute(builder: (_) => CartScreen())),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(right: context.percentWidth * 5),
                          child: SvgPicture.asset(
                            "assets/images/cart.svg",
                            height: 30,
                          ),
                        ),
                        Positioned(
                          top: 3,
                          right: 8,
                          child: Obx(() => Badge(
                                elevation: 0,
                                badgeColor: Colors.red,
                                showBadge:
                                    cartController.cart.isEmpty ? false : true,
                                badgeContent: cartController.cart.length
                                    .toString()
                                    .text
                                    .white
                                    .make(),
                              )),
                        )
                      ],
                    ),
                  ),
                  // WidthBox(context.percentWidth * 5),
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Obx(() => networkController.connectionStatus.value == 0
                      ? MaterialBanner(
                          leading: const Icon(
                            Icons.info,
                            color: Colors.black,
                          ),
                          backgroundColor: Colors.amber,
                          content: "You have no Internet Connection."
                              .text
                              .black
                              .make(),
                          actions: [
                              TextButton(onPressed: () {}, child: Text(""))
                            ])
                      : Container()),
                  SizedBox(
                      height: context.percentHeight * 3,
                      width: double.infinity,
                      child: const VxMarquee(
                          text:
                              "***আমাদের অ্যাপটি যতদ্রুত সম্ভব প্লে-স্টোরে রিলিজ হবে। সে পর্যন্ত আমাদের সোশ্যাল মিডিয়ার মাধ্যমে কেনাকাটা করুন যে কোনো বই***")),
                  imgSlider()
                ]),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                return Column(
                  children: [
                    sections[index],
                    HeightBox(context.percentHeight * 3)
                  ],
                );
              }, childCount: sections.length)),
            ],
          ),
        ),
      ),
    );
  }
}
