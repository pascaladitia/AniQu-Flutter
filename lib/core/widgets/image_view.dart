import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/api_constants.dart';
import '../theme/app_theme_extensions.dart';

class ImageView extends StatelessWidget {
  final String? path;
  final double width;
  final double height;
  final double borderRadius;

  const ImageView({
    super.key,
    required this.path,
    this.width = 110,
    this.height = 160,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppCustomColors>()!;

    if (path == null || path!.isEmpty) {
      return SizedBox(
        width: width,
        height: height,
        child: ColoredBox(
          color: customColors.posterPlaceholder,
          child: const Icon(Icons.image_not_supported_outlined),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        width: width,
        height: height,
        fit: BoxFit.cover,
        imageUrl: path!,

        placeholder: (context, url) => _ShimmerLoading(
          width: width,
          height: height,
          borderRadius: borderRadius,
          baseColor: customColors.posterPlaceholder,
          highlightColor: customColors.posterPlaceholderShimmer,
        ),

        errorWidget: (context, url, error) => SizedBox(
          width: width,
          height: height,
          child: ColoredBox(
            color: customColors.posterPlaceholder,
            child: const Icon(Icons.broken_image_outlined),
          ),
        ),
      ),
    );
  }
}

class _ShimmerLoading extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Color baseColor;
  final Color highlightColor;

  const _ShimmerLoading({
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.baseColor,
    required this.highlightColor,
  });

  @override
  State<_ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<_ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(-1 + (_controller.value * 2), 0),
              end: Alignment(1 + (_controller.value * 2), 0),
              colors: [
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
              ],
              stops: const [0.25, 0.5, 0.75],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: widget.baseColor,
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
          ),
        );
      },
    );
  }
}