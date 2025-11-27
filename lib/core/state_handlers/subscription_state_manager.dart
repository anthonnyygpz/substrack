import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:substrack/core/widgets/snack_bar_custom.dart';
import 'package:substrack/feactures/subscriptions/presentation/bloc/subcription_bloc.dart';

class SubscriptionStateManager extends StatelessWidget {
  final Widget Function(BuildContext context, SubscriptionState state) builder;
  const SubscriptionStateManager({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubscriptionBloc, SubscriptionState>(
      listener: (context, state) {
        if (state is SubscriptionErrorState) {
          SnackBarCustom.error(context, content: state.message.toString());
        }
      },
      builder: (context, state) {
        return builder(context, state);
      },
    );
  }
}
