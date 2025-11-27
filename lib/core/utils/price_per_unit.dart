import 'package:intl/intl.dart';

String pricePerUnit(int amountInCents, {bool? showSymbol = true}) {
  final format = NumberFormat.currency(
    locale: "es_MX",
    symbol: showSymbol! ? "\$" : "",
    decimalDigits: 2,
  );

  double formattedAmount = amountInCents / 100.0;
  return format.format(formattedAmount);
}
