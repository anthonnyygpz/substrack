import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:substrack/core/utils/price_per_unit.dart';
import 'package:substrack/core/utils/text_to_color.dart';
import 'package:substrack/core/widgets/icon_subscription.dart';
import 'package:substrack/feactures/subscriptions/data/models/subscription_model.dart';
import 'package:substrack/feactures/subscriptions/presentation/pages/details_sub_page.dart';

class CardSubcription extends StatefulWidget {
  final SubscriptionModel sub;
  const CardSubcription({super.key, required this.sub});

  @override
  State<CardSubcription> createState() => _CardSubcriptionState();
}

class _CardSubcriptionState extends State<CardSubcription> {
  late PaymentHistoryModel currentSub = widget.sub.paymentHistory![0];
  double progress = 0.0;
  int dayLeft = 0;

  bool isHovered = false;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    final currentDate = DateTime(now.year, now.month, now.day);

    final nextPayment = widget.sub.nextPaymentDate;
    final endDate = DateTime(
      nextPayment.year,
      nextPayment.month,
      nextPayment.day,
    );

    dayLeft = endDate.difference(currentDate).inDays;
    if (dayLeft < 0) dayLeft = 0;

    final startDate =
        widget.sub.startDate ?? endDate.subtract(const Duration(days: 30));
    final start = DateTime(startDate.year, startDate.month, startDate.day);

    final totalDurationInDays = endDate.difference(start).inDays;
    if (totalDurationInDays <= 0) {
      progress = 1.0;
    } else {
      final dayPassed = totalDurationInDays - dayLeft;
      progress = dayPassed / totalDurationInDays;
    }
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorscheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        pushScreen(
          context,
          screen: DetailsSubPage(sub: widget.sub),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onExit: (_) => setState(() {
          isHovered = false;
        }),
        onEnter: (_) => setState(() {
          isHovered = true;
        }),
        child: Card(
          elevation: isHovered ? 8.0 : 4.0,
          surfaceTintColor: isHovered ? colorscheme.onSurface : null,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 10,
                      children: [
                        IconSubscription(
                          dialogPickerColor: Color(
                            int.parse("0xFF${widget.sub.colorMembership}"),
                          ),
                          valueFirstLetters: widget.sub.serviceName,
                          borderRadius: 10,
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.sub.serviceName,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),

                            Text(
                              widget.sub.planName,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(pricePerUnit(widget.sub.priceInCents)),
                        Text("en $dayLeft dias"),
                      ],
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: LinearProgressIndicator(
                    value: progress,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      textToColor(widget.sub.colorMembership),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
