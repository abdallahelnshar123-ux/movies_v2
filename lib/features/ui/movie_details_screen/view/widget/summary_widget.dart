import 'package:flutter/material.dart';

import '../../../../../core/utils/app_styles.dart';


class SummaryWidget extends StatelessWidget {
  final String summary;

  const SummaryWidget({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Text(summary, style: AppStyles.robotoRegular16White(context));
  }
}
