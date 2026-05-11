import 'package:aniqu_flutter/feature/home/data/models/anime/anime_item_model.dart';
import 'package:aniqu_flutter/feature/home/domain/usecases/get_anime_completed_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_anime_ongoing_usecase.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final List<AnimeItemModel> animeOngoing;
  final List<AnimeItemModel> animeCompleted;
  final int page;
  final bool hasReachedEnd;

  const HomeState({
    required this.isLoading,
    required this.isLoadingMore,
    required this.error,
    required this.animeOngoing,
    required this.animeCompleted,
    required this.page,
    required this.hasReachedEnd,
  });

  factory HomeState.initial() => const HomeState(
    isLoading: false,
    isLoadingMore: false,
    error: null,
    animeOngoing: [],
    animeCompleted: [],
    page: 1,
    hasReachedEnd: false,
  );

  HomeState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    List<AnimeItemModel>? animeOngoing,
    List<AnimeItemModel>? animeCompleted,
    int? page,
    bool? hasReachedEnd,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      animeOngoing: animeOngoing ?? this.animeOngoing,
      animeCompleted: animeCompleted ?? this.animeCompleted,
      page: page ?? this.page,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isLoadingMore,
    error,
    animeOngoing,
    animeCompleted,
    page,
    hasReachedEnd,
  ];
}

class HomeCubit extends Cubit<HomeState> {
  final GetAnimeOngoingUseCase animeOngoingUseCase;
  final GetAnimeCompletedUseCase animeCompletedUseCase;

  HomeCubit({
    required this.animeOngoingUseCase,
    required this.animeCompletedUseCase,
  }) : super(HomeState.initial());

  Future<void> loadInitial() async {
    emit(state.copyWith(isLoading: true));

    final animeOngoingResult = await animeOngoingUseCase();
    final animeCompletedResult = await animeCompletedUseCase();

    if (!animeOngoingResult.isSuccess || !animeCompletedResult.isSuccess) {
      emit(
        state.copyWith(
          isLoading: false,
          error: animeOngoingResult.failure?.message ?? 'Error',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isLoading: false,
        animeOngoing: animeOngoingResult.data,
        animeCompleted: animeCompletedResult.data,
      ),
    );
  }
}
