import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';


class DontHaveAccount extends StatelessWidget {
  const DontHaveAccount({
    super.key, required this.firstText, required this.secondText, required this.onTap,
  });
  final String firstText;
  final String secondText;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
            text: firstText,
            style:
                TextStyles.semiBold16.copyWith(color: const Color(0xff616A6B)),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = onTap,
            text: secondText,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
