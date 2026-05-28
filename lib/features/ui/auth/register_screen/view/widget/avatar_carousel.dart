import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/ui/auth/cubit/auth_view_model.dart';

import '../../../../../../core/utils/app_assets.dart';
import '../../../../../../core/utils/screen_size.dart';

class AvatarCarousel extends StatelessWidget {
  AvatarCarousel({super.key});

  final List<String> avatars = [
    AppAssets.avatarImage1,
    AppAssets.avatarImage2,
    AppAssets.avatarImage3,
    AppAssets.avatarImage4,
    AppAssets.avatarImage5,
    AppAssets.avatarImage6,
    AppAssets.avatarImage7,
    AppAssets.avatarImage8,
    AppAssets.avatarImage9,
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      disableGesture: true,
      options: CarouselOptions(
        onPageChanged: (index, reason) =>
            context.read<AuthCubit>().changeSelectedIndex = index,
        height: context.height * 0.13,
        initialPage: 0,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        enlargeFactor: .3,
        viewportFraction: 0.35,
      ),
      items: avatars
          .map(
            (avatar) => Container(
              width: context.height * 0.13,
              height: context.height * 0.13,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(avatar),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
