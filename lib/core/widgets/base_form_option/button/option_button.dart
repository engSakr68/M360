import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:member360/core/constants/app_loader_widget.dart';
import 'package:member360/core/constants/gaps.dart';
import 'package:member360/core/localization/translate.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/core/widgets/base_form_option/button/hint_text.dart';
import 'package:member360/core/widgets/base_form_option/button/option_button_decoration.dart';
import 'package:member360/core/widgets/base_form_option/controller/option_controller.dart';
import 'package:get/get_utils/src/extensions/export.dart';

class OptionsButton<T> extends StatefulWidget {
  final String hintText;
  final OptionController<T> controller;
  final String? iconPath;
  final Function(BuildContext context, T item) valueBuilder;
  final VoidCallback onPressed;
  final VoidCallback? onClearPressed;
  final bool coloredIconWhenValueFilled;
  final bool showDecoration;
  final bool showClearIcon;
  final Widget? customSuffixIcon;
  final BoxConstraints? constraints;
  final Border? border;

  const OptionsButton(
      {super.key,
      required this.hintText,
      this.iconPath,
      required this.controller,
      required this.valueBuilder,
      required this.onPressed,
      this.coloredIconWhenValueFilled = false,
      this.showDecoration = true,
      this.customSuffixIcon,
      this.onClearPressed,
      this.showClearIcon = false,
      this.border,
      this.constraints});

  @override
  State<OptionsButton<T>> createState() => _OptionsButtonState<T>();

  factory OptionsButton.customText({required String hintText}) {
    return OptionsButton(
      hintText: hintText,
      customSuffixIcon: const SizedBox(),
      controller: OptionController(),
      valueBuilder: (context, item) => const SizedBox(),
      onPressed: () {},
    );
  }

  factory OptionsButton.empty() {
    return OptionsButton(
      hintText: '...',
      controller: OptionController(),
      valueBuilder: (context, item) => const SizedBox(),
      onPressed: () {},
    );
  }

  factory OptionsButton.loading() {
    return OptionsButton(
      hintText: Translate.s.loadingText,
      controller: OptionController(),
      valueBuilder: (context, item) => const AppLoaderWidget.smallProgress(),
      onPressed: () {},
    );
  }
}

class _OptionsButtonState<T> extends State<OptionsButton<T>> {
  @override
  Widget build(BuildContext context) {
    if (widget.iconPath != null) {
      assert(widget.iconPath!.toLowerCase().endsWith('svg'));
    }
    if (widget.showDecoration) {
      return GestureDetector(
        onTap: widget.onPressed,
        child: OptionButtonDecoration(
          constraints: widget.constraints,
          border: widget.border,
          child: Row(
            children: [
              /// Prefix with width 44 like TextFormField
              Expanded(
                child: Row(
                  children: [
                    if (widget.iconPath != null)
                      SizedBox(
                        width: 20,
                        child: SizedBox.square(
                            dimension: 18,
                            child: SvgPicture.asset(
                              widget.iconPath!,
                              color: widget.coloredIconWhenValueFilled &&
                                      widget.controller.selectedValue != null
                                  ? context.colors.blackOpacity
                                  : context.colors.blackOpacity,
                              fit: BoxFit.contain,
                            )),
                      ),
                    if (widget.iconPath != null) Gaps.hGap12,

                    /// Value
                    Expanded(
                        child: _ValueBuilder(
                            controller: widget.controller,
                            hintText: widget.hintText,
                            valueBuilder: widget.valueBuilder)),
                    customSuffixIcon(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: widget.onPressed,
        child: _ValueBuilder(
            controller: widget.controller,
            hintText: widget.hintText,
            valueBuilder: widget.valueBuilder),
      );
    }
  }

  Widget customSuffixIcon() {
    return BlocBuilder<OptionController<T>, OptionControllerState<T>>(
      bloc: widget.controller,
      buildWhen: (previous, current) => previous != current,
      builder: (context, _) {
        bool isNotAnEmptyList = (widget.controller.selectedValue is List
            ? (widget.controller.selectedValue as List).isNotEmpty
            : true);
        return Row(
          children: [
            if (widget.controller.selectedValue != null &&
                isNotAnEmptyList &&
                widget.showClearIcon) ...[
              /// Clear icon
              if (widget.onClearPressed != null)
                InkWell(
                  onTap: () {
                    widget.controller.clear();
                    widget.onClearPressed?.call();
                  },
                  child: Icon(
                    Icons.clear,
                    size: 22,
                    color: context.colors.blackDark,
                  ),
                ),

              /// Padding
              widget.customSuffixIcon == null ? Gaps.hGap5 : Gaps.hGap12
            ],

            /// Suffix
            widget.customSuffixIcon ??
                Icon(Icons.keyboard_arrow_down_rounded,
                    size: 24, color: context.colors.blackDark),
          ],
        );
      },
    );
  }
}

class _ValueBuilder<T> extends StatelessWidget {
  final OptionController<T> controller;
  final String hintText;
  final Function(BuildContext context, T item) valueBuilder;

  const _ValueBuilder(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.valueBuilder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OptionController<T>, OptionControllerState<T>>(
        bloc: controller,
        buildWhen: (previous, current) => previous != current,
        builder: (context, _) {
          return controller.selectedValue == null ||
                  (controller.selectedValue is List &&
                      controller.selectedValue.isBlank == true) ||
                  valueBuilder(context, controller.selectedValue as T) == null
              ? HintText(
                  hintText: hintText,
                )
              : valueBuilder(context, controller.selectedValue as T);
        });
  }
}
