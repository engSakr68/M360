import 'package:flutter/material.dart';

class DisableWidget extends StatelessWidget {
  final Widget child;
  final bool disable;

  const DisableWidget({super.key, required this.child, required this.disable});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: disable,
      child: Opacity(
        opacity: disable ? .5 : 1,
        child: child,
      ),
    );
  }
}
