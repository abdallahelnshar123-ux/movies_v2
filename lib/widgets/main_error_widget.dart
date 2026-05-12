

import 'package:flutter/material.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/screen_size.dart';

class MainErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onPressed;
  final double widgetHeight;

  const MainErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onPressed,
    required this.widgetHeight
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height:widgetHeight ,
      width: double.infinity,
      padding: EdgeInsets.only(top: context.height * 0.35),
      child: Column(
        spacing: context.height * 0.01,
        children: [
          Text(errorMessage, style: Theme.of(context).textTheme.titleMedium),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:  AppColors.yellowColor,
            ),
            onPressed: onPressed,
            child: Text(
              'try again',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ],
      ),
    );
  }
}
