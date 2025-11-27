part of 'subcription_bloc.dart';

abstract class SubscriptionState {}

class SubscriptionInitial extends SubscriptionState {}

class SubcriptionAddFailure extends SubscriptionState {}

class SubscriptionLoadedState extends SubscriptionState {
  final List<SubscriptionModel> subscriptions;

  SubscriptionLoadedState({required this.subscriptions});
}

class SubscriptionLoadingState extends SubscriptionState {}

class SubscriptionErrorState extends SubscriptionState {
  final String? message;

  SubscriptionErrorState({this.message});
}

class Subscriptionrefreshed extends SubscriptionState {}

class SubscriptionByIdState extends SubscriptionState {
  final SubscriptionModel? subscription;

  SubscriptionByIdState({required this.subscription});
}

class SubscriptionEditState extends SubscriptionState {
  final SubscriptionModel? editSubscription;

  SubscriptionEditState({required this.editSubscription});
}
