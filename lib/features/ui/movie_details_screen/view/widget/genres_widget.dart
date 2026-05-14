import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';


class GenresWidget extends StatelessWidget {
  final List<String> genresList;

  const GenresWidget({super.key, required this.genresList});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: genresList.map((genre) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.darkGrayColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(genre, style: AppStyles.robotoRegular16White(context)),
        );
      }).toList(),
    );
  }
}