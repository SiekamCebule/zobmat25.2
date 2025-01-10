import 'dart:math';

String minimizeDecimalPlaces(double value) {
  String strValue = value.toString();

  if (strValue.contains('.')) {
    List<String> parts = strValue.split('.');
    if (parts[1] == '0' || parts[1].isEmpty) {
      return parts[0];
    }
    String decimalPart = parts[1].replaceAll(RegExp(r'0*$'), '');
    if (decimalPart.isEmpty) {
      return parts[0];
    }
    return '${parts[0]}.$decimalPart';
  } else {
    return strValue;
  }
}

double roundToNDecimalPlaces(double value, int n) {
  final factor = pow(10, n);
  return (value * factor).round() / factor;
}
