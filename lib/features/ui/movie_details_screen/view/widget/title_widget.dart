import 'package:flutter/material.dart';

import '../../../../../core/utils/app_styles.dart';

class TitleWidget extends StatelessWidget {
  final String text;

  const TitleWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppStyles.robotoBold24White(context),
      textAlign: TextAlign.start,
    );
  }
}
