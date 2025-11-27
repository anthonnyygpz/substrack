import 'package:substrack/feactures/subscriptions/data/models/subscription_model.dart';

abstract class ISubscriptionRepository {
  Future<void> addSubscription({required SubscriptionModel newSubscription});
  Future<List<SubscriptionModel>> fetchSubscriptions();
  Future<void> removeSubscription({required String id});
  Future<SubscriptionModel?> fetchSubscription({required String id});
  Future<void> editSubscription({required SubscriptionModel subscription});
}
