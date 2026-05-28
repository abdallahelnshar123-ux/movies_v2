import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/utils/app_styles.dart';
import '../../cubit/history_view_model.dart';
import '../../cubit/watchlist_view_model.dart';

class ListsCount extends StatelessWidget {
  const ListsCount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        builtCountWidget(
          context: context,
          title: 'watch_list'.tr(),
          count: context.watch<WatchListCubit>().watchListMovies.length,
        ),
        builtCountWidget(
          context: context,
          title: 'history'.tr(),
          count: context.watch<HistoryCubit>().historyMovies.length,
        ),
      ],
    );
  }
}

Widget builtCountWidget({
  required BuildContext context,
  required String title,
  required int count,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text('$count', style: AppStyles.robotoBold30White(context)),
      const SizedBox(height: 4),
      Text(title, style: AppStyles.robotoRegular16White(context)),
    ],
  );
}
