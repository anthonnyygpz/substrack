import 'package:flutter/material.dart';
import 'package:substrack/core/state_handlers/subscription_state_manager.dart';
import 'package:substrack/feactures/subscriptions/data/models/subscription_model.dart';
import 'package:substrack/feactures/subscriptions/presentation/bloc/subcription_bloc.dart';

class SearchSubcriptions extends StatefulWidget {
  final SearchController searchController;
  const SearchSubcriptions({super.key, required this.searchController});

  @override
  State<SearchSubcriptions> createState() => _SearchSubcriptionsState();
}

class _SearchSubcriptionsState extends State<SearchSubcriptions> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colorscheme = Theme.of(context).colorScheme;

    return SubscriptionStateManager(
      builder: (context, state) {
        return SearchAnchor.bar(
          shrinkWrap: true,
          barHintText: "Buscar suscripciones...",
          viewHeaderHintStyle: TextStyle(color: colorscheme.onSecondary),
          barHintStyle: WidgetStateProperty.all<TextStyle>(
            TextStyle(color: colorscheme.onSecondary),
          ),
          searchController: widget.searchController,
          suggestionsBuilder:
              (BuildContext context, SearchController controller) {
                String query = controller.text.toLowerCase();

                List<SubscriptionModel> subscriptions = [];
                if (state is SubscriptionLoadedState) {
                  subscriptions = state.subscriptions;
                }

                List<SubscriptionModel> filretedItem = subscriptions.where((
                  item,
                ) {
                  final bool nameMatches = item.serviceName
                      .toLowerCase()
                      .contains(query);
                  return nameMatches;
                }).toList();

                return filretedItem.map((sub) {
                  return ListTile(
                    title: Text(sub.serviceName),
                    onTap: () {
                      setState(() {
                        controller.closeView(sub.serviceName);
                      });
                    },
                  );
                });
              },
        );
      },
    );
  }
}
