import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:substrack/core/state_handlers/subscription_state_manager.dart';
import 'package:substrack/feactures/auth/presentation/bloc/auth_bloc.dart';
import 'package:substrack/feactures/subscriptions/data/models/subscription_model.dart';
import 'package:substrack/feactures/subscriptions/presentation/bloc/subcription_bloc.dart';
import 'package:substrack/feactures/subscriptions/presentation/pages/search_subscription_page.dart';
import 'package:substrack/feactures/subscriptions/presentation/widgets/card_subcription.dart';
import 'package:substrack/feactures/subscriptions/presentation/widgets/user_menu.dart';

class SubcriptionListPage extends StatefulWidget {
  const SubcriptionListPage({super.key});

  @override
  State<SubcriptionListPage> createState() => _SubcriptionListPageState();
}

class _SubcriptionListPageState extends State<SubcriptionListPage> {
  SearchController searchController = SearchController();
  late SubscriptionBloc subcriptionBloc;

  @override
  void initState() {
    subcriptionBloc = BlocProvider.of<SubscriptionBloc>(context, listen: false);

    subcriptionBloc.add(LoadedSubscriptions());
    super.initState();
  }

  Future<void> handleRefresh() async {
    context.read<SubscriptionBloc>().add(LoadedSubscriptions());
    context.read<AuthBloc>().add(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorscheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: SubscriptionStateManager(
          builder: (context, state) {
            bool isLoading = state is SubscriptionLoadingState;

            List<SubscriptionModel> subscriptions = [];
            if (state is SubscriptionLoadedState) {
              subscriptions = state.subscriptions;
            }

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: RefreshIndicator(
                onRefresh: handleRefresh,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserMenu(),
                    SizedBox(height: 20),

                    GestureDetector(
                      onTap: () {
                        pushScreen(
                          context,
                          screen: const SearchSubscriptionPage(),
                        );
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: colorscheme.surfaceContainer,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: colorscheme.onSecondary,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Buscar...',
                                style: TextStyle(
                                  color: colorscheme.onSecondary,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    Row(
                      children: [
                        // PanelYearly(),
                        // PanelMonthly(totalPrice: totalMonthly),
                      ],
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Activos(${subscriptions.isEmpty ? subscriptions.length : 0})",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    if (subscriptions.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          itemCount: subscriptions.length,
                          itemBuilder: (BuildContext context, int index) {
                            final SubscriptionModel item = subscriptions[index];
                            return CardSubcription(sub: item);
                          },
                        ),
                      )
                    else if (isLoading)
                      Center(child: CircularProgressIndicator())
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Center(child: Text('No hay suscripciones.')),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
