import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:substrack/core/theme/colors.dart';
import 'package:substrack/core/utils/price_per_unit.dart';

class PanelMonthly extends StatelessWidget {
  final int? totalPrice;
  const PanelMonthly({super.key, this.totalPrice = 0});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        // color: colorFill,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 15,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Mensual"),
                  Text(
                    pricePerUnit(totalPrice!),
                    style: TextStyle(
                      color: AppColors.colorDollar,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusGeometry.circular(100),
                  // color: colorSecondary,
                ),
                child: Icon(CupertinoIcons.money_dollar),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
