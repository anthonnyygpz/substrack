part of 'subcription_bloc.dart';

abstract class SubscriptionEvent {}

class AddSubscription extends SubscriptionEvent {
  final SubscriptionModel? subcriptions;
  final Completer? completer;

  AddSubscription({this.subcriptions, this.completer});
}

class LoadSubscriptions extends SubscriptionEvent {
  final List<SubscriptionModel?>? subcriptions;

  LoadSubscriptions({this.subcriptions});
}

class SearchSubscriptions extends SubscriptionEvent {
  final String? querySearch;

  SearchSubscriptions({required this.querySearch});
}

class SubcriptionRefreshed extends SubscriptionEvent {}

class SubscriptionRemoveEvent extends SubscriptionEvent {
  final String id;

  SubscriptionRemoveEvent({required this.id});
}

class SubscriptionByIdEvent extends SubscriptionEvent {
  final String? id;

  SubscriptionByIdEvent({required this.id});
}

class EditSubscription extends SubscriptionEvent {
  final SubscriptionModel? editSubscription;
  final Completer? completer;

  EditSubscription({required this.editSubscription, this.completer});
}
