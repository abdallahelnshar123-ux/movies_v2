import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/utils/screen_size.dart';

import '../../../../../widgets/main_loading_widget.dart';

class ScreenShotsWidget extends StatelessWidget {
  final List<String ?> screenShotsList;

  const ScreenShotsWidget({super.key, required this.screenShotsList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(16),
        clipBehavior: Clip.antiAlias,
        child: CachedNetworkImage(
          width: context.width,
          height: context.width /2.5,
          fit: BoxFit.cover,
          imageUrl: screenShotsList[index] ?? '',
          placeholder: (context, url) => MainLoadingWidget(),
          errorWidget: (context, url, error) => Icon(Icons.error),

        ),
      ),
      separatorBuilder: (context, index) => SizedBox(height: 10),
      itemCount: screenShotsList.length,
    );
  }
}
