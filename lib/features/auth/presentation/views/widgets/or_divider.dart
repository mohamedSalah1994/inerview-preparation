import 'package:flutter/material.dart';

import '../../../../../core/utils/app_text_styles.dart';


class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: Color(0xffDDDFDF))),
        SizedBox(
          width: 24,
        ),
        Text(
          'Or',
          style: TextStyles.semiBold16,
        ),
        SizedBox(
          width: 24,
        ),
        Expanded(child: Divider(color: Color(0xffDDDFDF))),
      ],
    );
  }
}
