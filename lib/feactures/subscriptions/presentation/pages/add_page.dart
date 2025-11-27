import 'dart:async';
import 'dart:collection';

import 'package:currency_textfield/currency_textfield.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:substrack/core/state_handlers/subscription_state_manager.dart';
import 'package:substrack/core/utils/firts_letter.dart';
import 'package:substrack/core/utils/text_to_color.dart';
import 'package:substrack/core/utils/validators.dart';
import 'package:substrack/core/widgets/buttom_custom.dart';
import 'package:substrack/core/widgets/icon_subscription.dart';
import 'package:substrack/core/widgets/snack_bar_custom.dart';
import 'package:substrack/core/widgets/text_form_field_custom.dart';
import 'package:substrack/feactures/subscriptions/data/models/subscription_model.dart';
import 'package:substrack/feactures/subscriptions/presentation/bloc/subcription_bloc.dart';
import 'package:substrack/tabs_navigation.dart';

typedef DaysEntry = DropdownMenuEntry<DaysLabel>;

class AddOrEditPage extends StatefulWidget {
  final PersistentTabController? tabController;
  final SubscriptionModel? subscriptionToEdit;
  final bool? editPage;

  const AddOrEditPage({
    super.key,
    this.tabController,
    this.editPage = false,
    this.subscriptionToEdit,
  });

  @override
  State<AddOrEditPage> createState() => _AddOrEditPageState();
}

enum DaysLabel {
  seven(7, '7 dias'),
  thirty(30, 'Un Mes'),
  oneYear(365, '1 año'),
  twoYear(730, '2 años');

  static final List<DaysEntry> entries = UnmodifiableListView<DaysEntry>(
    values
        .map<DaysEntry>(
          (DaysLabel day) => DaysEntry(value: day, label: day.label),
        )
        .toList(),
  );
  final int valueDay;

  final String label;

  const DaysLabel(this.valueDay, this.label);
}

class _AddOrEditPageState extends State<AddOrEditPage> {
  bool showCurrentDate = true;
  bool isOtherSelected = false;

  late Color dialogPickerColor;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController planNameController = TextEditingController();
  CurrencyTextFieldController priceController = CurrencyTextFieldController(
    currencySymbol: "",
    decimalSymbol: ".",
    thousandSymbol: "",
    initIntValue: 0000,
  );
  TextEditingController dateController = TextEditingController();
  TextEditingController durationDayController = TextEditingController();
  late int durationDay;

  final List<String> options = ["Streaming", "Servicio", "Otro"];
  DateTime? selectedDate;

  final Color defaultColor = const Color(0xFF0F172A);

  String? selectedOption;
  String? valueFirstLetters;

  final List<Color> colors = [
    const Color(0xFFEF4444),
    const Color(0xFFF97316),
    const Color(0xFFEAB308),
    const Color(0xFF84CC16),
    const Color(0xFF10B981),
    const Color(0xFF06B6D4),
    const Color(0xFF3B82F6),
    const Color(0xFF6366F1),
    const Color(0xFF8B5CF6),
    const Color(0xFFD946EF),
    const Color(0xFFE11D48),
    const Color(0xFF0F172A),
  ];

  @override
  Widget build(BuildContext context) {
    ColorScheme colorscheme = Theme.of(context).colorScheme;
    return SubscriptionStateManager(
      builder: (context, state) {
        bool isLoading = state is SubscriptionLoadingState;

        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                resetForm();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Form(
                  key: formKey,
                  child: AutofillGroup(
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: 10,
                        children: [
                          Column(
                            children: [
                              SizedBox(height: 15),

                              IconSubscription(
                                dialogPickerColor: dialogPickerColor,
                                valueFirstLetters: valueFirstLetters,
                                width: 100,
                                height: 100,
                                fontSize: 40,
                              ),

                              const SizedBox(height: 5),

                              Text(
                                'Vista previa del icono',
                                style: TextStyle(
                                  color: colorscheme.onSecondary,
                                  fontSize: 14,
                                ),
                              ),

                              TextFormFieldCustom(
                                controller: nameController,
                                enabled: !isLoading,
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  setState(() {
                                    valueFirstLetters = value;
                                  });
                                },
                                label: const Text("Nombre de la suscripción"),
                                hintText: "Ejem. Netflix",
                                validator: requiredValidator,
                              ),

                              const SizedBox(height: 5),

                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                  ),
                                  child: Text(
                                    textAlign: TextAlign.start,
                                    "Color del Icono",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: colorscheme.onSecondary,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),

                              Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: colors.map((color) {
                                  bool isSelected = color == dialogPickerColor;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        dialogPickerColor = color;
                                      });
                                    },
                                    child: Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        color: color,
                                        shape: BoxShape.circle,
                                        border: isSelected
                                            ? Border.all(
                                                color: Colors.black87,
                                                width: 2,
                                              )
                                            : null,
                                      ),
                                      child: isSelected
                                          ? const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            )
                                          : null,
                                    ),
                                  );
                                }).toList(),
                              ),

                              const SizedBox(height: 12),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          colorPickerDialog();
                                        },
                                        child: Container(
                                          height: 45,
                                          decoration: BoxDecoration(
                                            color: dialogPickerColor,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            border: Border.all(
                                              color: Colors.black12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      '#${dialogPickerColor.toARGB32().toRadixString(16).toUpperCase().substring(2)}',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          Row(
                            spacing: 10,
                            children: [
                              Expanded(
                                child: TextFormFieldCustom(
                                  controller: priceController,
                                  enabled: !isLoading,
                                  keyboardType: TextInputType.number,
                                  autofillHints: const [
                                    AutofillHints.transactionCurrency,
                                  ],
                                  label: const Text("Precio"),
                                  validator: currencyValidator,
                                  hintText: "\$0.00",
                                ),
                              ),

                              Expanded(
                                child: TextFormFieldCustom(
                                  controller: durationDayController,
                                  enabled: !isLoading,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  label: const Text("Duración (Días)"),
                                  validator: numberValidator,
                                  hintText: "30",
                                ),
                              ),
                            ],
                          ),

                          TextFormFieldCustom(
                            controller: planNameController,
                            enabled: !isLoading,
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.text,
                            label: const Text(
                              "Nombre del plan que estas suscrito",
                            ),
                            validator: requiredValidator,
                          ),

                          DropdownButtonFormField(
                            disabledHint: Text('Cargando...'),
                            hint: Text('Selecciona el tipo servicio'),
                            initialValue: selectedOption,
                            decoration: InputDecoration(
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: colorscheme.onSecondary,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            items: options.map<DropdownMenuItem<String>>((
                              String value,
                            ) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: isLoading
                                ? null
                                : (String? newValue) {
                                    setState(() {
                                      selectedOption = newValue;
                                    });
                                  },
                            validator: requiredValidator,
                          ),

                          Row(
                            children: [
                              Checkbox(
                                value: showCurrentDate,
                                onChanged: toggleCurrentDate,
                              ),
                              showCurrentDate
                                  ? const Text("Usar la fecha actual")
                                  : Expanded(
                                      child: TextFormFieldCustom(
                                        enabled: !isLoading || !showCurrentDate,
                                        controller: dateController,
                                        readOnly: true,
                                        onTap: () async => selectDate(context),
                                        hintText: "YYYY/MM/DD",
                                      ),
                                    ),
                            ],
                          ),

                          ButtomCustom(
                            text: 'Añadir',
                            onPressed: onSubmit,
                            loading: isLoading,
                          ),

                          SizedBox(height: 10.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> colorPickerDialog() async {
    return ColorPicker(
      // Use the dialogPickerColor as start and active color.
      color: dialogPickerColor,
      // Update the dialogPickerColor using the callback.
      onColorChanged: (Color color) => setState(() {
        dialogPickerColor = color;
      }),
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodySmall,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },
    ).showPickerDialog(
      context,
      // New in version 3.0.0 custom transitions support.
      transitionBuilder:
          (
            BuildContext context,
            Animation<double> a1,
            Animation<double> a2,
            Widget widget,
          ) {
            final double curvedValue =
                Curves.easeInOutBack.transform(a1.value) - 1.0;
            return Transform(
              transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
              child: Opacity(opacity: a1.value, child: widget),
            );
          },
      transitionDuration: const Duration(milliseconds: 400),
      constraints: const BoxConstraints(
        minHeight: 460,
        minWidth: 300,
        maxWidth: 320,
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    planNameController.dispose();
    priceController.dispose();
    durationDayController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    dialogPickerColor = defaultColor;

    if (widget.editPage == true && widget.subscriptionToEdit != null) {
      final sub = widget.subscriptionToEdit!;

      valueFirstLetters = firstLetters(sub.serviceName);
      nameController.text = sub.serviceName;
      planNameController.text = sub.planName;

      priceController = CurrencyTextFieldController(
        currencySymbol: "",
        decimalSymbol: ".",
        thousandSymbol: "",
        initIntValue: sub.priceInCents,
      );

      if (sub.colorMembership.isNotEmpty) {
        try {
          dialogPickerColor = textToColor(sub.colorMembership);
        } catch (e) {
          dialogPickerColor = defaultColor;
        }
      }

      if (options.contains(sub.category)) {
        selectedOption = sub.category;
      } else {
        selectedOption = "Otro";
        isOtherSelected = true;
      }

      if (sub.startDate != null) {
        showCurrentDate = false;
        selectedDate = sub.startDate;
        dateController.text = DateFormat(
          "yyyy/MM/dd",
          "es_ES",
        ).format(sub.startDate!).split(' ')[0];

        final start = DateTime(
          sub.startDate!.year,
          sub.startDate!.month,
          sub.startDate!.day,
        );
        final end = DateTime(
          sub.nextPaymentDate.year,
          sub.nextPaymentDate.month,
          sub.nextPaymentDate.day,
        );
        final daysDiff = end.difference(start).inDays;
        durationDayController.text = daysDiff.toString();
      }
    }
  }

  void onSubmit() async {
    if (formKey.currentState!.validate()) {
      final completer = Completer();

      SnackBarCustom.loading(context, content: "Guardando...");

      final DateTime finalDate;
      if (showCurrentDate) {
        finalDate = DateTime.now();
      } else {
        if (selectedDate == null) {
          SnackBarCustom.error(
            context,
            content: "Selecciona una fecha de inicio",
          );
          return;
        }
        finalDate = selectedDate!;
      }

      final durationDay = int.parse(durationDayController.text.trim());
      final DateTime nextPaymentDate = DateTime(
        finalDate.year,
        finalDate.month,
        finalDate.day + durationDay,
      );
      if (widget.editPage!) {
        if (widget.subscriptionToEdit == null) {
          SnackBarCustom.error(
            context,
            content: "Error: No se encontró la suscripción original",
          );
          return;
        }

        context.read<SubscriptionBloc>().add(
          EditSubscription(
            completer: completer,
            editSubscription: widget.subscriptionToEdit!.copyWith(
              nextPaymentDate: nextPaymentDate,
              currency: "MXN",
              priceInCents: priceController.intValue,
              category: selectedOption!.trim(),
              planName: planNameController.text.trim(),
              colorMembership: dialogPickerColor.hex,
              serviceName: nameController.text.trim(),
              startDate: finalDate,
            ),
          ),
        );

        try {
          await completer.future;
          if (mounted) {
            resetForm();
            SnackBarCustom.success(
              context,
              content: "¡Suscripción Editada exitosamente!",
            );

            pushScreen(context, screen: TabNavigation());
          }
        } catch (e) {
          if (mounted) {
            SnackBarCustom.error(context, content: e.toString());
          }
        }
      } else {
        context.read<SubscriptionBloc>().add(
          AddSubscription(
            completer: completer,
            subcriptions: SubscriptionModel(
              nextPaymentDate: nextPaymentDate,
              currency: "MXN",
              priceInCents: priceController.intValue,
              category: selectedOption!.trim(),
              planName: planNameController.text.trim(),
              colorMembership: dialogPickerColor.hex,
              serviceName: nameController.text.trim(),
              startDate: finalDate,
              paymentHistory: [
                PaymentHistoryModel(
                  date: finalDate,
                  amountPaid: priceController.intValue,
                ),
              ],
            ),
          ),
        );

        try {
          await completer.future;
          if (mounted) {
            resetForm();
            SnackBarCustom.success(
              context,
              content: "¡Suscripción agregada exitosamente!",
            );

            widget.tabController?.jumpToTab(0);
          }
        } catch (e) {
          if (mounted) {
            SnackBarCustom.error(context, content: e.toString());
          }
        }
      }
    }
  }

  void resetForm() {
    FocusScope.of(context).unfocus();

    nameController.clear();
    planNameController.clear();
    priceController.clear();
    durationDayController.clear();
    dateController.clear();

    if (mounted) {
      setState(() {
        dialogPickerColor = defaultColor;
        selectedOption = null;
        selectedDate = null;
        showCurrentDate = true;
        valueFirstLetters = '';
      });
    }
  }

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        dateController.text = DateFormat(
          "yyyy/MM/dd",
          "es_ES",
        ).format(picked).split(' ')[0];
      });
    }
  }

  void toggleCurrentDate(bool? value) {
    if (showCurrentDate) {
      setState(() {
        showCurrentDate = value!;
        dateController.text = "";
      });
    } else {
      setState(() {
        showCurrentDate = value!;

        dateController.text = DateFormat(
          "yyyy/MM/dd",
          "es_ES",
        ).format(DateTime.now()).split(' ')[0];
      });
    }
  }
}
