import 'package:flutter/material.dart';
import 'package:movies/core/constants/app_constants.dart';
import 'package:movies/core/utils/app_assets.dart';
import 'package:movies/domain/entities/response/user/my_user.dart';

import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../../../core/utils/app_styles.dart';
import '../../../../../../../core/utils/screen_size.dart';

class UserDataWidget extends StatelessWidget {
  final MyUser? currentUser;

  const UserDataWidget({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: context.height * 0.015,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: context.width * 0.25,
          height: context.width * 0.25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.darkGrayColor,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                currentUser?.avatarIndex != -1
                    ? AppConstants.avatarList[currentUser?.avatarIndex ?? -1]
                    : AppAssets.fallbackUserImage,
              ),
            ),
          ),
        ),
        Text(
          currentUser?.name ?? '',
          style: AppStyles.robotoBold20White(context),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
