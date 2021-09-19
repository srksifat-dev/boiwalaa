import 'package:animate_do/animate_do.dart';
import '/view/home_screen/utils.dart';
import '/view/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElasticInRight(
          delay: const Duration(
            milliseconds: 100,
          ),
          child: const Text(
            'For any queries: ',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElasticInRight(
              delay: const Duration(milliseconds: 200),
              child: buildButton(
                icon: FaIcon(
                  FontAwesomeIcons.phone,
                  color: AppColors.green,
                  size: context.percentWidth * 7,
                ),
                onClicked: () =>
                    Utils.openPhoneCall(phoneNumber: '+8801883083885'),
              ),
            ),
            ElasticInRight(
              delay: const Duration(milliseconds: 300),
              child: buildButton(
                icon: FaIcon(
                  FontAwesomeIcons.sms,
                  color: AppColors.green,
                  size: context.percentWidth * 7,
                ),
                onClicked: () => Utils.openSMS(phoneNumber: '+8801883083885'),
              ),
            ),
            ElasticInRight(
              delay: const Duration(milliseconds: 400),
              child: buildButton(
                icon: FaIcon(
                  FontAwesomeIcons.solidEnvelope,
                  color: AppColors.green,
                  size: context.percentWidth * 7,
                ),
                onClicked: () => Utils.openEmail(
                  toEmail: "boiwala18@gmail.com",
                  subject: "",
                  body: "",
                ),
              ),
            ),
            ElasticInRight(
              delay: const Duration(milliseconds: 500),
              child: buildButton(
                icon: FaIcon(
                  FontAwesomeIcons.facebookMessenger,
                  color: AppColors.green,
                  size: context.percentWidth * 6.5,
                ),
                onClicked: () => Utils.openLink(url: 'http://m.me/boiwalaa'),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget buildButton({
    required FaIcon icon,
    required VoidCallback onClicked,
  }) =>
      Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 2,
        ),
        child: IconButton(
          icon: icon,
          onPressed: onClicked,
        ),
      );
}
