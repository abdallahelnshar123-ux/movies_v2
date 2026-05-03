import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../core/utils/app_assets.dart';
import '../core/utils/app_colors.dart';


class ChangeLanguageItem extends StatelessWidget {
  bool iseSelected = true;

  ChangeLanguageItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.yellowColor),
        ),
        child: Row(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => context.setLocale(Locale('en')),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: context.locale.languageCode == 'en'
                    ? AppColors.yellowColor
                    : Colors.transparent,
                child: Image.asset(AppAssets.usaLogo, width: 30),
              ),
            ),
            // const SizedBox(width: 10),
            GestureDetector(
              onTap: () => context.setLocale(Locale('ar')),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: context.locale.languageCode == 'en'
                    ? AppColors.transparentColor
                    : AppColors.yellowColor,
                child: CircleAvatar(
                  radius: 14,
                  backgroundImage: AssetImage(AppAssets.egyptLogo),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
