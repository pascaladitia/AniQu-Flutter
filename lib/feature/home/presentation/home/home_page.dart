import 'package:aniqu_flutter/core/l10n/app_localizations.dart';
import 'package:aniqu_flutter/core/widgets/app_error_dialog.dart';
import 'package:aniqu_flutter/feature/home/data/models/anime/anime_item_model.dart';
import 'package:aniqu_flutter/feature/home/presentation/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels > _scrollController.position.maxScrollExtent - 500) {

    }
  }

  @override
  void dispose() {
    _scrollController
    ..removeListener(_onScroll)
    ..dispose();
    super.dispose();
  }

  void _openDetail(AnimeItemModel animeItem) {

  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeCubit>()..loadInitial(),
      child: Builder(
        builder: (context) {
          final l10n = AppLocalizations.of(context);
          final colors = Theme.of(context).colorScheme;

          return Scaffold(
            backgroundColor: colors.surface,
            body: RefreshIndicator(
              onRefresh: () => context.read<HomeCubit>().loadInitial(),
              child: BlocListener<HomeCubit, HomeState>(
                listenWhen: (previous, current) => previous.error != current.error && current.error != null,
                listener: (context, state) => showAppErrorDialog(context, message: state.error!),
              ),
            ),
          );
        }
      ),
    );
  }

}
