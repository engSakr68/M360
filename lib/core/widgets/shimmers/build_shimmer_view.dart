import 'package:flutter/material.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:shimmer/shimmer.dart';

class BuildShimmerView extends StatelessWidget {
  final double? width;
  final double height;
  final BoxShape? boxShape;
  final EdgeInsetsGeometry? margin;

  const BuildShimmerView({super.key, this.width, this.boxShape, this.margin, required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.colors.shimmerBg,
      highlightColor: context.colors.shimmerColor,
      child: Container(
        margin: margin,
        width: width ?? MediaQuery.of(context).size.width,
        height: height,
        decoration: BoxDecoration(
          color: context.colors.shimmerColor,
          shape: boxShape ?? BoxShape.rectangle,
        ),
      ),
    );
  }
}
