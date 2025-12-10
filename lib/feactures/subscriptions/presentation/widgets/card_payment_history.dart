import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:substrack/core/utils/price_per_unit.dart';
import 'package:substrack/feactures/subscriptions/data/models/subscription_model.dart';

class CardPaymentHistory extends StatelessWidget {
  final PaymentHistoryModel history;

  const CardPaymentHistory({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorscheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Row(
        spacing: 5,
        children: [
          Icon(Icons.check_circle, color: colorscheme.primary, size: 44),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pago en ${DateFormat('MMMM dd \'de\' yyyy', "es_ES").format(history.date)}',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
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
  }
}
