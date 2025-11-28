import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:substrack/core/utils/global_error_traslator.dart';
import 'package:substrack/feactures/subscriptions/data/models/subscription_model.dart';
import 'package:substrack/feactures/subscriptions/domain/repositories/isubcription_repository.dart';

part 'subcription_event.dart';
part 'subcription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final ISubscriptionRepository _subsRepository;

  SubscriptionBloc({required ISubscriptionRepository subRepository})
    : _subsRepository = subRepository,
      super(SubscriptionInitial()) {
    on<LoadedSubscriptions>(_onLoadedSubscriptions);
    on<AddedSubscription>(_onAddedSubscription);
    on<SearchSubscriptions>(_searchSubscription);
    on<DeletedSubscription>(_onDeletedSubscription);
    on<FetchedByIdSubscription>(_onFetchedByIdSubscription);
    on<UpdatedSubscription>(_onUpdatedSubscription);
  }

  void _onAddedSubscription(
    AddedSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionLoadingState());
    final newSubscription = event.subcriptions;
    if (newSubscription == null) return;

    try {
      await _subsRepository.addSubscription(newSubscription: newSubscription);
      final subscriptions = await _subsRepository.fetchSubscriptions();
      emit(SubscriptionLoadedState(subscriptions: subscriptions));

      event.completer?.complete();
    } catch (e) {
      final friendlyMessage = GlobalErrorTranslator.translate(e);
      emit(SubscriptionErrorState(message: friendlyMessage));
      event.completer?.completeError(e);
    }
  }

  void _onDeletedSubscription(
    DeletedSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionLoadingState());
    final id = event.id;

    try {
      await _subsRepository.removeSubscription(id: id);

      final subscriptions = await _subsRepository.fetchSubscriptions();
      emit(SubscriptionLoadedState(subscriptions: subscriptions));
    } catch (e) {
      final friendlyMessage = GlobalErrorTranslator.translate(e);
      emit(SubscriptionErrorState(message: friendlyMessage));
    }
  }

  void _onFetchedByIdSubscription(
    FetchedByIdSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionLoadingState());

    final id = event.id;
    if (id == null) return;
    try {
      final subscription = await _subsRepository.fetchSubscription(id: id);

      emit(SubscriptionByIdState(subscription: subscription));
    } catch (e) {
      final friendlyMessage = GlobalErrorTranslator.translate(e);
      emit(SubscriptionErrorState(message: friendlyMessage));
    }
  }

  void _onLoadedSubscriptions(
    LoadedSubscriptions event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionLoadingState());
    try {
      final subscriptions = await _subsRepository.fetchSubscriptions();
      emit(SubscriptionLoadedState(subscriptions: subscriptions));
    } catch (e) {
      final friendlyMessage = GlobalErrorTranslator.translate(e);
      emit(SubscriptionErrorState(message: friendlyMessage));
    }
  }

  void _onUpdatedSubscription(
    UpdatedSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionLoadingState());
    final editSubscription = event.editSubscription;

    if (editSubscription == null) return;

    try {
      await _subsRepository.editSubscription(subscription: editSubscription);

      final subscription = await _subsRepository.fetchSubscriptions();
      emit(SubscriptionLoadedState(subscriptions: subscription));

      event.completer?.complete();
    } catch (e) {
      emit(SubscriptionErrorState(message: e.toString()));
      event.completer?.completeError(e);
    }
  }

  void _searchSubscription(
    SearchSubscriptions event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionLoadingState());
    try {
      final querySearch = event.querySearch?.toLowerCase();
      if (querySearch == null) {
        return;
      }
    } catch (e) {
      final friendlyMessage = GlobalErrorTranslator.translate(e);
      emit(SubscriptionErrorState(message: friendlyMessage));
    }
  }
}
