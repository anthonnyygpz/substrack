import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:substrack/core/utils/firts_letter.dart';
import 'package:substrack/core/utils/price_per_unit.dart';
import 'package:substrack/core/utils/text_to_color.dart';
import 'package:substrack/core/widgets/icon_subscription.dart';
import 'package:substrack/core/widgets/show_remove_dialog.dart';
import 'package:substrack/core/widgets/snack_bar_custom.dart';
import 'package:substrack/feactures/subscriptions/data/models/subscription_model.dart';
import 'package:substrack/feactures/subscriptions/presentation/bloc/subcription_bloc.dart';
import 'package:substrack/feactures/subscriptions/presentation/widgets/history_payment.dart';
import 'package:substrack/tabs_navigation.dart';

class DetailsSubPage extends StatefulWidget {
  final SubscriptionModel sub;
  const DetailsSubPage({super.key, required this.sub});

  @override
  State<DetailsSubPage> createState() => _DetailsSubPageState();
}

class _DetailsSubPageState extends State<DetailsSubPage> {
  void deleteSubs() {
    if (widget.sub.id == null) return;

    context.read<SubscriptionBloc>().add(
      SubscriptionRemoveEvent(id: widget.sub.id!),
    );

    SnackBarCustom.remove(context);

    pushScreen(context, screen: TabNavigation());
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorscheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  onTap: () => context.push(
                    '/subscription',
                    extra: {"subscriptionToEdit": widget.sub, "editPage": true},
                  ),
                  child: Row(
                    spacing: 10,
                    children: [Icon(Icons.edit), Text('Editar')],
                  ),
                ),

                PopupMenuItem<String>(
                  onTap: () => showRemoveDialog(context, onAccept: deleteSubs),
                  child: Row(
                    spacing: 10,
                    children: [Icon(Icons.delete_outlined), Text('Eliminar')],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconSubscription(
                width: 110,
                height: 110,
                fontSize: 55,
                borderRadius: 35,
                dialogPickerColor: textToColor(widget.sub.colorMembership),
                valueFirstLetters: firstLetters(widget.sub.serviceName),
              ),
            ),

            const SizedBox(height: 5),

            Text(
              widget.sub.serviceName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),

            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: colorscheme.onSecondary),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 5.0,
                ),
                child: Text(
                  widget.sub.category.toUpperCase(),
                  style: TextStyle(
                    color: colorscheme.onSecondary,
                    fontSize: 10,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 5,
              children: [
                Text(
                  '\$',
                  style: TextStyle(
                    fontSize: 22,
                    height: 1.5,
                    color: colorscheme.onSecondary,
                  ),
                ),
                Text(
                  pricePerUnit(widget.sub.priceInCents, showSymbol: false),
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                  ),
                ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Text('Historial de pagos', style: TextStyle(fontSize: 18)),
            ),

            HistoryPayment(subHistoryPayment: widget.sub.paymentHistory ?? []),
          ],
        ),
      ),
    );
  }
}
