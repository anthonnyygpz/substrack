import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:substrack/core/state_handlers/subscription_state_manager.dart';
import 'package:substrack/feactures/subscriptions/data/models/subscription_model.dart';
import 'package:substrack/feactures/subscriptions/presentation/bloc/subcription_bloc.dart';
import 'package:substrack/feactures/subscriptions/presentation/widgets/card_subcription.dart';

class SearchSubscriptionPage extends StatefulWidget {
  const SearchSubscriptionPage({super.key});

  @override
  State<SearchSubscriptionPage> createState() => _SearchSubscriptionPageState();
}

class _SearchSubscriptionPageState extends State<SearchSubscriptionPage> {
  late SubscriptionBloc subcriptionBloc;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    subcriptionBloc = BlocProvider.of<SubscriptionBloc>(context, listen: false);
    subcriptionBloc.add(LoadedSubscriptions());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorscheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          onChanged: (value) {
            subcriptionBloc.add(SearchSubscriptions(querySearch: "hola"));
          },
          decoration: InputDecoration(
            hintText: "Buscar suscripcion...",
            hintStyle: TextStyle(color: colorscheme.onSecondary),
          ),
        ),
      ),
      body: SafeArea(
        child: SubscriptionStateManager(
          builder: (context, state) {
            List<SubscriptionModel>? subscriptions;
            if (state is SubscriptionLoadedState) {
              subscriptions = state.subscriptions;
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: subscriptions!.length,
                      itemBuilder: (context, index) {
                        final sub = subscriptions![index];
                        return CardSubcription(sub: sub);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
