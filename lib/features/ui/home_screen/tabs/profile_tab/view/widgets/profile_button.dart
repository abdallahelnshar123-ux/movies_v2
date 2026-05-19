import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies/widgets/custom_elevated_button.dart';

import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../../../core/utils/app_styles.dart';
import '../../../../../../../core/utils/screen_size.dart';

class ProfileButton extends StatelessWidget {
  late final String label;
  late final Color backgroundColor;
  late final Color textColor;
  final VoidCallback onPressed;
  late final Widget? icon;

  ProfileButton.exit({super.key, required this.onPressed}) {
    backgroundColor = AppColors.redColor;
    textColor = AppColors.whiteColor;
    label = 'exit'.tr();
    icon = const Icon(Icons.logout, color: AppColors.whiteColor);
  }

  ProfileButton.editProfile({super.key, required this.onPressed}) {
    textColor = AppColors.blackColor;
    backgroundColor = AppColors.yellowColor;
    icon = null;
    label = 'edit_Profile'.tr();
  }

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      backgroundColor: backgroundColor,
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: context.width * 0.01,
        children: [
          Text(
            label,
            style: AppStyles.robotoRegular16DarkGray(
              context,
            ).copyWith(color: textColor, fontWeight: FontWeight.w600),
          ),
          ?icon,
        ],
      ),
    );
  }
}
