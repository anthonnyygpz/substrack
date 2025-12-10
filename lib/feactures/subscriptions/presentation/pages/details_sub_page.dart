import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:substrack/core/utils/firts_letter.dart';
import 'package:substrack/core/utils/price_per_unit.dart';
import 'package:substrack/core/utils/text_to_color.dart';
import 'package:substrack/core/widgets/icon_subscription.dart';
import 'package:substrack/core/widgets/snack_bar_custom.dart';
import 'package:substrack/feactures/profile/presentation/widgets/icon_text.dart';
import 'package:substrack/feactures/subscriptions/data/models/subscription_model.dart';
import 'package:substrack/feactures/subscriptions/presentation/bloc/subcription_bloc.dart';
import 'package:substrack/feactures/subscriptions/presentation/widgets/card_payment_history.dart';
import 'package:substrack/tabs_navigation.dart';

class DetailsSubPage extends StatefulWidget {
  final SubscriptionModel sub;
  const DetailsSubPage({super.key, required this.sub});

  @override
  State<DetailsSubPage> createState() => _DetailsSubPageState();
}

class _DetailsSubPageState extends State<DetailsSubPage> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colorscheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 500.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Historial de pagos'),
              centerTitle: true,
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  IconSubscription(
                    width: 110,
                    height: 110,
                    fontSize: 55,
                    borderRadius: 35,
                    dialogPickerColor: textToColor(widget.sub.colorMembership),
                    valueFirstLetters: firstLetters(widget.sub.serviceName),
                  ),

                  Text(
                    widget.sub.serviceName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

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
                        pricePerUnit(
                          widget.sub.priceInCents,
                          showSymbol: false,
                        ),
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          height: 1.0,
                        ),
                      ),
                    ],
                  ),

                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.0,
                        color: colorscheme.onSecondary,
                      ),
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

                  IconTextButton(
                    mainAxisSize: MainAxisSize.min,
                    icon: Icon(Icons.edit),
                    text: Text('Editar'),
                    onTap: () => context.push(
                      '/subscription',
                      extra: {
                        "subscriptionToEdit": widget.sub,
                        "editPage": true,
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final PaymentHistoryModel history =
                    widget.sub.paymentHistory![0];
                return Column(
                  spacing: 5,
                  children: [
                    CardPaymentHistory(history: history),
                    Divider(thickness: 0.1, color: colorscheme.onSecondary),
                  ],
                );
              },
              childCount: widget.sub.paymentHistory!.length, // Number of items
              // childCount: 50,
            ),
          ),
        ],
      ),
    );
  }

  void deleteSubs() {
    if (widget.sub.id == null) return;

    context.read<SubscriptionBloc>().add(
      DeletedSubscription(id: widget.sub.id!),
    );

    SnackBarCustom.remove(context);

    pushScreen(context, screen: TabNavigation());
  }
}
