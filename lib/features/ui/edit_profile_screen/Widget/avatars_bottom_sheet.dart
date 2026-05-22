import 'package:flutter/material.dart';
import 'package:movies/core/constants/app_constants.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/screen_size.dart';

class SelectAvatarBottomSheet extends StatelessWidget {
  final ValueChanged<int> newAvatarIndex;
  final int currentAvatarIndex;

  const SelectAvatarBottomSheet({
    super.key,
    required this.newAvatarIndex,
    required this.currentAvatarIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: context.height * 0.03,
        horizontal: context.width * 0.025,
      ),

      decoration: BoxDecoration(
        color: AppColors.darkGrayColor,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: GridView.builder(
        padding: EdgeInsetsGeometry.all(context.width * 0.025),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          mainAxisExtent: 135,
        ),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            if (currentAvatarIndex == index) return;
            newAvatarIndex(index);
            Navigator.pop(context);
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppConstants.avatarList[index]),
              ),
              color: (currentAvatarIndex == index)
                  ? AppColors.yellowColor
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.yellowColor, width: 2),
            ),
          ),
        ),
        itemCount: AppConstants.avatarList.length,
      ),
    );
  }
}
