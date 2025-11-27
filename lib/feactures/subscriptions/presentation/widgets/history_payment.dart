import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:substrack/core/utils/price_per_unit.dart';
import 'package:substrack/feactures/subscriptions/data/models/subscription_model.dart';

class HistoryPayment extends StatelessWidget {
  final List<PaymentHistoryModel>? subHistoryPayment;

  const HistoryPayment({super.key, required this.subHistoryPayment});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorscheme = Theme.of(context).colorScheme;
    if (subHistoryPayment != null && subHistoryPayment!.isEmpty) {
      return Text("No hay pagos registrados.");
    }
    return Expanded(
      child: ListView.builder(
        itemCount: subHistoryPayment!.length,
        itemBuilder: (context, index) {
          final history = subHistoryPayment![index];

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0,
            ),
            child: Row(
              spacing: 5,
              children: [
                Icon(Icons.check_circle, color: colorscheme.primary, size: 34),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pago en ${DateFormat('MMMM dd \'de\' yyyy', "es_ES").format(history.date)}',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      pricePerUnit(history.amountPaid),
                      style: TextStyle(color: colorscheme.onSecondary),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
