import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/ui/home_screen/tabs/profile_tab/view/widgets/lists_count.dart';
import 'package:movies/features/ui/home_screen/tabs/profile_tab/view/widgets/profile_button.dart';
import 'package:movies/features/ui/home_screen/tabs/profile_tab/view/widgets/user_data_widget.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_routes.dart';
import '../../../../../../core/utils/screen_size.dart';
import '../../../../auth/cubit/auth_view_model.dart';
import 'widgets/section_switcher.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.only(
            top: context.height * 0.07,
            left: context.width * 0.04,
            right: context.width * 0.04,
          ),
          decoration: BoxDecoration(color: AppColors.darkGrayColor),
          child: Column(
            spacing: context.width * 0.05,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: context.width * 0.04,
                children: [
                  Expanded(flex: 2, child: UserDataWidget()),
                  Expanded(flex: 3, child: ListsCount()),
                ],
              ),
              Row(
                spacing: context.width * 0.04,
                children: [
                  Expanded(
                    flex: 3,
                    child: ProfileButton.editProfile(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.editProfileScreen,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ProfileButton.exit(
                      onPressed: () {
                        context.read<AuthCubit>().logout(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(child: SectionSwitcher()),
      ],
    );
  }
}
