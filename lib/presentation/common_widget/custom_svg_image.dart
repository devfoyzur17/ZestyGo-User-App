import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final bool isNetworkImage;
  final Color? color;

  const CustomSvgImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.isNetworkImage = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return isNetworkImage
        ? SvgPicture.network(
            imagePath,
            width: width,
            height: height,
            fit: fit,
            colorFilter: color != null
                ? ColorFilter.mode(color!, BlendMode.srcIn)
                : null,
            placeholderBuilder: (context) => const CircularProgressIndicator(),
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error),
          )
        : SvgPicture.asset(
            imagePath,
            width: width,
            height: height,
            fit: fit,
            colorFilter: color != null
                ? ColorFilter.mode(color!, BlendMode.srcIn)
                : null,
            placeholderBuilder: (context) => const CircularProgressIndicator(),
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error),
          );
  }
}
