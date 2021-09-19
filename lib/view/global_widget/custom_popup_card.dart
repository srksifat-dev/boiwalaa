import 'package:animate_do/animate_do.dart';
import 'package:boiwalaa/view/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Future showCustomDialog(
  {required BuildContext context,
  required int cardHeight,
  required int cardWidth,
  required int buttonPosition,
 required Widget child,
  required Widget button,}
) {
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext context, Animation animation,
        Animation secondaryAnimation) {
      return Material(
        color: Colors.transparent,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: context.percentHeight * 27,
              child: ElasticIn(
                duration: const Duration(milliseconds: 1000),
                child: Container(
                  height: context.percentHeight * cardHeight,
                  width: context.percentWidth * cardWidth,
                  decoration: BoxDecoration(
                    color: AppColors.lightAmber,
                    borderRadius:
                        BorderRadius.circular(context.percentWidth * 5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: context.percentWidth * 5,
                      right: context.percentWidth * 5,
                      top: context.percentWidth * 5,
                    ),
                    child: child,
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: context.percentHeight * buttonPosition,
                left: context.percentWidth * 25,
                right: context.percentWidth * 25,
                child: ElasticIn(
                  duration: const Duration(milliseconds: 1000),
                  child: button,
                ),),
            // Positioned(
            //     bottom: context.percentHeight * buttonPosition,
            //     left: context.percentWidth * 5,
            //     right: context.percentWidth * 5,
            //     child: ElasticIn(
            //       duration: const Duration(milliseconds: 1000),
            //       child: GestureDetector(
            //         onTap: onTap,
            //         child: Container(
            //             decoration: BoxDecoration(
            //                 color: AppColors.deepAmber,
            //                 borderRadius: BorderRadius.circular(
            //                   context.percentWidth * 5,
            //                 )),
            //             height: context.percentWidth * 14,
            //             width: context.percentWidth * 90,
            //             child: TextButton(
            //                 onPressed: onTap,
            //                 child: "Confirm Order"
            //                     .text
            //                     .color(AppColors.backgroundWhite)
            //                     .xl2
            //                     .makeCentered())),
            //       ),
            //     ),),
          ],
        ),
      );
    },
  );
}
