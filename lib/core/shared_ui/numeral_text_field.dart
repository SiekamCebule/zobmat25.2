import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:zobmat25_2/core/shared_ui/help_icon_button.dart';
import 'package:zobmat25_2/core/util/decimal_places.dart';
import 'package:zobmat25_2/core/util/flutter_text_formatters.dart';

class NumeralTextField extends StatefulWidget {
  const NumeralTextField({
    super.key,
    required this.formKey,
    this.enabled = true,
    required this.controller,
    this.additionalButtons,
    required this.onSubmit,
    this.formatters = const [],
    required this.labelText,
    this.skipPlusMinusButtons = false,
    this.suffixText,
    required this.step,
    required this.min,
    required this.max,
    this.initial,
    this.focusNode,
    this.maxDecimalPlaces,
    this.onHelpButtonTap,
    this.helpButtonTooltip,
    this.validator,
  }) : assert(initial == null || (initial >= min && initial <= max));

  final GlobalKey formKey;
  final bool enabled;
  final VoidCallback onSubmit;
  final TextEditingController controller;
  final List<TextInputFormatter> formatters;
  final List<Widget>? additionalButtons;
  final bool skipPlusMinusButtons;
  final String labelText;
  final String? suffixText;
  final num step;
  final num min;
  final num max;
  final num? initial;
  final FocusNode? focusNode;
  final int? maxDecimalPlaces;
  final VoidCallback? onHelpButtonTap;
  final String? helpButtonTooltip;
  final String? Function(String? value)? validator;

  @override
  State<NumeralTextField> createState() => NumeralTextFieldState();
}

class NumeralTextFieldState extends State<NumeralTextField> {
  @override
  void initState() {
    if (widget.initial != null) {
      widget.controller.text = widget.initial.toString();
    } else {
      widget.controller.text = widget.min.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurfaceVariant),
    );
    final showHelpButton = widget.onHelpButtonTap != null;

    final textField = IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              key: widget.formKey,
              enabled: widget.enabled,
              controller: widget.controller,
              decoration: InputDecoration(
                label: Text(widget.labelText),
                border: border,
                enabledBorder: border,
                suffixText: widget.suffixText,
              ),
              inputFormatters: _inputFormatters,
              onEditingComplete: () => _onTextFieldChange(),
              onFieldSubmitted: (value) => _onTextFieldChange(),
              onTapOutside: (_) => _onTextFieldChange(),
              validator: widget.validator,
              focusNode: widget.focusNode,
            ),
          ),
          ...widget.additionalButtons ?? [],
          if (!widget.skipPlusMinusButtons) ...[
            IconButton(
              onPressed:
                  widget.enabled
                      ? () {
                        var decremented = _numberFromController - widget.step;
                        if (widget.maxDecimalPlaces != null) {
                          decremented = preparedNumber(decremented.toDouble());
                        }
                        _updateController(decremented.toString());
                        _onTextFieldChange();
                      }
                      : null,
              icon: const Icon(Symbols.remove),
            ),
            IconButton(
              onPressed:
                  widget.enabled
                      ? () {
                        var incremented = _numberFromController + widget.step;
                        if (widget.maxDecimalPlaces != null) {
                          incremented = preparedNumber(incremented.toDouble());
                        }
                        _updateController(incremented.toString());
                        _onTextFieldChange();
                      }
                      : null,
              icon: const Icon(Symbols.add_rounded),
            ),
          ],
        ],
      ),
    );

    return showHelpButton
        ? Row(
          children: [
            Expanded(child: textField),
            HelpIconButton(
              onPressed: widget.onHelpButtonTap!,
              tooltip: widget.helpButtonTooltip!,
            ),
          ],
        )
        : textField;
  }

  void _onTextFieldChange() {
    widget.onSubmit();
  }

  double preparedNumber(double number) {
    return double.parse(
      minimizeDecimalPlaces(roundToNDecimalPlaces(number, widget.maxDecimalPlaces!)),
    );
  }

  num get _numberFromController {
    return num.parse(widget.controller.text);
  }

  void _updateController(String text) {
    var textEditingValue = widget.controller.value.copyWith(text: text);
    for (var formatter in _inputFormatters) {
      textEditingValue = formatter.formatEditUpdate(textEditingValue, textEditingValue);
    }
    widget.controller.value = textEditingValue;
  }

  List<TextInputFormatter> get _inputFormatters => [
    ...widget.formatters,
    CommaToPeriodEnforcer(),
    if (widget.maxDecimalPlaces != null)
      NDecimalPlacesEnforcer(decimalPlaces: widget.maxDecimalPlaces!),
  ];
}
