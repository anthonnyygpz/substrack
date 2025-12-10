import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    // Cargamos la lista inicial completa al entrar
    subcriptionBloc.add(LoadedSubscriptions());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;

    return BlocConsumer<SubscriptionBloc, SubscriptionState>(
      listener: (context, state) {
        // Aquí podrías manejar errores con un SnackBar si state is SubscriptionErrorState
      },
      builder: (context, state) {
        final bool isLoading = state is SubscriptionLoadingState;

        // Mantenemos la lista visible si estamos cargando pero ya teníamos datos,
        // o extraemos la lista si el estado es Loaded.
        List<SubscriptionModel>? subscriptions;

        if (state is SubscriptionLoadedState) {
          subscriptions = state.subscriptions;
        }
        // Nota: Si quisieras mantener la lista vieja mientras carga, necesitarías
        // que tu estado Loading tuviera una copia de los datos anteriores.
        // Por ahora, manejaremos la carga mostrando el spinner.

        return Scaffold(
          appBar: AppBar(
            title: TextField(
              controller: searchController,
              autofocus: true, // Es útil que el teclado salga automáticamente
              onChanged: (value) {
                // CORRECCIÓN: Pasamos 'value' en lugar de "hola"
                context.read<SubscriptionBloc>().add(
                  SearchSubscriptions(querySearch: value),
                );
              },
              decoration: InputDecoration(
                hintText: "Buscar suscripción...",
                hintStyle: TextStyle(color: colorscheme.onSecondary),
                border: InputBorder.none,
              ),
              style: TextStyle(color: colorscheme.onSurface),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (isLoading)
                    const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (subscriptions != null && subscriptions.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        itemCount: subscriptions.length,
                        itemBuilder: (context, index) {
                          final sub = subscriptions![index];
                          return CardSubcription(sub: sub);
                        },
                      ),
                    )
                  else if (subscriptions != null && subscriptions.isEmpty)
                    Expanded(
                      child: Center(
                        child: Text(
                          "No se encontraron resultados",
                          style: TextStyle(color: colorscheme.onSurface),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
