import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/utils/app_assets.dart';
import '../core/utils/app_colors.dart';
import '../core/utils/screen_size.dart';

class MovieItem extends StatelessWidget {
  final String imageUrl;

  final double? containerWidth;
  final double? containerHeight;
  final double containerPadding;

  final String rating;

  final TextStyle ratingTextStyle;
  final double startSize;
  final double ratingPaddingVertical;
  final double containerBorderRadius;

  final double ratingBorderRadius;

  final double ratingPaddingHorizontal;

  const MovieItem({
    super.key,
    required this.imageUrl,
    this.containerWidth,
    required this.rating,
    required this.ratingTextStyle,
    required this.startSize,
    required this.ratingPaddingHorizontal,
    required this.ratingPaddingVertical,
    required this.containerPadding,
    this.containerHeight,
    required this.containerBorderRadius,
    required this.ratingBorderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(containerPadding),
      alignment: AlignmentDirectional.topStart,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(containerBorderRadius),
        image: DecorationImage(
          image: CachedNetworkImageProvider(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      width: containerWidth ?? double.infinity,
      height: containerHeight ?? double.infinity,

      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ratingPaddingHorizontal,
          vertical: ratingPaddingVertical,
        ),
        decoration: BoxDecoration(
          color: AppColors.blurColor,
          borderRadius: BorderRadius.circular(ratingBorderRadius),
        ),
        child: Row(
          spacing: context.width * .015,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(rating, style: ratingTextStyle),
            SvgPicture.asset(
              AppAssets.starIcon,
              width: startSize,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
