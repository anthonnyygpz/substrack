part of 'subcription_bloc.dart';

abstract class SubscriptionEvent {}

class AddedSubscription extends SubscriptionEvent {
  final SubscriptionModel? subcriptions;
  final Completer? completer;

  AddedSubscription({this.subcriptions, this.completer});
}

class LoadedSubscriptions extends SubscriptionEvent {
  final List<SubscriptionModel?>? subcriptions;

  LoadedSubscriptions({this.subcriptions});
}

class SearchSubscriptions extends SubscriptionEvent {
  final String? querySearch;

  SearchSubscriptions({required this.querySearch});
}

class DeletedSubscription extends SubscriptionEvent {
  final String id;

  DeletedSubscription({required this.id});
}

class FetchedByIdSubscription extends SubscriptionEvent {
  final String? id;

  FetchedByIdSubscription({required this.id});
}

class UpdatedSubscription extends SubscriptionEvent {
  final SubscriptionModel? editSubscription;
  final Completer? completer;

  UpdatedSubscription({required this.editSubscription, this.completer});
}
