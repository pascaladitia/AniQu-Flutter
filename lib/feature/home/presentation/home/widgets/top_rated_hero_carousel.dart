import 'dart:async';

import 'package:aniqu_flutter/core/theme/app_theme_extensions.dart';
import 'package:aniqu_flutter/core/widgets/image_view.dart';
import 'package:aniqu_flutter/feature/home/data/models/anime/anime_item_model.dart';
import 'package:flutter/material.dart';

class TopRatedHeroCarousel extends StatefulWidget {
  final List<AnimeItemModel> anime;
  final void Function(AnimeItemModel anime) onTapDetail;

  const TopRatedHeroCarousel({
    super.key,
    required this.anime,
    required this.onTapDetail,
  });

  @override
  State<TopRatedHeroCarousel> createState() => _TopRatedHeroCarouselState();
}

class _TopRatedHeroCarouselState extends State<TopRatedHeroCarousel> {
  late final PageController _pageController;
  Timer? _autoTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(viewportFraction: 1);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoTimer?.cancel();
    _autoTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted || widget.anime.length < 2 || !_pageController.hasClients)
        return;
      final nextIndex = (_currentPage + 1) % widget.anime.length;
      _pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void didUpdateWidget(covariant TopRatedHeroCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.anime.length != oldWidget.anime.length) {
      _currentPage = 0;
      _startAutoScroll();
    }
  }

  @override
  void dispose() {
    _autoTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppCustomColors>()!;
    if (widget.anime.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.52,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.anime.length,
            onPageChanged: (value) => setState(() => _currentPage = value),
            itemBuilder: (context, index) {
              final anime = widget.anime[index];
              return InkWell(
                onTap: () => widget.onTapDetail(anime),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ImageView(
                      path: anime.poster,
                      width: double.infinity,
                      height: double.infinity,
                      borderRadius: 0,
                    ),

                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            customColors.imageOverlayTop,
                            customColors.imageOverlayBottom,
                          ],
                          stops: const [0.35, 1],
                        ),
                      ),
                    ),

                    Positioned(
                      left: 20,
                      right: 20,
                      bottom: 26,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            anime.title ?? 'Untitled',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(color: customColors.onImageText),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${anime.statusOrDay}  •  ${anime.type}',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: customColors.onImageSubtleText,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          Positioned(
            right: 20,
            bottom: 14,
            child: Row(
              children: List.generate(
                widget.anime.length > 4 ? 4 : widget.anime.length,
                (dotIndex) {
                  final activeIndex =
                      _currentPage %
                      (widget.anime.length > 4 ? 4 : widget.anime.length);
                  return Container(
                    width: dotIndex == activeIndex ? 22 : 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      color: dotIndex == activeIndex
                          ? Theme.of(context).colorScheme.primary
                          : customColors.indicatorInactive,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
