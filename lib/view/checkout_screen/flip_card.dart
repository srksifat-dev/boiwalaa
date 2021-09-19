import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:badges/badges.dart';
import '/controller/auth_controller.dart';
import '/model/address.dart';
import '/model/cart.dart';
import '/model/order.dart';
import '/view/global_widget/custom_text_field.dart';
import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

import '/controller/cart_controller.dart';
import '/controller/order_controller.dart';
import '/view/theme/colors.dart';

class FlipCard extends StatefulWidget {
  const FlipCard({
    Key? key,
  }) : super(key: key);
  @override
  _FlipCardState createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard> {
  final cartController = Get.find<CartController>();
  final orderController = Get.find<OrderController>();
  final authController = Get.find<AuthController>();
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController detailsAddress = TextEditingController();
  TextEditingController transactionID = TextEditingController();

  TextEditingController name = TextEditingController();
  TextEditingController contactNumber = TextEditingController();
  TextEditingController email = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode contactNumberFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();

  FocusNode detailsAddressFocusNode = FocusNode();
  FocusNode transactionIDFocusNode = FocusNode();

  DeliveryMethod _deliveryMethod = DeliveryMethod.cod;
  DeliveryPlace _deliveryPlace = DeliveryPlace.inside;

  //declare the isBack bool
  bool isBack = true;
  double angle = 0;

  Object? selectedRadio;

  bool saveAddress = false;

  int selectedBadge = 0;

  @override
  void initState() {
    name.text = authController.name;
    contactNumber.text = authController.contactNumber;
    email.text = authController.email;
    selectedRadio = 1;
    if (authController.addressList.isNotEmpty &&
        authController.addressList[0].country != "") {
      country.text = authController.addressList[0].country;
    }
    if (authController.addressList.isNotEmpty &&
        authController.addressList[0].state != "") {
      state.text = authController.addressList[0].state;
    }
    if (authController.addressList.isNotEmpty &&
        authController.addressList[0].city != "") {
      city.text = authController.addressList[0].city;
    }
    if (authController.addressList.isNotEmpty &&
        authController.addressList[0].detailAddress != "") {
      detailsAddress.text = authController.addressList[0].detailAddress;
    }
    super.initState();
  }

  void _flip() {
    setState(() {
      angle = (angle + pi) % (2 * pi);
    });
  }

  Color _toggleBadgeColor(Address address) {
    // setState(() {
    // for (Address newAddress in authController.addressList) {
    if (authController.addressList.indexOf(address) == selectedBadge) {
      return AppColors.deepAmber;
    }
    // }
    return AppColors.mediumAmber;
    // });
  }

  Color _toggleBadgeContentColor(Address address) {
    // setState(() {
    // for (Address newAddress in authController.addressList) {
    if (authController.addressList.indexOf(address) == selectedBadge) {
      return Colors.white;
    }
    // }
    return Colors.black;
    // });
  }

  String orderID() {
    const length = 7;
    const letterLowercase = "abcdefghijklmnopqrstuvwxyz";
    const letterUppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const numbers = "0123456789";

    String chars = "";
    chars += "$letterLowercase$numbers$letterUppercase";
    // chars += "$numbers";

    return List.generate(length, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);

      return chars[indexRandom];
    }).join("");
  }

  setSelectedRadio(Object? val) {
    setState(() {
      selectedRadio = val;
    });
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    final orderTotalPrice = (cartController.sumCartPrice() +
            orderController.deliveryCharge(_deliveryPlace, _deliveryMethod))
        .toString();
    final deliveryCharge =
        (orderController.deliveryCharge(_deliveryPlace, _deliveryMethod))
            .toString();
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: angle),
      duration: const Duration(seconds: 1),
      builder: (BuildContext context, double val, __) {
        //here we will change the isBack val so we can change the content of the card
        if (val >= (pi / 2)) {
          isBack = false;
        } else {
          isBack = true;
        }
        return Transform(
          //let's make the card flip by it's center
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(val),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: context.percentHeight * 27,
                child: ElasticIn(
                  duration: const Duration(milliseconds: 1000),
                  child: Container(
                      width: context.percentWidth * 90,
                      height: context.percentHeight * 63,
                      decoration: BoxDecoration(
                        color: AppColors.lightAmber,
                        borderRadius:
                            BorderRadius.circular(context.percentWidth * 5),
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(
                            left: context.percentWidth * 5,
                            right: context.percentWidth * 5,
                            top: context.percentWidth * 6,
                          ),
                          child: isBack
                              ? SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      "Checkout Info".text.xl2.bold.make(),
                                      HeightBox(context.percentHeight * 1),
                                      Form(
                                        child: Column(
                                          children: [
                                            customTextField(
                                              context: context,
                                              controller: name,
                                              focusNode: nameFocusNode,
                                              onFieldSubmitted: (term) {
                                                _fieldFocusChange(
                                                    context,
                                                    nameFocusNode,
                                                    contactNumberFocusNode);
                                              },
                                              hintText: "Ful Name",
                                              fillColor: AppColors.deepAmber
                                                  .withOpacity(0.2),
                                              borderColor: AppColors.deepAmber,
                                            ),
                                            HeightBox(
                                                context.percentHeight * 1),
                                            customTextField(
                                              context: context,
                                              controller: contactNumber,
                                              focusNode: contactNumberFocusNode,
                                              onFieldSubmitted: (term) {
                                                _fieldFocusChange(
                                                    context,
                                                    contactNumberFocusNode,
                                                    emailFocusNode);
                                              },
                                              hintText: "Contact No.",
                                              fillColor: AppColors.deepAmber
                                                  .withOpacity(0.2),
                                              borderColor: AppColors.deepAmber,
                                              textInputType:
                                                  TextInputType.phone,
                                            ),
                                            HeightBox(
                                                context.percentHeight * 1),
                                            customTextField(
                                              context: context,
                                              controller: email,
                                              focusNode: emailFocusNode,
                                              textInputAction:
                                                  TextInputAction.done,
                                              onFieldSubmitted: (term) {
                                                emailFocusNode.unfocus();
                                              },
                                              hintText: "Email Address",
                                              fillColor: AppColors.deepAmber
                                                  .withOpacity(0.2),
                                              borderColor: AppColors.deepAmber,
                                              textInputType:
                                                  TextInputType.emailAddress,
                                              textCapitalization:
                                                  TextCapitalization.none,
                                            ),
                                          ],
                                        ),
                                      ),
                                      HeightBox(context.percentHeight * 2),
                                      "Billing Address".text.xl2.bold.make(),
                                      // TextFormField(
                                      //   controller: country,
                                      //   decoration: InputDecoration(
                                      //     hintText: "Country",
                                      //     filled: true,
                                      //     fillColor: AppColors.deepRed
                                      //         .withOpacity(0.2),
                                      //     contentPadding: EdgeInsets.symmetric(
                                      //         horizontal:
                                      //             context.percentWidth * 5,
                                      //         vertical:
                                      //             context.percentWidth * 3),
                                      //     enabledBorder: UnderlineInputBorder(
                                      //       borderSide: BorderSide(
                                      //           color: AppColors.deepRed),
                                      //     ),
                                      //     focusedBorder: UnderlineInputBorder(
                                      //       borderSide: BorderSide(
                                      //           color: AppColors.deepRed),
                                      //     ),
                                      //   ),
                                      // ),
                                      // TextFormField(
                                      //   controller: state,
                                      //   decoration: InputDecoration(
                                      //     hintText: "State",
                                      //     filled: true,
                                      //     fillColor: AppColors.deepRed
                                      //         .withOpacity(0.2),
                                      //     contentPadding: EdgeInsets.symmetric(
                                      //         horizontal:
                                      //             context.percentWidth * 5,
                                      //         vertical:
                                      //             context.percentWidth * 3),
                                      //     enabledBorder: UnderlineInputBorder(
                                      //       borderSide: BorderSide(
                                      //           color: AppColors.deepRed),
                                      //     ),
                                      //     focusedBorder: UnderlineInputBorder(
                                      //       borderSide: BorderSide(
                                      //           color: AppColors.deepRed),
                                      //     ),
                                      //   ),
                                      // ),
                                      // TextFormField(
                                      //   controller: city,
                                      //   decoration: InputDecoration(
                                      //     hintText: "City",
                                      //     filled: true,
                                      //     fillColor: AppColors.deepRed
                                      //         .withOpacity(0.2),
                                      //     contentPadding: EdgeInsets.symmetric(
                                      //         horizontal:
                                      //             context.percentWidth * 5,
                                      //         vertical:
                                      //             context.percentWidth * 3),
                                      //     enabledBorder: UnderlineInputBorder(
                                      //       borderSide: BorderSide(
                                      //           color: AppColors.deepRed),
                                      //     ),
                                      //     focusedBorder: UnderlineInputBorder(
                                      //       borderSide: BorderSide(
                                      //           color: AppColors.deepRed),
                                      //     ),
                                      //   ),
                                      // ),
                                      if (authController.addressList.isNotEmpty)
                                        SizedBox(
                                          height: context.percentHeight * 5,
                                          width: context.percentWidth * 80,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: authController
                                                  .addressList.length,
                                              itemBuilder: (context, index) {
                                                final address = authController
                                                    .addressList[index];
                                                return GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      selectedBadge = index;
                                                    });
                                                    country.text =
                                                        address.country;
                                                    state.text = address.state;
                                                    city.text = address.city;
                                                    detailsAddress.text =
                                                        address.detailAddress;
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: context
                                                                .percentHeight *
                                                            1.5,
                                                        right: context
                                                                .percentWidth *
                                                            2),
                                                    child: Badge(
                                                      animationDuration:
                                                          const Duration(
                                                        milliseconds: 300,
                                                      ),
                                                      animationType:
                                                          BadgeAnimationType
                                                              .scale,
                                                      elevation: 0,
                                                      shape: BadgeShape.square,
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                              horizontal: 15,
                                                              vertical: 2),
                                                      borderRadius: BorderRadius
                                                          .circular(context
                                                                  .percentWidth *
                                                              5),
                                                      badgeColor:
                                                          _toggleBadgeColor(
                                                              address),
                                                      badgeContent:
                                                          address.addressName
                                                              .text
                                                              .color(
                                                                  _toggleBadgeContentColor(
                                                                      address))
                                                              .makeCentered(),
                                                      // : "${queryPublicationList[index]}"
                                                      //     .text
                                                      //     .makeCentered(),
                                                      alignment:
                                                          Alignment.center,
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      HeightBox(context.percentHeight * 1),
                                      CountryStateCityPicker(
                                        country: country,
                                        state: state,
                                        city: city,
                                        textFieldInputBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.deepAmber),
                                        ),
                                      ),
                                      HeightBox(context.percentHeight * 1),
                                      customTextField(
                                        context: context,
                                        controller: detailsAddress,
                                        focusNode: detailsAddressFocusNode,
                                        textInputAction: TextInputAction.done,
                                        onFieldSubmitted: (term) {
                                          detailsAddressFocusNode.unfocus();
                                        },
                                        hintText: "Detail Address",
                                        fillColor:
                                            AppColors.deepAmber.withOpacity(0.2),
                                        borderColor: AppColors.deepAmber,
                                      ),
                                      // HeightBox(context.percentHeight * 2),
                                      Row(
                                        children: [
                                          Checkbox(
                                            activeColor: AppColors.deepAmber,
                                            value: saveAddress,
                                            onChanged: (val) => setState(
                                                () => saveAddress = val!),
                                          ),
                                          "Save address for next time purchase"
                                              .text
                                              .make(),
                                        ],
                                      ),
                                      HeightBox(context.percentHeight * 2),
                                      "Select Delivery Option"
                                          .text
                                          .xl2
                                          .bold
                                          .make(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Radio(
                                                value: 1,
                                                groupValue: selectedRadio,
                                                activeColor: AppColors.deepAmber,
                                                onChanged: (val) {
                                                  setSelectedRadio(val);
                                                  setState(() {
                                                    _deliveryMethod =
                                                        DeliveryMethod.cod;
                                                  });
                                                },
                                              ),
                                              const Text("Cash on delivery"),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Radio(
                                                value: 2,
                                                groupValue: selectedRadio,
                                                activeColor: AppColors.deepAmber,
                                                onChanged: (val) {
                                                  setSelectedRadio(val);
                                                  setState(() {
                                                    _deliveryMethod =
                                                        DeliveryMethod.scs;
                                                  });
                                                },
                                              ),
                                              const Text("Sundarban Courier Service"),
                                            ],
                                          ),
                                          HeightBox(context.percentHeight * 15),
                                        ],
                                      ),

                                      // SelectDeliveryOption(
                                      //   city: city,
                                      //   country: country,
                                      //   state: state,
                                      // ),
                                    ],
                                  ),
                                )
                              : Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.identity()..rotateY(pi),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: context.percentWidth * 50,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.deepAmber,
                                                width: 2,
                                                style: BorderStyle.solid),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  context.percentWidth * 3),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                context.percentWidth * 3),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Total: ',
                                                      style: TextStyle(
                                                        color:
                                                            AppColors.deepAmber,
                                                        fontSize: context
                                                                .percentWidth *
                                                            4,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Tk.${cartController.sumCartPrice()}',
                                                      style: TextStyle(
                                                        color:
                                                            AppColors.deepAmber,
                                                        fontSize: context
                                                                .percentWidth *
                                                            4,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  color: AppColors.deepAmber,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Delivery Charge: ',
                                                      style: TextStyle(
                                                        color:
                                                            AppColors.deepAmber,
                                                        fontSize: context
                                                                .percentWidth *
                                                            4,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Tk.$deliveryCharge',
                                                      style: TextStyle(
                                                        color:
                                                            AppColors.deepAmber,
                                                        fontSize: context
                                                                .percentWidth *
                                                            4,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // Divider(
                                                //   color: AppColors.deepRed,
                                                // ),
                                                // Row(
                                                //   mainAxisAlignment:
                                                //       MainAxisAlignment.spaceBetween,
                                                //   children: [
                                                //     Text(
                                                //       'Gift Charge: ',
                                                //       style: TextStyle(
                                                //         color: AppColors.deepRed,
                                                //         fontSize:
                                                //             context.percentWidth * 4,
                                                //       ),
                                                //     ),
                                                //     Text(
                                                //       'Tk.100',
                                                //       style: TextStyle(
                                                //         color: AppColors.deepRed,
                                                //         fontSize:
                                                //             context.percentWidth * 4,
                                                //       ),
                                                //     )
                                                //   ],
                                                // ),
                                                const Divider(
                                                  color: AppColors.deepAmber,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Promo Code Discount: ',
                                                      style: TextStyle(
                                                        color:
                                                            AppColors.deepAmber,
                                                        fontSize: context
                                                                .percentWidth *
                                                            4,
                                                      ),
                                                    ),
                                                    Text(
                                                      '-Tk.0',
                                                      style: TextStyle(
                                                        color:
                                                            AppColors.deepAmber,
                                                        fontSize: context
                                                                .percentWidth *
                                                            4,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  color: AppColors.deepAmber,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Payable Total: ',
                                                      style: TextStyle(
                                                        color:
                                                            AppColors.deepAmber,
                                                        fontSize: context
                                                                .percentWidth *
                                                            4,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Tk.$orderTotalPrice',
                                                      style: TextStyle(
                                                        color:
                                                            AppColors.deepAmber,
                                                        fontSize: context
                                                                .percentWidth *
                                                            4,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  ],
                                                ),

                                                // HeightBox(context.percentHeight * 8),
                                                // Container(
                                                //   decoration: BoxDecoration(
                                                //     borderRadius: BorderRadius.only(
                                                //         bottomRight: Radius.circular(context.percentWidth * 2),
                                                //         bottomLeft: Radius.circular(context.percentWidth * 2)),
                                                //     color: LightColor.customAmber,
                                                //   ),
                                                //   height:context.percentWidth * 11,
                                                //   child: Row(
                                                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                //     children: [
                                                //       GestureDetector(
                                                //         onTap: () => Get.to(GiftShipmentInfoScreen()),
                                                //         child: Container(
                                                //           child: Center(
                                                //             child: Text(
                                                //               'Continue to Gift',
                                                //               style: TextStyle(
                                                //                 fontWeight: FontWeight.bold,
                                                //                 color: AppColors.deepRed,
                                                //                 fontSize: context.percentWidth * 5,
                                                //               ),
                                                //             ),
                                                //           ),
                                                //         ),
                                                //       ),
                                                //       VerticalDivider(
                                                //         color: AppColors.deepRed,
                                                //         thickness: 2,
                                                //       ),
                                                //       GestureDetector(
                                                //         onTap: () => Get.to(ShipmentInfoScreen()),
                                                //         child: Container(
                                                //           child: Center(
                                                //             child: Text(
                                                //               'Continue to Next',
                                                //               style: TextStyle(
                                                //                 fontWeight: FontWeight.bold,
                                                //                 color: AppColors.deepRed,
                                                //                 fontSize: context.percentWidth * 5,
                                                //               ),
                                                //             ),
                                                //           ),
                                                //         ),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        HeightBox(context.percentHeight * 2),
                                        customTextField(
                                          context: context,
                                          controller: transactionID,
                                          focusNode: transactionIDFocusNode,
                                          textInputAction: TextInputAction.done,
                                          onFieldSubmitted: (term) {
                                            transactionIDFocusNode.unfocus();
                                          },
                                          hintText:
                                              "Transaction ID(Bkash/Rocket/Nagad)",
                                          fillColor: AppColors.deepAmber
                                              .withOpacity(0.2),
                                          borderColor: AppColors.deepAmber,
                                        ),
                                        HeightBox(context.percentHeight * 1),
                                        "* Send Money to Bkash personal(01620535560)/ Rocket personal(01620535560)/ Nagad personal(01620535560)"
                                            .text
                                            .gray500
                                            .make(),
                                        HeightBox(context.percentHeight * 12),
                                        TextButton.icon(
                                            icon: const Icon(
                                              Icons.arrow_back,
                                              color: AppColors.deepAmber,
                                            ),
                                            onPressed: _flip,
                                            label: "Back"
                                                .text
                                                .xl2
                                                .bold
                                                .color(AppColors.deepAmber)
                                                .make()),
                                        HeightBox(context.percentHeight * 10),
                                      ],
                                    ),
                                  ),
                                )
                          //if it's back we will display here

                          ) //else we will display it here,
                      ),
                ),
              ),
              Positioned(
                bottom: context.percentHeight * 10,
                left: context.percentWidth * 5,
                right: context.percentWidth * 5,
                child: ElasticIn(
                    duration: const Duration(milliseconds: 1000),
                    child: GestureDetector(
                      onTap: isBack
                          ? () {
                              setState(() {
                                state.text == "Dhaka" || state.text == "dhaka"
                                    ? orderController.deliveryPlace =
                                        DeliveryPlace.inside
                                    : orderController.deliveryPlace =
                                        DeliveryPlace.outside;
                                if (saveAddress == true) {
                                  authController.addressList.add(
                                    Address(
                                        addressName: "My Address",
                                        country: country.text,
                                        state: state.text,
                                        city: city.text,
                                        detailAddress: detailsAddress.text),
                                  );
                                }
                              });
                              _flip();
                            }
                          : () {
                              final List<CartItem> orders = [];
                              final f = DateFormat("yyyy-MM-dd hh:mm");
                              final dateTime = f.format(DateTime.now());
                              for (CartItem cartItem in cartController.cart) {
                                orders.add(cartItem);
                              }
                              final orderItem = OrderItem(
                                orderID: "BO#${orderID()}",
                                name: name.text,
                                email: email.text,
                                contactNo: contactNumber.text,
                                cartItem: orders,
                                orderTime: dateTime,
                                totalPrice: int.parse(orderTotalPrice),
                                country: country.text,
                                state: state.text,
                                city: city.text,
                                detailAddress: detailsAddress.text,
                                deliveryMethod: _deliveryMethod,
                                transactionID: transactionID.text,
                              );
                              orderController.addOrder(orderItem);
                              cartController.cart.clear();
                              cartController.refresh();
                              Fluttertoast.showToast(
                                  msg:
                                      "Your order has been placed. Wait behind the door to get it!",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Get.back();
                            },
                      child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.deepAmber,
                              borderRadius: BorderRadius.circular(
                                context.percentWidth * 5,
                              )),
                          height: context.percentWidth * 14,
                          width: context.percentWidth * 90,
                          child: isBack
                              ? TextButton(
                                  onPressed: () {
                                    setState(() {
                                      state.text == "Dhaka" ||
                                              state.text == "dhaka"
                                          ? _deliveryPlace =
                                              DeliveryPlace.inside
                                          : _deliveryPlace =
                                              DeliveryPlace.outside;
                                      if (saveAddress == true) {
                                        authController.addressList.add(
                                          Address(
                                              addressName: "My Address",
                                              country: country.text,
                                              state: state.text,
                                              city: city.text,
                                              detailAddress:
                                                  detailsAddress.text),
                                        );
                                      }
                                      _flip();
                                    });
                                  },
                                  child: "Pay Now"
                                      .text
                                      .color(AppColors.backgroundWhite)
                                      .xl2
                                      .makeCentered())
                              : Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.identity()..rotateY(pi),
                                  child: TextButton(
                                    onPressed: () {
                                      final List<CartItem> orders = [];
                                      final f = DateFormat("yyyy-MM-dd hh:mm");
                                      final dateTime = f.format(DateTime.now());
                                      for (CartItem cartItem
                                          in cartController.cart) {
                                        orders.add(cartItem);
                                      }
                                      final orderItem = OrderItem(
                                        orderID: "BO#${orderID()}",
                                        name: name.text,
                                        email: email.text,
                                        contactNo: contactNumber.text,
                                        cartItem: orders,
                                        orderTime: dateTime,
                                        totalPrice: int.parse(orderTotalPrice),
                                        country: country.text,
                                        state: state.text,
                                        city: city.text,
                                        detailAddress: detailsAddress.text,
                                        deliveryMethod: _deliveryMethod,
                                        transactionID: transactionID.text,
                                      );
                                      orderController.addOrder(orderItem);
                                      cartController.cart.clear();
                                      cartController.refresh();
                                      Fluttertoast.showToast(
                                          msg:
                                              "Your order has been placed. Wait behind the door to get it!",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      Get.back();
                                    },
                                    child: "Confirm Order"
                                        .text
                                        .color(AppColors.backgroundWhite)
                                        .xl2
                                        .makeCentered(),
                                  ),
                                )),
                    )),
              ),
              Positioned(
                bottom: context.percentHeight * 3,
                child: ElasticIn(
                  duration: const Duration(milliseconds: 1000),
                  child: GestureDetector(
                    onTap: () {
                      // orderController.deliveryMethod = DeliveryMethod.cod;
                      // orderController.deliveryPlace = DeliveryPlace.inside;
                      Get.back();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.5),
                      radius: context.percentWidth * 6,
                      child: const Center(
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
