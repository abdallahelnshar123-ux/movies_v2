import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/screen_size.dart';
import '../../../../../domain/entities/response/movie/cast.dart';
import '../../../../../widgets/main_loading_widget.dart';

class CastWidget extends StatelessWidget {
  final List<Cast> castList;

  const CastWidget({super.key, required this.castList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsetsDirectional.only(
            start: context.width * 0.02,
            bottom: context.height * 0.01,
            top: context.height * 0.01,
          ),
          decoration: BoxDecoration(
            color: AppColors.darkGrayColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            spacing: 10,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                width: context.width * 0.14,
                height: context.width * 0.14,
                child: CachedNetworkImage(
                  imageUrl: castList[index].urlSmallImage ?? '',
                  placeholder: (context, url) => MainLoadingWidget(),
                  errorWidget: (context, url, error) =>
                      Image.asset(AppAssets.fallbackUserImage),
                ),
              ),
              Expanded(
                child: Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          context.tr('name:'),
                          style: AppStyles.robotoRegular14White(context),
                        ),
                        Expanded(
                          child: Text(
                            castList[index].name ?? 'No name',
                            style: AppStyles.robotoRegular14White(context),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.tr('character'),
                          style: AppStyles.robotoRegular14White(context),
                        ),
                        Expanded(
                          child: Text(
                            castList[index].characterName ??
                                'no character name',
                            style: AppStyles.robotoRegular14White(context),
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: context.height * 0.015);
      },
      itemCount: castList.length,
    );
  }
}
