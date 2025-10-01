import 'package:flutter/material.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:shimmer/shimmer.dart';

class BaseShimmerWidget extends StatelessWidget {
  final Widget child;
  const BaseShimmerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.colors.background,
      highlightColor: context.colors.greyWhite,
      period: const Duration(milliseconds: 1000),
      child: child,
    );
  }
}
