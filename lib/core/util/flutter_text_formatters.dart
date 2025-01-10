import 'package:flutter/services.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  const UpperCaseTextFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class CapitalizeTextFormatter extends TextInputFormatter {
  const CapitalizeTextFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String capitalizedText = _capitalizeEachWord(newValue.text);
    return TextEditingValue(text: capitalizedText, selection: newValue.selection);
  }

  String _capitalizeEachWord(String text) {
    if (text.isEmpty) return text;

    return text
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1);
        })
        .join(' ');
  }
}

class SinglePeriodEnforcer extends TextInputFormatter {
  const SinglePeriodEnforcer();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text;
    // Allow only one period
    if ('.'.allMatches(newText).length <= 1) {
      return newValue;
    }
    return oldValue;
  }
}

class CommaToPeriodEnforcer extends TextInputFormatter {
  const CommaToPeriodEnforcer();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(text: newValue.text.replaceAll(RegExp(r','), '.'));
  }
}

class RemoveExcessiveZerosFormatter extends TextInputFormatter {
  const RemoveExcessiveZerosFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String newText = newValue.text;

    if (newText.startsWith('0') && newText.length > 1) {
      if (newText[1] == ',') {
        return newValue;
      } else {
        final String trimmedText = newText.replaceFirst(RegExp(r'^0+'), '0');
        final int newOffset = trimmedText.length;
        return newValue.copyWith(
          text: trimmedText,
          selection: TextSelection.collapsed(offset: newOffset),
        );
      }
    }

    if (newText == '0') {
      return newValue;
    }

    return newValue;
  }
}

class NumberInRangeEnforcer extends TextInputFormatter {
  const NumberInRangeEnforcer({this.min, this.max});

  final num? min;
  final num? max;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    if (newValue.text == '-') {
      return newValue;
    }
    if (num.tryParse(newValue.text) == null) {
      return oldValue;
    }
    final number = num.parse(newValue.text);
    if (min != null && number < min!) {
      return newValue.copyWith(text: min.toString());
    } else if (max != null && number > max!) {
      return newValue.copyWith(text: max.toString());
    } else {
      return newValue;
    }
  }
}

class NDecimalPlacesEnforcer extends TextInputFormatter {
  const NDecimalPlacesEnforcer({required this.decimalPlaces});

  final int decimalPlaces;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    if (newValue.text == '-') {
      return newValue;
    }
    final value = double.tryParse(newValue.text);
    if (value == null) {
      return oldValue;
    }
    if (decimalPlaces == 0) {
      if (newValue.text.contains('.')) {
        final integerText = newValue.text.split('.').first;
        return newValue.copyWith(
          text: integerText,
          selection: TextSelection.collapsed(offset: integerText.length),
        );
      }
      return newValue;
    }

    final decimalIndex = newValue.text.indexOf('.');
    if (decimalIndex == -1 || newValue.text.length - decimalIndex - 1 <= decimalPlaces) {
      return newValue;
    }
    return oldValue;
  }
}

List<TextInputFormatter> get doubleTextInputFormatters {
  return [
    FilteringTextInputFormatter.allow(RegExp(r'[\d\.,]')),
    const CommaToPeriodEnforcer(),
    const SinglePeriodEnforcer(),
  ];
}
