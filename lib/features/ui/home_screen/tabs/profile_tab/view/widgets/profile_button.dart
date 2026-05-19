import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/ui/auth/cubit/auth_view_model.dart';
import 'package:movies/widgets/custom_elevated_button.dart';

import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../../../core/utils/app_routes.dart';
import '../../../../../../../core/utils/app_styles.dart';
import '../../../../../../../core/utils/screen_size.dart';
import '../../../../../auth/auth_state.dart';

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
    icon = BlocConsumer<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLogoutLoading) {
          return CircularProgressIndicator(color: AppColors.whiteColor);
        }

        return Icon(Icons.logout, color: AppColors.whiteColor);
      },
      listenWhen: (previous, current) {
        return current is AuthLogoutError || current is AuthUnauthenticated;
      },
      listener: (BuildContext context, AuthState state) {
        if (state is AuthUnauthenticated) {

          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.loginRouteName,
            (route) => false,
          );

          context.read<AuthCubit>().currentUser = null;
        }
        if (state is AuthLogoutError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: AppStyles.robotoRegular14White(context),
              ),
              backgroundColor: AppColors.whiteColor,
            ),
          );
        }
      },
    );
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
