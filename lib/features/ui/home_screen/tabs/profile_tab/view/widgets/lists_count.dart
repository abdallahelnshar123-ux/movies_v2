import 'package:flutter/material.dart';

import '../../../../../../../core/utils/app_styles.dart';

class ListsCount extends StatelessWidget {
  final int watchListCount;
  final int historyCount;

  const ListsCount({
    super.key,
    required this.watchListCount,
    required this.historyCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        builtCountWidget(
          context: context,
          title: 'Watch List',
          count: watchListCount,
        ),
        builtCountWidget(
          context: context,
          title: 'History',
          count: historyCount,
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
