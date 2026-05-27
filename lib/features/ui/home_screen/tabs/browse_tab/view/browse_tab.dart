import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/ui/home_screen/tabs/browse_tab/view/widgets/genres_tab_bar.dart';
import 'package:movies/widgets/main_error_widget.dart';
import 'package:movies/widgets/movie_list_widget.dart';

import '../../../../../../core/utils/screen_size.dart';
import '../../../../../../widgets/movie_list_shimmer_widget.dart';
import '../browse_state.dart';
import '../cubit/browse_view_model.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(keepScrollOffset: true)
      ..addListener(onScroll);
  }

  @override
  void dispose() {
    scrollController.removeListener(onScroll);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        spacing: context.width * 0.04,
        children: [
          BlocBuilder<BrowseCubit, BrowseState>(
            builder: (context, state) {
              return GenresTabBar();
            },
          ),
          Expanded(
            child: BlocBuilder<BrowseCubit, BrowseState>(
              builder: (context, state) {
                if (state is BrowseErrorState) {
                  return MainErrorWidget(
                    errorMessage: state.message,
                    onPressed: () {
                      context.read<BrowseCubit>().getBrowseMovies();
                    },
                    widgetHeight: context.height,
                  );
                }

                if (state is BrowseSuccessState) {
                  return MovieListWidget(
                    scrollController: scrollController,
                    isPaginationLoading: state.isPaginationLoading,
                    moviesList: state.moviesList,
                  );
                }

                return MovieListShimmerWidget();
              },
            ),
          ),
        ],
      ),
    );
  }

  void onScroll() {
    final cubit = context.read<BrowseCubit>();

    if (cubit.isFetching || cubit.hasReachedMax) {
      return;
    }
    final maxScroll = scrollController.position.maxScrollExtent;

    final currentScroll = scrollController.position.pixels;

    if (currentScroll >= maxScroll - 400) {
      cubit.getBrowseMovies(isPagination: true);
    }
  }
}
