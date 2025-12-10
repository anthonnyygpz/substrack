import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:substrack/core/widgets/snack_bar_custom.dart';
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

  void showDialogDeleteItem(BuildContext context, String index, String name) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('¿Deseas borrar esta suscripción: $name?'),
          actions: [
            TextButton(onPressed: () => context.pop(), child: Text('Cancelar')),
            TextButton(
              onPressed: () {
                context.read<SubscriptionBloc>().add(
                  DeletedSubscription(id: index),
                );

                context.pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorscheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<SubscriptionBloc, SubscriptionState>(
          listener: (contes, state) {
            if (state is SubscriptionErrorState) {
              SnackBarCustom.error(context, content: state.message.toString());
            }
          },
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

                    InkWell(
                      onTap: () async {
                        await pushScreen(
                          context,
                          screen: const SearchSubscriptionPage(),
                        );
                        if (!context.mounted) return;
                        context.read<SubscriptionBloc>().add(
                          LoadedSubscriptions(),
                        );
                      },
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
                            Icon(Icons.search, color: colorscheme.onSecondary),
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
                        "Activos(${subscriptions.length})",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    if (subscriptions.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          itemCount: subscriptions.length,
                          itemBuilder: (BuildContext context, int index) {
                            final SubscriptionModel item = subscriptions[index];
                            return Slidable(
                              key: Key(item.id!),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                extentRatio: 0.25,
                                children: [
                                  SlidableAction(
                                    onPressed: (context) =>
                                        showDialogDeleteItem(
                                          context,
                                          item.id!,
                                          item.serviceName,
                                        ),
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Borrar',
                                    // Puedes redondear las esquinas si tu card las tiene
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ],
                              ),
                              child: CardSubcription(sub: item),
                            );
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
