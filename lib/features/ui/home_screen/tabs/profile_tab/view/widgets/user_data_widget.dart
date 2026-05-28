import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/constants/app_constants.dart';
import 'package:movies/core/utils/app_assets.dart';
import 'package:movies/domain/entities/response/user/my_user.dart';
import 'package:movies/features/ui/auth/auth_state.dart';

import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../../../core/utils/app_styles.dart';
import '../../../../../../../core/utils/screen_size.dart';
import '../../../../../auth/cubit/auth_view_model.dart';

class UserDataWidget extends StatelessWidget {
  const UserDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (BuildContext context, AuthState state) {
        final MyUser currentUser = context.read<AuthCubit>().currentUser!;

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
                    currentUser.avatarIndex != -1
                        ? AppConstants.avatarList[currentUser.avatarIndex]
                        : AppAssets.fallbackUserImage,
                  ),
                ),
              ),
            ),
            Text(
              currentUser.name,
              style: AppStyles.robotoBold20White(context),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
      buildWhen: (previous, current) =>
          current is AuthAuthenticated ||
          current is AccountDetailsUpdateSuccess,
    );
  }
}
