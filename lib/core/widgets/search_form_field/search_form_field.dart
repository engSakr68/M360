import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member360/core/localization/translate.dart';
import 'package:member360/core/theme/colors/app_colors.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/core/theme/text/app_text_style.dart';

class SearchFormField extends StatefulWidget {
  final Function(String)? onSubmit;
  final Function(String)? onChange;
  final Function(bool)? onFocus;
  final Color? fillColor;
  final double? expandSearchFieldWidth;

  const SearchFormField({
    super.key,
    this.onSubmit,
    this.onChange,
    this.fillColor,
    this.onFocus,
    this.expandSearchFieldWidth,
  });

  @override
  State<SearchFormField> createState() => _SearchFormFieldState();
}

class _SearchFormFieldState extends State<SearchFormField> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final double _collapsedSearchFieldWidth = 124.w;
  late double _expandSearchFieldWidth;
  bool _isSearchFieldExpand = false;
  final _keyboardVisibilityController = KeyboardVisibilityController();

  @override
  void initState() {
    super.initState();
    _handleDismissKeyboard();

    _focusNode.addListener(() {
      if (mounted) {
        setState(() {
          _isSearchFieldExpand = _focusNode.hasFocus;
          widget.onFocus?.call(_isSearchFieldExpand);
        });
      }
    });
  }

  void _handleDismissKeyboard() {
    _keyboardVisibilityController.onChange.listen((visible) {
      if (mounted) {
        if (!visible) {
          _unfocus(context);
        }
      }
    });
  }

  void _unfocus(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    _expandSearchFieldWidth =
        widget.expandSearchFieldWidth ?? MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: _isSearchFieldExpand
          ? _expandSearchFieldWidth
          : _collapsedSearchFieldWidth,
      height: _isSearchFieldExpand ? 36.h : 32.h,
      padding: EdgeInsets.zero,
      child: TextField(
        focusNode: _focusNode,
        controller: _searchController,
        style: TextStyle(color: context.colors.black),
        maxLines: 1,
        onChanged: widget.onChange,
        textInputAction: TextInputAction.search,
        onSubmitted: widget.onSubmit,
        decoration: InputDecoration(
            hintText: Translate.of(context).search,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
            fillColor: widget.fillColor ?? AppColors.of(context).greyWhite,
            filled: true,
            hintStyle: AppTextStyle.s16_w400(
              color: context.colors.blackOpacity,
            ),
            suffixIcon: _isSearchFieldExpand
                ? InkWell(
                    onTap: () {
                      _searchController.clear();
                      widget.onSubmit?.call(_searchController.text);
                      _unfocus(context);
                    },
                    child: Icon(Icons.clear,
                        color: AppColors.of(context).black, size: 20),
                  )
                : null,
            prefixIcon: InkWell(
              onTap: () {
                if (widget.onSubmit != null) {
                  widget.onSubmit!(_searchController.text);
                }
              },
              child: Icon(Icons.search_rounded,
                  color: AppColors.of(context).blackOpacity, size: 20),
            ),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(99)),
                borderSide: BorderSide.none)),
      ),
    );
  }
}
