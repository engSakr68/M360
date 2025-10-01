import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member360/core/constants/dimens.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/core/theme/text/app_text_style.dart';
import 'package:member360/core/widgets/base_form_option/button/option_button_decoration.dart';
import 'package:member360/core/widgets/base_form_option/controller/option_controller.dart';

class AppDropDownButton<T> extends StatefulWidget {
  final List<T>? items;
  final String hintText;
  final OptionController<T>? controller;
  final ValueChanged<T?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;

  final Widget Function(BuildContext context, T item) itemBuilder;

  const AppDropDownButton(
      {super.key,
      this.items,
      this.controller,
      required this.hintText,
      this.onChanged,
      required this.itemBuilder,
      this.selectedItemBuilder});

  @override
  State<AppDropDownButton<T>> createState() => _AppDropDownButtonState<T>();
}

class _AppDropDownButtonState<T> extends State<AppDropDownButton<T>> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OptionController<T>, OptionControllerState<T>>(
        bloc: widget.controller,
        builder: (context, state) {
          return OptionButtonDecoration(
            startPadding: 12,
            child: DropdownButton<T>(
              items: widget.items?.map((e) {
                    return DropdownMenuItem<T>(
                      value: e,
                      onTap: () {
                        widget.onChanged?.call(e);
                      },
                      child: widget.itemBuilder(context, e),
                    );
                  }).toList() ??
                  [],
              onChanged: _onChanged,
              isExpanded: true,
              borderRadius: Dimens.borderRadius5PX,
              value: state.selectedValue,
              underline: const SizedBox(),
              hint: Text(
                widget.hintText,
                style:
                    AppTextStyle.s12_w400(color: context.colors.blackOpacity),
              ),
              icon: Icon(Icons.keyboard_arrow_down_rounded,
                  size: 20, color: context.colors.secondary),
              elevation: 1,
              dropdownColor: context.colors.white,
              selectedItemBuilder: widget.selectedItemBuilder,
            ),
          );
        });
  }

  void _onChanged(T? value) {
    widget.controller?.clear();
    setState(() {
      widget.controller?.selectedValue = value;
    });
    widget.onChanged?.call(value);
  }
}
