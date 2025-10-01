import 'package:flutter/material.dart';
import 'package:member360/core/bloc/value_state_manager/value_state_manager_import.dart';
import 'package:member360/core/constants/app_config.dart';
import 'package:member360/core/constants/app_loader_widget.dart';
import 'package:member360/core/constants/gaps.dart';
import 'package:member360/core/extensions/common_extension.dart';
import 'package:member360/core/extensions/string_helper_extension.dart';
import 'package:member360/core/requester/consumer/requester_consumer.dart';
import 'package:member360/core/requester/consumer/requester_state_consumer.dart';
import 'package:member360/core/widgets/base_form_option/base_options_requester.dart';
import 'package:member360/core/widgets/base_form_option/controller/option_controller.dart';
import 'package:member360/core/widgets/base_form_option/sheet/option_sheet_button.dart';
import 'package:member360/core/widgets/base_form_option/widgets/base_options_display_widget.dart';
import 'package:member360/core/widgets/shimmers/base_shimmer_widget.dart';

class BaseFormOption<T> extends StatefulWidget {
  final String bottomSheetTitle;
  final String hintText;
  final bool showSearch;
  final bool isRequired;
  final bool showDecoration;
  final bool isMultiple;
  final bool useFirstAsDefaultIfOneItem;
  final VoidCallback onClearPressed;
  final void Function(List<T>? values, bool iMultiple) onSaveValue;
  final BaseOptionsRequester<T> optionsRequester;
  final List<T>? selectedItems;
  final BaseOptionsDisplayWidget Function(List<T>?) selectedOptionBuilder;
  final Widget Function(T, bool) optionItemBuilder;
  final String? Function(T?) valueIdGetter;
  final String? Function(T?) valueMainTitleGetter;
  final ObsValue<bool?>? addNewOptionEnabledObs;
  final String? addNewOptionButtonText;
  final VoidCallback? onAddNewOptionPressed;

  final String? suffixIconPath;

  const BaseFormOption({
    super.key,
    required this.hintText,
    required this.bottomSheetTitle,
    required this.showSearch,
    required this.showDecoration,
    required this.onClearPressed,
    required this.onSaveValue,
    required this.optionsRequester,
    required this.selectedItems,
    required this.isMultiple,
    required this.selectedOptionBuilder,
    required this.optionItemBuilder,
    required this.valueIdGetter,
    required this.valueMainTitleGetter,
    this.suffixIconPath,
    this.addNewOptionEnabledObs,
    this.addNewOptionButtonText,
    this.onAddNewOptionPressed,
    this.isRequired = true,
    this.useFirstAsDefaultIfOneItem = false,
  });

  @override
  State<BaseFormOption<T>> createState() => _BaseFormOptionState<T>();
}

class _BaseFormOptionState<T> extends State<BaseFormOption<T>> {
  late OptionController<List<T>> _optionController;

  @override
  void initState() {
    _optionController =
        OptionController<List<T>>(defaultValue: widget.selectedItems);
    _reCalculateSelectedItems();
    super.initState();
  }

  /// re calculate selected items to ensure that they are included in options list and they are
  /// resolved
  void _reCalculateSelectedItems() async {
    if (widget.selectedItems.isNullOrEmpty) {
      return;
    }
    List<T>? selectedItems = await _reCalculateSelectedItemsFromRequester();
    _reassignSelectedItems(selectedItems);
  }

  void _reassignSelectedItems(List<T>? calculatedSelectedItems) {
    if (_isNotIdenticalOptionsList(
        incomingSelectedItems: calculatedSelectedItems,
        currentSelectedItems: _optionController.selectedValue)) {
      _optionController.selectedValue = calculatedSelectedItems;
      widget.onSaveValue(calculatedSelectedItems, widget.isMultiple);
    } else if (_isThereAnySelectedNotResolved) {
      _optionController.selectedValue = calculatedSelectedItems;
    }
  }

  bool get _isThereAnySelectedNotResolved {
    return _optionController.selectedValue
            ?.any((element) => widget.valueMainTitleGetter(element).isBlank) ??
        true;
  }

  Future<List<T>?> _reCalculateSelectedItemsFromRequester() async {
    /// Options coming after request in the first page
    List<T> options = List<T>.from(await widget.optionsRequester.options);

    /// Add options coming after selecting search result not included in the first page
    // _optionController.tempValue?.forEach((val) {
    //   if(options.contains(val) == false){
    //     options.add(val);
    //   }
    // });
    return _reCalculateSelectedItemsFromOption(options);
  }

  List<T>? _reCalculateSelectedItemsFromOption(List<T> options) {
    List<T> includedItems = [];
    List<String?> selectedOptionIds = (widget.selectedItems ?? [])
        .map((e) => widget.valueIdGetter(e))
        .toList();
    for (var option in options) {
      if (selectedOptionIds.contains(widget.valueIdGetter(option))) {
        includedItems.add(option);
      }
    }
    return includedItems.isEmpty ? null : includedItems;
  }

  bool _isNotIdenticalOptionsList(
      {List<T>? incomingSelectedItems, List<T>? currentSelectedItems}) {
    if (incomingSelectedItems.isNullOrEmpty &&
        currentSelectedItems.isNetherNullNorEmpty) {
      return true;
    }
    List<String> widgetSelectedItemsIds = incomingSelectedItems
            ?.map((e) => widget.valueIdGetter(e))
            .whereType<String>()
            .toList() ??
        [];
    List<String> optionControllerSelectedItemsIds = currentSelectedItems
            ?.map((e) => widget.valueIdGetter(e))
            .whereType<String>()
            .toList() ??
        [];
    if (widgetSelectedItemsIds.length ==
            optionControllerSelectedItemsIds.length &&
        widgetSelectedItemsIds.every(
            (element) => optionControllerSelectedItemsIds.contains(element))) {
      return false;
    }
    return true;
  }

  @override
  void didUpdateWidget(covariant BaseFormOption<T> oldWidget) {
    if (_isNotIdenticalOptionsList(
        currentSelectedItems: _optionController.selectedValue,
        incomingSelectedItems: widget.selectedItems)) {
      _optionController.selectedValue = widget.selectedItems;
      _reCalculateSelectedItems();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return RequesterStateConsumer(
      requester: widget.optionsRequester,
      listener: (context, state) {
        state.whenOrNull(
          success: (data, isLoading) {
            if (widget.useFirstAsDefaultIfOneItem &&
                _optionController.tempValue.isNullOrEmpty &&
                data.isNetherNullNorEmpty) {
              _setDefaultIfItemsIsOne(data);
            } else {
              _reCalculateSelectedItems();
            }
          },
        );
      },
      builder: (context, state) {
        return OptionSheetButton<List<T>>(
          constraints: BoxConstraints(
              minHeight: AppConfig.textFieldConstrains.minHeight),
          hintText: widget.hintText,
          bottomSheetTitle: widget.bottomSheetTitle,
          controller: _optionController,
          showSearch: true,
          isRequired: widget.isRequired,
          iconPath: widget.suffixIconPath,
          onSearch: widget.optionsRequester.search,
          onClearPressed: widget.onClearPressed,
          showDecoration: widget.showDecoration,
          onAddNewOptionPressed: widget.onAddNewOptionPressed,
          addNewOptionButtonText: widget.addNewOptionButtonText,
          addNewOptionEnabledObs: widget.addNewOptionEnabledObs,
          valueBuilder: (_, items) {
            if (_isThereAnySelectedNotResolved) {
              return BaseShimmerWidget(
                  child: Container(
                width: 20,
                height: 30,
                color: Colors.white,
              ));
            }
            return IgnorePointer(
                ignoring: true, child: widget.selectedOptionBuilder(items));
          },
          onSaveTextPressed: () {
            _optionController.selectedValue = _optionController.tempValue;
            widget.onSaveValue(
                _optionController.selectedValue, widget.isMultiple);
            Navigator.pop(context);
          },
          content: (context) {
            return RequesterConsumer<List<T>>(
              requester: widget.optionsRequester,

              /// TODO Abdelkarim Handle failure and empty case
              failureBuilder: (context, error, _) {
                return Gaps.empty;
              },
              loadingBuilder: (context) {
                return const AppLoaderWidget.largeLogo();
              },
              successBuilder: (context, items) {
                return _itemsBuilder(items);
              },
            );
          },
        );
      },
    );
  }

  void _setDefaultIfItemsIsOne(List<dynamic> data) {
    if (data.length == 1) {
      _optionController.tempValue = [data.first];
      _optionController.selectedValue = _optionController.tempValue;
      widget.onSaveValue(_optionController.selectedValue, widget.isMultiple);
    }
  }

  ListView _itemsBuilder(List<T> items) {
    return ListView.builder(
      itemCount: items.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              _onSelect((items[index]));
            },
            child: widget.optionItemBuilder(
                items[index], _isItemSelected(items[index])));
      },
    );
  }

  bool _isItemSelected(T item) {
    if (widget.isMultiple) {
      return ((_optionController.tempValue) ?? [])
          .map((e) => widget.valueIdGetter(e))
          .toList()
          .contains(widget.valueIdGetter(item));
    }
    return widget.valueIdGetter(item) ==
        widget.valueIdGetter(_optionController.tempValue?.firstOrNull);
  }

  void _onSelect(T item) {
    if (widget.isMultiple) {
      _optionController.tempValue ??= [];
      if (_isItemSelected(item)) {
        List<T> tempList = List.from(_optionController.tempValue ?? []);
        tempList.removeWhere((element) =>
            widget.valueIdGetter(element) == widget.valueIdGetter(item));
        _optionController.tempValue = tempList;
      } else {
        _optionController.tempValue = [
          ..._optionController.tempValue ?? [],
          item
        ];
      }
    } else {
      _optionController.tempValue = [item];
    }
  }
}
