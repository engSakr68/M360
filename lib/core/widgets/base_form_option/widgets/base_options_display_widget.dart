import 'package:flutter/material.dart';
import 'package:member360/core/extensions/common_extension.dart';
import 'package:member360/core/widgets/app_text_span_with_seperator.dart';
import 'package:member360/core/widgets/base_form_option/widgets/option_item_widget.dart';

/// Use to display Selected Options in BaseFormOption
class BaseOptionsDisplayWidget<T> extends StatelessWidget {
  final List<T>? selectedOptions;
  final String? Function(T) titleGetter;
  final ValueChanged<T>? onTap;
  final bool clickable;
  const BaseOptionsDisplayWidget({
    super.key,
    required this.selectedOptions,
    required this.titleGetter,
    this.onTap,
    this.clickable = false,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedOptions.isNullOrEmpty) return const SizedBox.shrink();

    /// Single value has only the following case
    if (selectedOptions!.length == 1) {
      return getSingleOptionItem(
          option: selectedOptions!.first, context: context);
    }

    /// MultiValue cases
    return getOptionsWidgetDetailsCase(
        context: context, options: selectedOptions!);
  }

  Widget getSingleOptionItem(
      {required T option, required BuildContext context, String? suffixText}) {
    return OptionItemWidget(
      title: titleGetter(option) ?? "",
      suffixText: suffixText,
      onTap: () {
        onTap?.call(option);
      },
    );
  }

  Widget getMultiOptionsTextSpan() {
    return AppTextSpanWithSeparator(
      textsItems: selectedOptions!
          .map((item) => TextSpanItem(
                title: titleGetter(item) ?? "",
                onTap: () {
                  onTap?.call(item);
                },
              ))
          .toList(),
    );
  }

  /// if pictures list is null the value will displayed as text spans, else the main picture
  /// should appear beside the title.
  Widget getOptionsWidgetDetailsCase(
      {required BuildContext context, required List<T> options}) {
    return getMultiOptionsTextSpan();
  }
}
