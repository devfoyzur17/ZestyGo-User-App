import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final double? aspectRatio;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? child;
  final Color? shimmerBaseColor;
  final Color? shimmerHighlightColor;
  final Widget? errorWidget;
  final BoxShape shape;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.aspectRatio,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.child,
    this.shimmerBaseColor,
    this.shimmerHighlightColor,
    this.errorWidget,
    this.shape = BoxShape.rectangle,
  });

  @override
  Widget build(BuildContext context) {
    final shimmerBase = shimmerBaseColor ?? Colors.grey.shade300;
    final shimmerHighlight = shimmerHighlightColor ?? Colors.grey.shade100;

    Widget image = Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;

        return Shimmer.fromColors(
          baseColor: shimmerBase,
          highlightColor: shimmerHighlight,
          child: Container(width: width, height: height, color: shimmerBase),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ??
            Container(
              width: width,
              height: height,
              color: Colors.grey.shade200,
              alignment: Alignment.center,
              child: const Icon(Icons.broken_image, color: Colors.grey),
            );
      },
    );

    // ✅ Apply AspectRatio (optional)
    if (aspectRatio != null) {
      image = AspectRatio(aspectRatio: aspectRatio!, child: image);
    }

    // ✅ Wrap with ClipRRect for rounded corners or shape
    Widget decorated = shape == BoxShape.circle
        ? ClipOval(child: image)
        : ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.circular(0),
            child: image,
          );

    // ✅ Add child overlay if provided
    if (child != null) {
      decorated = Stack(fit: StackFit.expand, children: [decorated, child!]);
    }

    return decorated;
  }
}
