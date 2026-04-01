import 'package:intl/intl.dart';

class AppFormatters {
  AppFormatters._();

  static final NumberFormat _currency = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 2,
  );

  static final NumberFormat _compactCurrency = NumberFormat.compactCurrency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 1,
  );

  static String currency(double value) => _currency.format(value);

  static String compactCurrency(double value) => _compactCurrency.format(value);

  static String date(DateTime value) => DateFormat('dd MMM yyyy').format(value);

  static String shortDate(DateTime value) =>
      DateFormat('dd/MM/yyyy').format(value);

  static String dateTime(DateTime value) =>
      DateFormat('dd MMM, hh:mm a').format(value);

  static String decimal(double value) {
    if (value == value.roundToDouble()) {
      return value.toStringAsFixed(0);
    }
    return value.toStringAsFixed(2);
  }

  static double? parseDouble(String value) {
    final normalized = value.trim().replaceAll(',', '');
    return double.tryParse(normalized);
  }
}
