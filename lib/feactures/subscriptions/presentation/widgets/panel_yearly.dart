import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PanelYearly extends StatelessWidget {
  const PanelYearly({super.key});

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
                  Text(
                    "Mensual",
                    style: TextStyle(
                      // color: colorGrey
                    ),
                  ),
                  Text(
                    "\$ 301.80",
                    style: TextStyle(
                      // color: colorDollar
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
