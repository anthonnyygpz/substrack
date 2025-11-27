import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:substrack/feactures/subscriptions/data/models/subscription_model.dart';
import 'package:substrack/feactures/subscriptions/domain/repositories/isubcription_repository.dart';

part 'subcription_event.dart';
part 'subcription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final ISubscriptionRepository _subsRepository;

  SubscriptionBloc({required ISubscriptionRepository subRepository})
    : _subsRepository = subRepository,
      super(SubscriptionInitial()) {
    on<LoadSubscriptions>(_loadSubscriptions);
    on<AddSubscription>(_onAddSubscription);
    on<SearchSubscriptions>(_searchSubscription);
    on<SubcriptionRefreshed>(_refreshAll);
    on<SubscriptionRemoveEvent>(_removeSubcription);
    on<SubscriptionByIdEvent>(_subscriptionByid);
    on<EditSubscription>(_onEditSubscription);
  }

  void _onAddSubscription(
    AddSubscription event,
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
      emit(SubscriptionErrorState(message: e.toString()));
      event.completer?.completeError(e);
    }
  }

  void _onEditSubscription(
    EditSubscription event,
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

  void _loadSubscriptions(
    LoadSubscriptions event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionLoadingState());
    try {
      final subscriptions = await _subsRepository.fetchSubscriptions();
      emit(SubscriptionLoadedState(subscriptions: subscriptions));
    } catch (e) {
      emit(SubscriptionErrorState(message: e.toString()));
    }
  }

  void _refreshAll(
    SubscriptionEvent event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionLoadingState());
    try {
      final subscriptions = await _subsRepository.fetchSubscriptions();
      emit(SubscriptionLoadedState(subscriptions: subscriptions));
    } catch (e) {
      emit(SubscriptionErrorState(message: e.toString()));
    }
  }

  void _removeSubcription(
    SubscriptionRemoveEvent event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionLoadingState());
    final id = event.id;

    try {
      await _subsRepository.removeSubscription(id: id);

      final subscriptions = await _subsRepository.fetchSubscriptions();
      emit(SubscriptionLoadedState(subscriptions: subscriptions));
    } catch (e) {
      emit(SubscriptionErrorState(message: e.toString()));
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
      emit(SubscriptionErrorState(message: e.toString()));
    }
  }

  void _subscriptionByid(
    SubscriptionByIdEvent event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionLoadingState());

    final id = event.id;
    if (id == null) return;
    try {
      final subscription = await _subsRepository.fetchSubscription(id: id);

      emit(SubscriptionByIdState(subscription: subscription));
    } catch (e) {
      emit(SubscriptionErrorState(message: e.toString()));
    }
  }
}
